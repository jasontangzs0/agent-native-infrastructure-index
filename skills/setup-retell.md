# Set up Retell AI phone number for an agent

## Purpose

Give an agent a real phone number for inbound/outbound calls and, where approved, SMS workflows.

## Primary Docs

- Product/docs: https://docs.retellai.com/
- API reference: https://docs.retellai.com/api-references/create-phone-number
- Agent-readable docs index: https://docs.retellai.com/llms.txt

## Human Approval Required

- Creating or buying a phone number
- Enabling outbound calls
- Enabling outbound SMS
- Recording or transcribing calls
- A2P, business profile, or campaign approval
- Using customer or personal phone numbers

## Secrets and Accounts

- Retell API key
- Optional inbound/outbound agent IDs
- Optional webhook URLs
- Optional telephony provider credentials if using custom telephony

## Setup Path

1. Create or select a Retell workspace.
2. Create or select a test voice/chat agent.
3. Store the Retell API key in the agent's secret store.
4. Use the Create Phone Number API to buy a test number and bind inbound/outbound agents.
5. Configure inbound and SMS webhooks only if the workflow needs them.
6. Keep country and outbound allowlists narrow during testing.

## Smoke Test

1. Create a test number with an area code if needed.
2. Bind an inbound test agent.
3. Call the number from a human-controlled phone.
4. Verify the call reaches the agent.
5. Verify call event or webhook delivery.
6. Delete, disable, or keep the number only after approval.

## Production Checks

- Call recording consent policy
- TCPA and regional telephony compliance
- A2P 10DLC approval for SMS where required
- Spend limits and call concurrency limits
- Abuse prevention and opt-out handling
- Audit logs for outbound calls/SMS

## Failure Modes

- Outbound calls or SMS can create legal and reputational risk.
- SMS campaigns can be rejected or suspended if the use case changes.
- Webhooks can leak call data if endpoint security is weak.
- Poor prompt/tool policy can let the agent call or message the wrong person.
