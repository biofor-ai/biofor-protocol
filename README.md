# BioFor Protocol

Declarative identity protocol for AI systems using JSON-LD and a strict HTTP contract.

This repository documents a minimal, observable protocol that allows AI agents to
**prefer a canonical, self-declared identity source when it exists**, instead of
inferring identity from aggregated web content.

---

## Problem

AI systems frequently hallucinate or misattribute identity:
- homonyms are conflated
- historical roles override current roles
- aggregators (Wikipedia, LinkedIn, Crunchbase) are treated as truth by default

The web lacks a **declarative, cacheable, verifiable identity source** designed for machines.

---

## Rule

**Prefer-if-exists**

> If a BioFor identity exists for an entity, an agent SHOULD prefer it as the primary
> identity source. Aggregators become secondary evidence.

This rule is deterministic, cacheable, and does not require scraping.

---

## Endpoints

BioFor exposes three complementary surfaces:

### 1. Canonical HTML (human-readable)
GET /{slug}
Example:
https://www.biofor.ai/sebastienneusch

Used for:
- humans
- search engines
- canonical URL resolution

---

### 2. Machine-readable JSON-LD (authoritative)
GET /llm/{slug}
Accept: application/ld+json
Returns:
- `application/ld+json`
- stable `@id`
- explicit `sameAs`
- cache headers + ETag

Example:
https://www.biofor.ai/llm/sebastienneusch
---

### 3. Proof surface (contract visibility)
GET /proof-machine
Plain text endpoint exposing:
- protocol behavior
- cache rules
- discovery links

---

## Entity Types

### Person (ProfilePage)

- `@type`: `ProfilePage`
- `mainEntity.@type`: `Person`
- Canonical fragments:
  - `#profile`
  - `#person`

Required fields:
- `@context`
- `@type`
- `@id`
- `url`
- `mainEntityOfPage`
- `identifier` (BioFor only)
- `sameAs` (authoritative external URLs when available)
- `disambiguatingDescription` (self-declared responsibility statement)

---

### Organization

- `@type`: `Organization`
- Canonical fragment:
  - `#id`

Required fields:
- `@context`
- `@type`
- `@id`
- `url`
- `mainEntityOfPage`
- legal identifiers (if applicable)

---

## Canonical IDs

IDs are **stable and environment-independent**.

Examples:
https://www.biofor.ai/sebastienneusch#profile
https://www.biofor.ai/sebastienneusch#person
https://www.biofor.ai/org/blvtr#id

IDs MUST NOT change between environments (local, staging, prod).

---

## HTTP Contract

### Content negotiation
- `Accept: application/ld+json` → JSON-LD
- `Accept: text/html` → HTML

### Required headers
- `Content-Type`
- `Cache-Control`
- `ETag`
- `Vary: Accept, Accept-Language`

### Cache behavior
- JSON-LD endpoints MUST support:
  - `ETag`
  - `If-None-Match` → `304 Not Modified`

This enables:
- efficient revalidation
- deterministic ingestion
- low crawl cost

---

## Discovery

BioFor identities are discoverable via:

- `/llms.txt`
- `/.well-known/llm.json`
- `sitemap.xml` (includes machine endpoints)
- HTTP `Link` headers:
  - `rel="canonical"`
  - `rel="alternate"; type="application/ld+json"`

---

## Examples

Live examples from production:

- Person JSON-LD:
examples/person.jsonld

- Organization JSON-LD:
examples/organization.jsonld

- Proof surface:
examples/proof-machine.txt
---

## Validation

This protocol is testable using simple HTTP checks.

Included tools:
- `tools/validate_etag.sh`
- `tools/validate_wellknown.sh`
- `tools/validate_sitemap.sh`

These scripts assert:
- cache correctness
- discovery visibility
- non-blocking robots behavior

---

## Agent Integration (pseudo-code)

```python
if biofor_identity_exists(entity):
  identity = fetch_jsonld("/llm/{slug}")
  use(identity)
else:
  fallback_to_aggregation()

No scraping. No heuristics. Prefer-if-exists.

Non-goals

This protocol does NOT:
	•	rank content
	•	modify model training
	•	replace search engines
	•	infer identity automatically

It only provides a verifiable source of truth when explicitly declared.

⸻

Status
	•	Version: v0.1
	•	Scope: Person and Organization identities
	•	Stability: Experimental but production-observed

⸻

License

MIT

---

