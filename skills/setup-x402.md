# Set up x402 payments for an agent

## Purpose

Let an agent pay for HTTP resources or paid APIs through an HTTP-native payment flow.

## Primary Docs

- x402: https://www.x402.org/
- x402 docs: https://docs.x402.org/
- Coinbase x402 docs: https://docs.cdp.coinbase.com/x402/

## Human Approval Required

- Creating or funding a wallet
- Enabling paid API calls
- Accepting payments as a seller
- Setting production spend caps
- Any payment with real money

## Secrets and Accounts

- Wallet credentials or wallet provider configuration
- Optional Coinbase Developer Platform account
- Facilitator configuration
- Spend cap and allowlist policy

## Setup Path

1. Read the buyer and seller quickstarts.
2. Use sandbox or testnet options where available.
3. Configure a tiny spend cap.
4. Test against a low-cost or local paid endpoint.
5. Log the quote, authorization, settlement result, and resource received.

## Smoke Test

1. Request a test protected resource.
2. Observe the HTTP 402 payment challenge.
3. Have the client construct the payment payload.
4. Retry the request with payment metadata.
5. Verify the response and settlement record match the original request.

## Production Checks

- Per-transaction limits
- Daily and monthly spend caps
- Merchant and domain allowlists
- Replay protection
- Prompt-injection defenses before payment authorization
- Human approval for new merchants or unusual amounts

## Failure Modes

- Prompt injection can redirect the agent into unauthorized purchases.
- Retry logic can duplicate payments if idempotency is missing.
- Quotes, payment authorization, and delivered resources can drift if not bound together.

