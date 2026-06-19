# Set up Vapi phone number for an agent

## Purpose

Give an agent a phone-number resource for voice-agent calls and supported SMS workflows.

## Primary Docs

- Product/docs: https://docs.vapi.ai/
- Create phone number API: https://docs.vapi.ai/api-reference/phone-numbers/create
- Inbound SMS: https://docs.vapi.ai/phone-numbers/inbound-sms
- Agent-readable docs index: https://docs.vapi.ai/llms.txt

## Human Approval Required

- Creating or importing a phone number
- Creating a provider credential
- Using Twilio, Telnyx, Vonage, or other telephony credentials
- Enabling outbound calls
- Enabling inbound SMS
- Recording or transcribing calls

## Secrets and Accounts

- Vapi API key
- Optional assistant/squad/workflow ID
- Optional provider credential ID
- Optional Twilio/Telnyx/Vonage account credentials

## Setup Path

1. Create or select a Vapi account.
2. Create or select a test assistant.
3. Store the Vapi API key in the agent's secret store.
4. Create or register a phone-number resource through the Phone Number API.
5. If using a provider-backed number, create or select the provider credential first.
6. Attach the assistant, squad, workflow, hooks, or server URL required for the test.

## Smoke Test

1. Create or register a test number.
2. Attach a test assistant.
3. Place one inbound call from a human-controlled phone.
4. Verify the agent answers and call events are visible.
5. If SMS is enabled, send one inbound SMS and verify routing.
6. Remove the number or disable it after testing unless approved.

## Production Checks

- Provider/account constraints for the number type
- Region and number availability
- SMS support limitations and carrier rules
- Recording consent and data retention
- Outbound call/SMS allowlists
- Spend and concurrency limits

## Failure Modes

- Free or dashboard-created numbers may not match API-created provider resources.
- Provider credentials can expose broad telephony access.
- SMS support can be region- or provider-limited.
- Outbound calls and SMS can violate consent or messaging rules.
