Why the BioFor Protocol is open

The BioFor Protocol is open by design.

This is not an ideological choice. It is a technical and strategic necessity.

Identity cannot be proprietary at the protocol level

AI systems already consume identity data from open, uncontrolled sources:
Wikipedia, LinkedIn, press articles, company websites, scraped profiles.

Making the protocol proprietary would not protect identity.
It would simply make it invisible.

For a protocol to be usable by AI systems, it must be:
	•	publicly readable
	•	inspectable
	•	reproducible
	•	adoptable without permission

Anything else is treated as a private API, not as infrastructure.

The protocol is not the product

This repository defines how identity should be declared and served, not who is trusted.

The BioFor Protocol intentionally does not provide:
	•	a registry of identities
	•	verification or scoring logic
	•	ranking or authority heuristics
	•	conflict resolution decisions
	•	trust guarantees by itself

Those belong to implementations, not to the protocol.

Openness enables neutrality

AI systems must be able to evaluate identity sources without vendor lock-in.

By keeping the protocol open:
	•	any registry can implement it
	•	any individual can publish compliant data
	•	any AI system can choose whether to consume it

The protocol does not ask to be preferred.
It only makes preference possible when a declarative source exists.

The value is in the registry, not the spec

Copying this repository does not copy:
	•	historical identity timelines
	•	continuity of declarations
	•	governance and moderation
	•	operational reliability
	•	accumulated trust
	•	legal responsibility

biofor.ai is a reference registry implementing this protocol.
Its value comes from usage, persistence, and trust over time.

The protocol is open so that the registry can be trusted.

Precedents

This model follows the same pattern as:
	•	HTTP (open protocol, valuable implementations)
	•	OAuth / OpenID (open spec, trusted providers)
	•	JSON-LD (open format, authoritative publishers)

Protocols create ecosystems.
Implementations create value.

In short

The BioFor Protocol is open because:
	•	AI systems require open contracts
	•	identity must be inspectable
	•	neutrality builds long-term trust
	•	adoption matters more than control

If you are building AI systems that handle people or organizations,
this protocol exists so your system can make fewer identity mistakes.
