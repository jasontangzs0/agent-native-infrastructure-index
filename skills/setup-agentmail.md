# Set up AgentMail for an agent

## Purpose

Give an agent its own API-managed email inbox for receiving verification messages, handling threaded conversations, and processing attachments.

## Primary Docs

- Product: https://www.agentmail.to/
- Docs: https://docs.agentmail.to/

## Human Approval Required

- Creating a production account
- Configuring a custom domain
- Sending email to real users or customers
- Storing or processing personal data

## Secrets and Accounts

- AgentMail API key
- Optional custom domain DNS access
- Test recipient email address

## Setup Path

1. Create an AgentMail account.
2. Generate an API key.
3. Create a test inbox on the provider domain.
4. Store the API key in the agent's secret store.
5. Configure inbound event delivery if the workflow needs realtime processing.
6. Keep custom domains out of the first test unless deliverability is the evaluation target.

## Smoke Test

1. Create `test-agent@...`.
2. Send a message from a human-controlled email account.
3. Read the message through the API.
4. Reply to the test sender.
5. Verify the reply appears in the same thread.

## Production Checks

- DKIM, SPF, and DMARC configured for custom domains
- Rate limits and suppression policy defined
- Logging enabled for sends, replies, and attachment access
- Human approval gate for outbound messages beyond test recipients

## Failure Modes

- Missing DNS records cause poor deliverability.
- Agents can leak sensitive information by replying to external senders.
- Verification-code workflows can accidentally create accounts on third-party services.
