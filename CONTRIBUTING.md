# Contributing

This list is intentionally narrow. It catalogs infrastructure that agents can own, consume, or operate directly.

## Add a Resource

Please include:

- Name
- Primary URL
- Docs URL
- Category
- Agent-owned or agent-consumed asset
- Why it belongs here
- Human approvals required
- Minimal smoke test
- Date checked

## Acceptance Criteria

A resource should meet at least one criterion:

- Provisions an internet-facing resource for an agent, such as an inbox, wallet, credential profile, phone number, domain, externally hosted file store, or verified identity.
- Gives the agent a real-world capability it cannot create with local files, local databases, or ordinary software on its own machine.
- Exposes an agent-optimized API, SDK, MCP server, tool catalog, or setup path.
- Manages auth, credentials, payment, identity verification, external delivery, or audit around an agent-owned internet resource.

## Avoid

- Generic agent frameworks without external infrastructure.
- Hosted browser or computer-use providers when the agent already has a local computer.
- Managed memory, vector databases, or note stores when local state is enough.
- Tool/API connector platforms that mainly wrap APIs the agent can already call with delegated credentials.
- Human-gated services in the core categories when the human gate is central to the primitive; put these under `partial-human-gated`.
- Thin wrappers around public APIs unless they solve auth, governance, or agent usability.
- Marketing-only pages with no docs or reproducible setup path.
- Pricing claims that were not checked during the same update.

## Verification

Before opening a pull request, run:

```sh
ruby scripts/validate_repo.rb
ruby test/validate_repo_test.rb
```

If a resource changes how agents should choose or classify infrastructure, add or update a task in `evals/simulated-agent/tasks/` and update `evals/simulated-agent/rubric.yml`.

## Setup Skill Template

Use this structure for `skills/setup-name.md`:

```md
# Set up RESOURCE for an agent

## Purpose

## Primary docs

## Human approval required

## Secrets and accounts

## Setup path

## Smoke test

## Production checks

## Failure modes
```
