# Payments and Commerce

Payment infrastructure is the highest-risk category because mistakes move real money.

## Verified Resources

| Resource | Fit | Primary docs |
| --- | --- | --- |
| Skyfire | Agent identity, wallet, payment credentials, mandates, and checkout | https://docs.skyfire.xyz/ |
| x402 | HTTP-native payment standard using HTTP 402 for paid resources and agentic payments | https://docs.x402.org/ |
| Coinbase x402 | x402 docs, buyer/seller quickstarts, MCP server support, facilitator and wallet tooling | https://docs.cdp.coinbase.com/x402/ |
| Coinbase Agentic Wallet | Agent wallet and x402 payment capability through CLI skills or MCP, with spending controls | https://docs.cdp.coinbase.com/agentic-wallet/welcome |
| Nevermined | Agent payments, virtual cards, metering, monetization, x402 facilitator support | https://nevermined.ai/ |

## Evaluation Notes

- Require human approval before wallet funding, paid API use, production merchant setup, or card activation.
- Treat verified identity and user mandates as payment permissions, not generic agent identity.
- Set hard spend caps, per-transaction limits, and allowlists before any autonomous action.
- Log quote, authorization, settlement, resource received, and verification result.
- Treat prompt injection as a payment risk, not just a model quality issue.

## Minimal Smoke Test

1. Use a sandbox or testnet where available.
2. Set a tiny spend cap.
3. Request one paid test resource.
4. Verify the agent records the quote and authorization.
5. Confirm settlement and received resource match the original intent.
