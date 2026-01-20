#!/bin/bash
# Validate .well-known/llm.json discovery endpoint
# Usage: ./validate_wellknown.sh <base-url>
# Example: ./validate_wellknown.sh https://example.org

set -e

BASE_URL="${1:-https://example.org}"
ENDPOINT="${BASE_URL}/.well-known/llm.json"

echo "Validating .well-known/llm.json for ${BASE_URL}"
echo "---"

# Fetch well-known endpoint
echo "1. Fetching .well-known/llm.json..."
RESPONSE=$(curl -s "${ENDPOINT}")

if [ -z "${RESPONSE}" ]; then
    echo "❌ FAIL: Empty response from ${ENDPOINT}"
    exit 1
fi

# Check if valid JSON
if ! echo "${RESPONSE}" | jq . > /dev/null 2>&1; then
    echo "❌ FAIL: Response is not valid JSON"
    exit 1
fi

echo "✓ Valid JSON response"

# Check required fields
PROTOCOL_NAME=$(echo "${RESPONSE}" | jq -r '.protocolName // empty')
PROTOCOL_VERSION=$(echo "${RESPONSE}" | jq -r '.protocolVersion // empty')
DISCOVERY=$(echo "${RESPONSE}" | jq -r '.discovery // empty')

if [ -z "${PROTOCOL_NAME}" ]; then
    echo "❌ FAIL: Missing protocolName field"
    exit 1
fi

if [ -z "${PROTOCOL_VERSION}" ]; then
    echo "❌ FAIL: Missing protocolVersion field"
    exit 1
fi

if [ "${DISCOVERY}" = "null" ] || [ -z "${DISCOVERY}" ]; then
    echo "❌ FAIL: Missing discovery field"
    exit 1
fi

echo "✓ protocolName: ${PROTOCOL_NAME}"
echo "✓ protocolVersion: ${PROTOCOL_VERSION}"
echo "✓ discovery field present"

# Check llms_txt reference
LLMS_TXT=$(echo "${RESPONSE}" | jq -r '.discovery.llms_txt // empty')
if [ -z "${LLMS_TXT}" ]; then
    echo "⚠ WARN: discovery.llms_txt not found (optional but recommended)"
else
    echo "✓ discovery.llms_txt: ${LLMS_TXT}"
fi

echo ""
echo "✓ All well-known validation checks passed"
