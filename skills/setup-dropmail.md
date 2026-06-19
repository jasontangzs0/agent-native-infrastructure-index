# Set up DropMail for an agent

## Purpose

Give an agent a temporary inbound email address for verification-code, onboarding, password-reset, and testing workflows.

## Primary Docs

- API and product docs: https://dropmail.me/api/
- MCP section: https://dropmail.me/api/#mcp-ai-agents

## Human Approval Required

- Using a disposable address to create accounts on third-party services
- Handling verification codes or password-reset links
- Adding a personal domain
- Storing restore keys
- Using received mail that contains personal or sensitive data

## Secrets and Accounts

- DropMail `af_...` API token
- Optional address restore keys
- Optional personal-domain DNS access

## Setup Path

1. Generate or provide a DropMail API token.
2. Decide whether the agent will call the GraphQL API directly or use the `dropmail-mcp` server.
3. Create a session with a random address.
4. Store the session ID and, if returned, the restore key.
5. Wait for inbound mail through polling, subscriptions, or the MCP `wait_for_email` tool.
6. Read only the message fields needed for the task.

## Smoke Test

1. Create one temporary address.
2. Send a test email from a human-controlled account.
3. Wait for the message through the API or MCP tool.
4. Read the subject and body.
5. Verify the session expiration and restore-key behavior are understood.

## Production Checks

- Approval policy for third-party signups
- Session expiry and restore-key handling
- Rate-limit backoff
- Domain choice, especially if public DropMail domains are blocked
- Personal-domain DNS ownership and MX records, if used
- Logs that avoid storing full email bodies unless required

## Failure Modes

- Sessions expire and mail can disappear permanently.
- Disposable email domains can be blocked by target services.
- Verification-code handling can accidentally create accounts or reset credentials.
- Restore keys are sensitive because they can recover an address.
