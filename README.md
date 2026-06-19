# Agent-Native Infrastructure Index

An agent-readable map of internet resources that agents can own, consume, or operate directly: inboxes, phone numbers, public webhook endpoints, payment rails, identity-linked checkout credentials, and other assets the agent cannot simply create on its own computer.

This repo is positioned for AI agents first. Human readers are maintainers and auditors. The baseline assumption is that the agent already has full access to a computer; this index covers external internet infrastructure the agent cannot simply spawn on that machine.

Most agent lists focus on frameworks for building agents. This one focuses on external resources an agent needs after it exists, and on how an agent should safely begin using them.

## Agent Entry Point

Agents should start with [llms.txt](llms.txt), then read [data/resources.yml](data/resources.yml). The repository files are the interface; there is no separate web landing page.

1. Read `llms.txt`.
2. Choose a category in `data/resources.yml`.
3. Open the relevant `resources/` category note.
4. Open the relevant `skills/` setup runbook.
5. Stop at any listed human approval gate.

## Scope

Included resources should satisfy at least one of these criteria:

- The service provisions an internet-facing asset for an agent, such as an inbox, wallet, credential profile, verified identity, phone number, public address, domain, or externally hosted file store.
- The service gives the agent a real-world capability it cannot create with local files, local databases, or ordinary software on its own machine.
- The service exposes APIs, SDKs, or agent-readable setup paths for provisioning and operating that asset.
- The public docs make setup reproducible enough for a human-supervised agent to follow.

Excluded by default:

- General agent frameworks with no external infrastructure component.
- Hosted browser or computer-use providers when the only benefit is giving the agent a browser it already has locally.
- Managed memory, vector databases, or note stores when the agent can create equivalent local state on its own computer.
- Tool/API connector platforms when they mainly wrap APIs the agent can already call with delegated credentials.
- Generic SaaS APIs that are useful to agents but not meaningfully agent-oriented.
- Unverified directories or tools without stable public docs.

## Quick Map

| Category | Best starting points | What the agent gets |
| --- | --- | --- |
| Email and inbox | [AgentMail](https://www.agentmail.to/), [Robotomail](https://robotomail.com/), [DropMail](https://dropmail.me/api/) | Real or disposable email addresses, inbox APIs, inbound events, threading, attachments |
| Phone, SMS, and voice | [Retell AI](https://docs.retellai.com/), [Vapi](https://docs.vapi.ai/) | Phone numbers, inbound/outbound calls, SMS hooks, voice-agent routing |
| Public endpoint and webhook inbox | [Hookdeck](https://hookdeck.com/docs) | Public source URLs, webhook ingestion, event inbox, routing, retry, replay, inspection |
| Payments and commerce | [Skyfire](https://skyfire.xyz/), [x402](https://www.x402.org/), [Coinbase x402 docs](https://docs.cdp.coinbase.com/x402/), [Coinbase Agentic Wallet](https://docs.cdp.coinbase.com/agentic-wallet/welcome), [Nevermined](https://nevermined.ai/) | Programmatic payment, identity-linked mandates, wallet or card rails, paid API access, agentic commerce |
| Partial and human-gated | [Partial notes](resources/partial-human-gated.md) | Nearby resources that are useful but require human, business, billing, OAuth, KYC, or approval gates |

## Setup Skills

The `skills/` directory contains short, agent-readable setup runbooks. They are intentionally conservative: they name the human approvals, secrets, smoke tests, and risk controls needed before an agent performs actions.

- [AgentMail inbox](skills/setup-agentmail.md)
- [Robotomail inbox](skills/setup-robotomail.md)
- [DropMail disposable inbox](skills/setup-dropmail.md)
- [Retell AI phone number](skills/setup-retell.md)
- [Vapi phone number](skills/setup-vapi.md)
- [Hookdeck public endpoint](skills/setup-hookdeck.md)
- [x402 payments](skills/setup-x402.md)
- [Coinbase Agentic Wallet](skills/setup-coinbase-agentic-wallet.md)

## Resource Data

The canonical machine-readable list is in [data/resources.yml](data/resources.yml). Keep generated or visual summaries secondary to this file. Human-gated or emerging ideas live under `partial-human-gated` and `gaps` until they have a cleaner agent-first setup path.

## Known Gaps

These are the useful primitives this repo is still looking for:

- Agent-safe account creation broker: no general service was verified for safe account creation across arbitrary third-party websites without human intervention.
- Portable agent identity and reputation: Skyfire KYA and early protocol work cover parts of the problem, but no broadly adopted, portable reputation-bearing agent identity service was verified.
- General signed human approval relay: approval tools exist, but they intentionally require human intervention and should stay separate from autonomous resources.

## Publish

Push the repository to GitHub and let GitHub render the README. Agents should use `llms.txt` and `data/resources.yml` directly instead of scraping a rendered page.

## Security Posture

Agent-native infrastructure can move money, send email, hold credentials, create accounts, and persist personal data. Treat all setup as privileged infrastructure work:

- Require explicit human approval before spending money, sending external messages, creating production accounts, or accessing sensitive user data.
- Prefer scoped API keys, low spending caps, test domains, sandbox wallets, and throwaway inboxes during evaluation.
- Log every agent action that mutates external state.
- Re-check pricing, terms, and compliance before production use.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Good additions include primary docs, setup paths, risk notes, and a minimal smoke test.

## License

MIT. See [LICENSE](LICENSE).
