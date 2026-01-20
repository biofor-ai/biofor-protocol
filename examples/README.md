# Examples

This directory contains illustrative examples of BioFor Protocol entities and endpoints.

## Purpose

These examples demonstrate:
- **Structure**: Required fields and canonical fragments
- **Determinism**: Stable identifiers and predictable responses
- **Machine-readability**: JSON-LD format and HTTP contract compliance

Examples are **non-normative**. They illustrate protocol behavior but do not define it. Refer to `SPEC.MD` for authoritative requirements.

## Files

- `person.jsonld` — Example Person entity (ProfilePage with Person mainEntity)
- `organization.jsonld` — Example Organization entity
- `llm-endpoint.http` — HTTP request/response examples for machine-readable endpoints
- `discovery/llms.txt` — Example discovery file format
- `discovery/well-known-llm.json` — Example well-known discovery endpoint
- `caching.md` — Cache behavior examples and ETag usage

## Notes

- All identifiers are illustrative and do not represent real entities
- HTTP examples show expected contract behavior, not implementation details
- Discovery files demonstrate format requirements, not registry contents
- Cache examples illustrate revalidation patterns, not server configuration

These examples exist to enable protocol validation and integration testing.
