# Module 03 — GenAI Playground

## Brief Overview

Participants create a multi-model Playground session connecting three endpoints simultaneously and compare how the same prompts produce different responses across CPU-hosted and external models. They then author and iteratively refine a domain-specific system prompt for the Lenora mortgage assistant, saving versioned snapshots to the MLflow Prompt Registry.

## Audience and Time

- **Target personas:** AI Engineers, AI Developers, Platform Engineers
- **Prerequisites for this module:** Completion of Modules 1–2 (deployed and MaaS-published model endpoints available)
- **Estimated duration:** 20 minutes

## Learning Objectives

- Create a multi-model Playground session connecting three endpoints simultaneously
- Compare CPU-hosted model responses against an external model endpoint on the same prompts
- Design and iteratively refine a domain-specific system prompt for the Lenora assistant
- Version and save the prompt to the MLflow Prompt Registry
- (Optional) Load Fed Aura Capital's reference system prompt to compare against a self-authored version

## Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Create a multi-model Playground | 5 min |
| 2 | Compare model responses | 5 min |
| 3 | Design a domain-specific system prompt | 7 min |
| 4 | Save prompt to the Prompt Registry | 3 min |

## Detailed Steps

1. Open the GenAI Playground in the RHOAI Console and create a new session.
2. Connect all three model endpoints: the two CPU-hosted models from Module 1 and an external model endpoint.
3. Send three baseline test prompts and compare the responses side by side across all three models.
4. Note qualitative differences: response length, hallucination of mortgage domain facts, tone.
5. Open the system prompt configuration and start authoring a domain-specific prompt for Lenora (the Fed Aura Capital mortgage assistant).
6. Send a domain-specific test prompt (e.g., DTI ratio query) and evaluate whether the response is grounded and appropriate.
7. Refine the system prompt based on the response — at least one iteration.
8. Open the Prompt Registry from within the Playground UI.
9. Name the prompt `fed-aura-customer-assistant` and save it as version 1.
10. (Optional) Load the Fed Aura Capital reference system prompt and compare its structure and specificity against the self-authored version.

## Key Takeaways

- The same base model responds very differently depending on the system prompt — domain-specific prompts are a primary quality lever for production AI assistants.
- Multi-model comparison in the Playground enables rapid experimentation across inference backends without code changes.
- The MLflow Prompt Registry tracks versioned system prompts alongside experiment traces, enabling regression detection when prompts change.
- Prompt design is iterative; versioning captures the evolution and enables rollback.

## Infrastructure Notes

- GenAI Playground must be accessible and able to connect to at least three model endpoints simultaneously.
- MLflow Prompt Registry must be accessible from within the Playground UI.
- The Fed Aura Capital reference system prompt (`fed-aura-customer-assistant`) should be pre-seeded in the registry for the optional exercise.
