# Module 02 — Models as a Service

## Brief Overview

Participants take the model deployed in Module 1 and publish it as a centrally governed MaaS endpoint through Gen AI Studio. They configure subscription tiers with rate limits, generate API keys, and consume the endpoint from a developer tool (OpenCode or VS Code) — experiencing the shift from ad hoc per-team model deployments to a shared, governed service.

## Audience and Time

- **Target personas:** Platform Engineers, AI Engineers
- **Prerequisites for this module:** Completion of Module 1 (a deployed model endpoint)
- **Estimated duration:** 20 minutes

## Learning Objectives

- Publish a deployed model as a governed MaaS endpoint via Gen AI Studio
- Explore AI asset endpoints and subscription management in Gen AI Studio
- Generate ephemeral and permanent API keys with tier-based rate limits
- Consume a MaaS endpoint from a developer environment (OpenCode/VS Code)

## Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Publish as MaaS | 5 min |
| 2 | Explore AI asset endpoints | 5 min |
| 3 | Generate an API key | 5 min |
| 4 | Consume the MaaS endpoint | 5 min |

## Detailed Steps

1. In the RHOAI model deploy wizard, navigate to Advanced settings and enable the "Publish as MaaS" checkbox.
2. Configure token-based authentication for the endpoint.
3. Open Gen AI Studio → AI asset endpoints and locate the newly published endpoint.
4. Click "Try in playground" to confirm the endpoint is accessible through the governed gateway.
5. Navigate to the subscription section and review the two available tiers: Free (100 tokens/min) and Premium (10,000 tokens/min).
6. Select a tier and generate an API key.
7. Open the Terminal tab and configure the developer tool (OpenCode/VS Code) by editing `opencode.json` with the MaaS URL and the generated API key.
8. Send a test request through OpenCode to verify end-to-end connectivity from developer tool through MaaS gateway to the model.
9. Review the before/after comparison in the lab guide: per-team ad hoc deployment vs. governed MaaS gateway.

## Key Takeaways

- Publishing as MaaS moves a deployed model from direct endpoint access to a governed gateway with authentication, rate limiting, and subscription management.
- Subscription tiers allow platform teams to enforce different quotas for different consumers without model-level changes.
- MaaS endpoints are OpenAI-compatible — developer tools that already target OpenAI APIs can switch to a self-hosted MaaS endpoint by changing only the `base_url` and API key.
- The MaaS gateway pattern enables central visibility into model usage across all teams.

## Infrastructure Notes

- MaaS Gateway must be deployed and operational before this module.
- Gen AI Studio must be accessible from the RHOAI Console tab.
- The deployed model from Module 1 must still be running (endpoint not torn down between modules).
