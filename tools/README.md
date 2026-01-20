# Validation Tools

Simple HTTP-based validation scripts for BioFor Protocol compliance.

## Requirements

- `curl`
- `jq` (for JSON validation)
- `bash`

## Usage

### Validate ETag and Cache Behavior

Tests ETag presence, Cache-Control headers, and 304 revalidation:

```bash
./validate_etag.sh <base-url> <slug>
```

Example:
```bash
./validate_etag.sh https://example.org alex-example
```

### Validate .well-known/llm.json

Checks discovery endpoint structure and required fields:

```bash
./validate_wellknown.sh <base-url>
```

Example:
```bash
./validate_wellknown.sh https://example.org
```

### Validate Sitemap

Verifies sitemap.xml includes machine-readable endpoints and robots.txt doesn't block:

```bash
./validate_sitemap.sh <base-url>
```

Example:
```bash
./validate_sitemap.sh https://example.org
```

## Running All Validations

```bash
BASE_URL="https://example.org"
SLUG="alex-example"

./validate_etag.sh "${BASE_URL}" "${SLUG}"
./validate_wellknown.sh "${BASE_URL}"
./validate_sitemap.sh "${BASE_URL}"
```

These scripts assert:
- Cache correctness (ETag, Cache-Control, 304 responses)
- Discovery visibility (.well-known/llm.json structure)
- Non-blocking robots behavior
