# Phone, SMS, and Voice

Phone infrastructure gives an agent a real phone number and carrier-backed communication channel. This belongs in the core list because an agent with a local computer cannot create a real phone number, receive PSTN calls, or send carrier SMS by itself.

## Verified Resources

| Resource | Fit | Primary docs |
| --- | --- | --- |
| Retell AI | AI phone-agent platform with `llms.txt`, API reference, MCP server, SDKs, webhooks, and API-based phone number purchase/binding | https://docs.retellai.com/ |
| Vapi | Voice-agent platform with `llms.txt`, API reference, MCP, SDKs, CLI, and API-based phone-number resources with provider constraints | https://docs.vapi.ai/ |

## Evaluation Notes

- Prefer providers with agent-readable docs, API-based number provisioning, webhooks, and clear call/SMS controls.
- Treat outbound calls and SMS as privileged external communication.
- Require human approval before purchasing numbers, sending SMS, making outbound calls, recording calls, or using telephony credentials.
- Check region, A2P 10DLC, consent, recording, and TCPA/compliance requirements before production use.

## Minimal Smoke Test

1. Create or register a test number through the API.
2. Bind a test voice or chat agent to the number.
3. Place one inbound test call from a human-controlled phone.
4. Verify webhook/call event delivery.
5. If SMS is enabled, send one inbound test SMS and verify the agent receives it.
6. Delete or disable the number if it is not approved for ongoing use.

