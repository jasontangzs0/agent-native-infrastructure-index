# Verification

This repository should be useful to an AI agent, not just readable by a human. Verification has two layers: static validation and simulated-agent usability testing.

## Static Validation

Run:

```sh
ruby scripts/validate_repo.rb
ruby test/validate_repo_test.rb
```

The validator checks that:

- `data/resources.yml` parses as YAML
- every category has a matching `resources/*.md` note
- every non-null `setup_skill` path exists
- every resource has required fields and human approval gates
- every partial resource has a `partial_reason`
- every gap in `data/resources.yml` is listed in the README
- simulated-agent eval tasks referenced by the rubric exist
- repository text stays ASCII-only
- stale references to removed browser, runtime, memory, tool-access, and HTML page files do not reappear in content files

## Simulated-Agent Usability Testing

Use `evals/simulated-agent/` to test whether a fresh agent can use the repo correctly without credentials or external side effects.

Run one task at a time:

1. Start a fresh AI-agent session.
2. Give the agent one file from `evals/simulated-agent/tasks/`.
3. Let the agent inspect this repo.
4. Score the answer with `evals/simulated-agent/rubric.yml`.
5. Record the model, date, task id, score, and failure notes in an issue, pull request, or a copy of `evals/simulated-agent/results/TEMPLATE.md`.

An answer should pass only when the agent starts from the agent entrypoint, reads the canonical YAML, chooses the right category, distinguishes verified resources from partials and gaps, opens setup runbooks when appropriate, and stops at human approval gates.

## Live Sandbox Testing

Live tests are optional and should be narrow. Run them only with explicit human approval and low-risk resources.

Good first live candidates:

- DropMail: create a disposable inbox and receive a test message.
- Hookdeck: create a test source URL and send a synthetic event.

Avoid live tests for phone numbers, payments, wallets, cards, domains, identity verification, KYC/KYB, production webhooks, or outbound messages unless a human has approved scope, budget, compliance posture, and cleanup steps.
