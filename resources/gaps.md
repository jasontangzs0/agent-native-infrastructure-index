# Known Gaps

These primitives are useful for autonomous agents, but this repository has not verified a clean, broadly usable, agent-first service for them yet.

## Missing or Emerging Primitives

| Primitive | Status | Closest current fit | Why it remains a gap |
| --- | --- | --- | --- |
| Agent-safe account creation broker | Missing | Skyfire inside participating seller services | No general broker was verified for safe account creation across arbitrary third-party websites without human intervention. |
| Portable agent identity and reputation | Emerging | Skyfire KYA and early agent identity protocol work | Verified identity tokens exist, but no broadly adopted portable reputation-bearing agent identity service was verified. |
| General signed human approval relay | Partial by design | HumanLayer and Payman approval flows | Approval relays are useful, but they intentionally require human intervention and should stay separate from autonomous resources. |

## Evaluation Notes

- Do not promote a gap to the core list until the agent can provision or use the resource through stable public docs and agent-readable setup paths.
- If the main primitive requires KYC, OAuth consent, business setup, billing, or human approval as a central step, place it under `partial-human-gated` instead.
- If a provider solves the primitive only inside its own closed ecosystem, keep it as a closest fit rather than a clean answer.

## What Would Graduate A Gap

- Public primary docs for agent-oriented setup
- API, SDK, MCP, or equivalent programmable access
- Clear ownership model for the agent or supervising human
- Explicit human approval gates and safety controls
- Minimal smoke test that does not require production side effects
