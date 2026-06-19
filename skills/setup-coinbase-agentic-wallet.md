# Set up Coinbase Agentic Wallet for an agent

## Purpose

Give an agent a wallet-capable payment path for x402 services and approved onchain actions, with human-controlled funding and spending limits.

## Primary Docs

- Agentic Wallet: https://docs.cdp.coinbase.com/agentic-wallet/welcome
- Agentic Wallet MCP: https://docs.cdp.coinbase.com/agentic-wallet/mcp/welcome
- CDP for Agents CLI/MCP: https://docs.cdp.coinbase.com/get-started/build-with-ai/cdp-for-agents
- Agent-readable docs index: https://docs.cdp.coinbase.com/llms.txt

## Human Approval Required

- Authenticating a Coinbase account
- Creating or connecting a wallet
- Adding funds or using onramp
- Setting per-call and per-session spending limits
- Sending, trading, or paying with real money
- Enabling autonomous access to paid services

## Secrets and Accounts

- Coinbase account or CDP account
- Optional embedded wallet
- Optional CDP API key
- Optional wallet secret
- Spending policy and service allowlist

## Setup Path

1. Decide whether the agent needs the Agentic Wallet MCP, the Agentic Wallet CLI skills, or the broader CDP CLI/MCP.
2. Authenticate only after human approval.
3. Create or connect the wallet path required by the selected docs.
4. Set tiny per-call and per-session limits before any paid request.
5. Keep transfers, trading, and funding out of scope until explicitly approved.
6. Test against a low-risk x402 service or sandbox/testnet path where available.

## Smoke Test

1. Install or connect the chosen MCP/CLI path.
2. Verify the agent can read wallet status or address.
3. Set a tiny spending limit.
4. Discover one x402 service.
5. Ask for approval before any payment attempt.
6. Verify logs include service, quote, amount, authorization, and result.

## Production Checks

- Spending caps and service allowlists
- Separate approval for funding, transfers, trading, and payments
- Prompt-injection review before payment authorization
- Wallet backup/recovery ownership
- Audit logs for every quote, payment, and received resource
- Regional, tax, and compliance obligations

## Failure Modes

- Payment authorization can be redirected by prompt injection.
- Funding or onramp mistakes can expose real money.
- Repeated retries can duplicate payment attempts if idempotency is missing.
- Wallet secrets and API keys create broad blast radius if stored carelessly.
