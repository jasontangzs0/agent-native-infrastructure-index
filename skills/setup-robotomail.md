# Set up Robotomail for an agent

## Purpose

Give an agent a real mailbox it can create, read, send from, and use in threaded workflows.

## Primary Docs

- Product: https://robotomail.com/
- Docs: https://robotomail.com/docs
- Agent skill page: https://robotomail.com/skill

## Human Approval Required

- Upgrading to a paid plan
- Configuring a custom domain
- Sending email outside test recipients
- Letting the agent self-onboard

## Secrets and Accounts

- Robotomail API key
- Mailbox ID or address
- Optional webhook signing secret

## Setup Path

1. Decide whether a human or the agent will create the mailbox.
2. Create a test mailbox.
3. Store the API key in the agent's secret store.
4. Choose inbound mode: webhook, SSE event stream, or polling.
5. Configure mailbox send limits for the test phase.

## Smoke Test

1. Send one email to the mailbox.
2. Fetch inbound messages.
3. Send one reply to a controlled test address.
4. Verify thread resolution.
5. Check delivery logs or status.

## Production Checks

- Per-mailbox daily and monthly send limits
- Domain authentication if using custom domains
- HMAC verification for webhooks
- Audit log for all outbound messages

## Failure Modes

- Agent self-signup can create uncontrolled resources without policy.
- Webhook endpoints can accept spoofed events if signatures are ignored.
- Outbound email can create legal or reputational risk.
