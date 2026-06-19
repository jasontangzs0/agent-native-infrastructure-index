# Email and Inbox

Email is one of the most mature agent-native categories because agents often need to receive verification codes, send reports, process attachments, or maintain threaded conversations.

## Verified Resources

| Resource | Fit | Primary docs |
| --- | --- | --- |
| AgentMail | API-first inboxes for AI agents, threads, attachments, realtime events, SDKs, MCP, semantic search, data extraction | https://docs.agentmail.to/ |
| Robotomail | Agent-owned mailboxes, send/receive APIs, webhook/SSE/polling inbound, self-onboarding skill page | https://robotomail.com/docs |
| DropMail | Disposable inbound addresses for onboarding, confirmation-code, and testing flows, with GraphQL, realtime delivery, restore keys, personal domains, and MCP | https://dropmail.me/api/ |

## Evaluation Notes

- Prefer dedicated agent inboxes over human Gmail/Outlook accounts for autonomous workflows.
- Use disposable inboxes only when the workflow genuinely calls for temporary receiving addresses; do not treat them as durable identity by default.
- Treat outbound email as a privileged action. Require approval before contacting real users or customers.
- Use a test domain or provider domain for evaluation before configuring production DKIM, SPF, DMARC, and custom domains.

## Minimal Smoke Test

1. Provision a test inbox or mailbox.
2. Send one inbound email from a human-controlled account.
3. Read the message through the API.
4. Send a reply to a test address.
5. Verify threading and event delivery.

For receive-only disposable inboxes, replace the reply/threading check with a restore-key or session-recovery check.
