#!/bin/bash
# Validate ETag and cache revalidation behavior
# Usage: ./validate_etag.sh <base-url> <slug>
# Example: ./validate_etag.sh https://example.org alex-example

set -e

BASE_URL="${1:-https://example.org}"
SLUG="${2:-alex-example}"
ENDPOINT="${BASE_URL}/llm/${SLUG}"

echo "Validating ETag and cache behavior for ${ENDPOINT}"
echo "---"

# Fetch initial response
echo "1. Fetching initial response..."
RESPONSE=$(curl -s -i -H "Accept: application/ld+json" "${ENDPOINT}")
ETAG=$(echo "${RESPONSE}" | grep -i "ETag:" | cut -d' ' -f2 | tr -d '\r\n')

if [ -z "${ETAG}" ]; then
    echo "❌ FAIL: No ETag header found"
    exit 1
fi

echo "✓ ETag found: ${ETAG}"

# Check Cache-Control
CACHE_CONTROL=$(echo "${RESPONSE}" | grep -i "Cache-Control:" | cut -d' ' -f2- | tr -d '\r\n')
if [ -z "${CACHE_CONTROL}" ]; then
    echo "❌ FAIL: No Cache-Control header found"
    exit 1
fi

echo "✓ Cache-Control: ${CACHE_CONTROL}"

# Test revalidation with If-None-Match
echo ""
echo "2. Testing revalidation with If-None-Match..."
REVALIDATION=$(curl -s -i -H "Accept: application/ld+json" -H "If-None-Match: ${ETAG}" "${ENDPOINT}")
STATUS=$(echo "${REVALIDATION}" | head -n1 | cut -d' ' -f2)

if [ "${STATUS}" = "304" ]; then
    echo "✓ 304 Not Modified received (correct)"
else
    echo "❌ FAIL: Expected 304, got ${STATUS}"
    exit 1
fi

echo ""
echo "✓ All cache validation checks passed"
