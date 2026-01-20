#!/bin/bash
# Validate sitemap.xml includes machine-readable endpoints
# Usage: ./validate_sitemap.sh <base-url>
# Example: ./validate_sitemap.sh https://example.org

set -e

BASE_URL="${1:-https://example.org}"
ENDPOINT="${BASE_URL}/sitemap.xml"

echo "Validating sitemap.xml for ${BASE_URL}"
echo "---"

# Fetch sitemap
echo "1. Fetching sitemap.xml..."
RESPONSE=$(curl -s "${ENDPOINT}")

if [ -z "${RESPONSE}" ]; then
    echo "⚠ WARN: sitemap.xml not found (optional but recommended)"
    exit 0
fi

# Check if contains /llm/ endpoints
LLM_COUNT=$(echo "${RESPONSE}" | grep -o "/llm/" | wc -l | tr -d ' ')

if [ "${LLM_COUNT}" -eq 0 ]; then
    echo "⚠ WARN: sitemap.xml does not contain /llm/ endpoints"
    echo "   Machine-readable endpoints should be included for discovery"
else
    echo "✓ Found ${LLM_COUNT} /llm/ endpoint(s) in sitemap"
fi

# Check robots.txt doesn't block
ROBOTS="${BASE_URL}/robots.txt"
ROBOTS_RESPONSE=$(curl -s "${ROBOTS}" || echo "")

if [ -n "${ROBOTS_RESPONSE}" ]; then
    if echo "${ROBOTS_RESPONSE}" | grep -q "Disallow:.*/llm"; then
        echo "❌ FAIL: robots.txt blocks /llm/ endpoints"
        exit 1
    else
        echo "✓ robots.txt does not block /llm/ endpoints"
    fi
fi

echo ""
echo "✓ Sitemap validation checks passed"
