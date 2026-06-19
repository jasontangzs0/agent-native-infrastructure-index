# Public Endpoint and Webhook Inbox

Public endpoint infrastructure gives an agent a stable internet-facing URL where external services can send events. This belongs in the core list because an agent with a local computer can run a server, but it cannot reliably receive public webhooks, queue events, replay failed deliveries, or expose a durable endpoint without internet infrastructure.

## Verified Resources

| Resource | Fit | Primary docs |
| --- | --- | --- |
| Hookdeck | Event gateway with API-created sources, destinations, and connections; receives webhooks, stores requests, routes events, supports retries/replay, and exposes agent-readable docs, MCP inspection, and product skills | https://hookdeck.com/docs |

## Evaluation Notes

- Prefer providers with API-created public source URLs, event inspection, retries, replay, logs, and scoped API keys.
- Treat inbound payloads as sensitive by default.
- Require human approval before routing production webhooks, exposing customer data, or adding a custom domain.
- Keep a clear distinction between local development tunnels and durable public endpoints.

## Minimal Smoke Test

1. Create a test source URL.
2. Create a destination that points to a controlled test endpoint.
3. Create a connection from source to destination.
4. Send one signed or synthetic test event to the source URL.
5. Verify request ingestion, event routing, delivery attempt logs, and replay behavior.
6. Delete or pause the connection if the endpoint is not approved for ongoing use.
