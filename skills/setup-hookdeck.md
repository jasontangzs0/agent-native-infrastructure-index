# Set up Hookdeck public endpoint for an agent

## Purpose

Give an agent a public webhook source URL and event inbox for receiving, inspecting, routing, retrying, and replaying external HTTP events.

## Primary Docs

- Product docs: https://hookdeck.com/docs
- Sources: https://hookdeck.com/docs/sources
- Connections: https://hookdeck.com/docs/connections
- MCP and agent skills: https://hookdeck.com/docs/mcp
- Agent-readable docs index: https://hookdeck.com/docs/llms.txt

## Human Approval Required

- Creating or using a Hookdeck account/API key
- Exposing production webhook endpoints
- Routing third-party production webhooks
- Storing personal, customer, regulated, or sensitive payloads
- Adding a custom domain
- Retrying or replaying production events

## Secrets and Accounts

- Hookdeck API key or CLI authentication
- Hookdeck project or environment ID
- Destination endpoint controlled by the agent or operator
- Optional webhook signing secret from the sending service

## Setup Path

1. Create or select a Hookdeck project.
2. Store the Hookdeck API key in the agent's secret store.
3. Create a test source URL for inbound HTTP events.
4. Create a test destination URL controlled by the operator.
5. Create a connection from the source to the destination.
6. Configure filters, transformations, and retries only if the test workflow requires them.
7. If using an AI assistant, use Hookdeck MCP for read/inspection workflows and the API, CLI, or Hookdeck product skills for resource creation and changes.

## Smoke Test

1. Send one synthetic JSON event to the source URL.
2. Verify the request appears in Hookdeck.
3. Verify the event is routed to the destination.
4. Inspect the delivery attempt and response code.
5. Replay the test event once.
6. Pause or delete the connection unless ongoing use is approved.

## Production Checks

- Webhook signature verification
- Payload retention policy
- PII and regulated data handling
- Destination authentication
- Retry and replay guardrails
- Environment separation for test and production
- Audit logging for configuration changes

## Failure Modes

- A public source URL can receive spam or malicious payloads.
- Replaying events can duplicate downstream side effects.
- Weak destination security can leak sensitive webhook data.
- Overly broad transformations or filters can silently drop important events.
