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
