# Partial and Human-Gated Candidates

These are useful nearby resources, but they should not be treated as clean core rows yet. They either are not agent-first, require human or organization setup for the main primitive, or exist mainly to put a human approval gate in front of agent actions.

## Partial Resources

| Primitive | Candidate resources | Why partial |
| --- | --- | --- |
| Agent-owned domain / web presence | Vercel, Cloudflare Domains/DNS | Deployment and DNS APIs exist, but account tokens, billing, domain ownership, and registrar/legal details remain human or organization controlled. |
| External file drop / data room | Vercel Blob, Cloudflare R2 | API-accessible external storage exists, but it is generic cloud storage rather than an agent-first data-room product. |
| Credential delegation vault | Arcade, Composio, Nango | Agents can call tools after setup, but third-party account access usually depends on user OAuth or delegated credential approval. |
| Fiat wallet / virtual card / escrow | Payman, Stripe Issuing, Lithic | Agent-facing or API-first money movement exists, but funding, KYC/KYB, card programs, and payment approval are human-gated. |
| Physical-world address / delivery inbox | LegalZoom Virtual Mail | Provides a real address and digitized mail, but setup requires human/business identity, recipient authorization, and plan purchase. |
| Human approval relay | HumanLayer, Payman approval flows | Useful for governance, but human intervention is the point of the service. |

## Missing or Emerging

| Primitive | Status | Note |
| --- | --- | --- |
| Agent-safe account creation broker | Missing | No general service was verified for account creation across arbitrary third-party websites without human intervention. Skyfire is closest inside participating seller services. |
| Portable agent identity / reputation | Emerging | Skyfire KYA and early protocol work cover pieces, but no broadly adopted, portable reputation-bearing agent identity service was verified. |

## Evaluation Notes

- Keep these separate from core verified resources until the agent can provision and operate the asset through documented APIs with minimal human gating.
- A service can be valuable and still belong here if a human approval step is central to the core flow.
- Generic cloud or SaaS APIs should only graduate to the core list when they expose an agent-first setup path or solve a resource the agent cannot reasonably own otherwise.
