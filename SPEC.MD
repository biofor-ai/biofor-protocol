# BioFor Protocol — Specification v0.1

This document defines the normative rules of the BioFor declarative identity protocol.

The key words **MUST**, **MUST NOT**, **SHOULD**, and **MAY** are to be interpreted as described in RFC 2119.

---

## 1. Scope

This specification defines:
- declarative identity representation for **Person** and **Organization**
- canonical identifiers
- HTTP and caching behavior
- discovery mechanisms for AI agents

It does not define ranking, training, or inference behavior.

---

## 2. Entity Types

### 2.1 Person Profile

A person profile is represented as a `ProfilePage` whose `mainEntity` is a `Person`.

```json
{
  "@type": "ProfilePage",
  "mainEntity": {
    "@type": "Person"
  }
}

Required fields (Person)
	•	@context
	•	@type
	•	@id
	•	url
	•	mainEntityOfPage
	•	identifier
	•	disambiguatingDescription
	•	sameAs (if authoritative external URLs exist)

⸻

2.2 Organization

Organizations are represented using Organization.

Required fields (Organization)
	•	@context
	•	@type
	•	@id
	•	url
	•	mainEntityOfPage

Legal identifiers MAY be present for organizations.

⸻

3. Canonical Identifiers

Identifiers are stable and environment-independent.

3.1 Fragments

The following fragments are reserved:

Entity	Fragment
ProfilePage	#profile
Person	#person
Organization	#id

Example

https://www.biofor.ai/sebastienneusch#profile
https://www.biofor.ai/sebastienneusch#person
https://www.biofor.ai/org/blvtr#id

Identifiers MUST NOT vary between environments.

⸻

4. sameAs Semantics

The sameAs field MUST:
	•	reference authoritative external profiles when available
	•	NOT include internal BioFor URLs
	•	NOT include organization URLs on Person entities

Examples of valid sameAs targets:
	•	LinkedIn
	•	personal websites
	•	official project pages

⸻

5. Declarative Responsibility

Person entities MUST include a declarative responsibility statement using
disambiguatingDescription.

This statement MUST:
	•	indicate that the data is self-declared
	•	include a last-updated date
	•	identify BioFor as the declarative source

Example:

Self-declared by the person. Last updated 2026-01-18. BioFor is the primary declarative source.


⸻

6. HTTP Contract

6.1 Content Negotiation

Endpoints MUST support content negotiation via Accept.

Accept header	Response type
application/ld+json	JSON-LD
text/html	HTML


⸻

6.2 Required Headers

All machine-readable endpoints MUST include:
	•	Content-Type
	•	Cache-Control
	•	ETag
	•	Vary: Accept, Accept-Language

⸻

6.3 Cache Revalidation

Machine-readable endpoints MUST support:
	•	If-None-Match
	•	304 Not Modified responses

This enables deterministic, low-cost ingestion.

⸻

7. Discovery

BioFor identities MUST be discoverable via:
	•	/llms.txt
	•	/.well-known/llm.json
	•	sitemap.xml
	•	HTTP Link headers:
	•	rel="canonical"
	•	rel="alternate"; type="application/ld+json"

⸻

8. Language Semantics

Language selection MUST be deterministic.
	•	Accept-Language MAY be honored
	•	?lang= query parameter MAY override
	•	HTML responses MUST include a correct <html lang="">

⸻

9. Non-goals

The BioFor protocol does NOT:
	•	infer identity
	•	resolve conflicts automatically
	•	rank entities
	•	modify model training

It only exposes a verifiable identity source.

⸻

10. Versioning

This document defines BioFor Protocol v0.1.

Breaking changes MUST increment the major version.

---
