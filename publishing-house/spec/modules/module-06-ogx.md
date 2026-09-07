# Module 06 — OGX: Unified Agentic API Surface

## Brief Overview

Participants deploy OGX — Red Hat's unified agentic API surface — on RHOAI and observe how redirecting an existing LangGraph agent requires only a `base_url` change with no code modifications. They configure routing rules between self-hosted and remote model providers and use OGX's OpenAI-compatible vector store APIs for RAG. Note: as of intake, all five exercises are scaffolded as TBD placeholders in the source content.

## Audience and Time

- **Target personas:** Platform Engineers, AI Engineers
- **Prerequisites for this module:** Completion of Modules 1–3 recommended (deployed model endpoints and MaaS familiarity helpful)
- **Estimated duration:** 20 minutes

## Learning Objectives

- Understand how OGX differs from agent frameworks and inference gateways
- Deploy an OGX server via the RHOAI operator
- Point existing OpenAI-compatible agents at OGX with zero code changes
- Configure routing rules between self-hosted and remote providers with failover
- Use OGX RAG capabilities via OpenAI-compatible vector store APIs

## Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Understand the OGX architecture | 4 min |
| 2 | Deploy OGX on RHOAI | 4 min |
| 3 | Zero-code migration | 4 min |
| 4 | Provider routing and failover | 4 min |
| 5 | RAG via OGX | 4 min |

## Detailed Steps

1. Read the architecture overview in the lab guide distinguishing OGX from agent frameworks (LangGraph, CrewAI) and from inference gateways (vLLM, MaaS).
2. Navigate to the RHOAI operator configuration and deploy an OGX server instance.
3. Confirm the OGX route is accessible.
4. In an existing Python code snippet (LangChain/LangGraph), change only the `base_url` to point at the OGX endpoint — no other code changes.
5. Run the agent and verify it operates identically through OGX.
6. In the OGX UI, configure routing rules directing requests to self-hosted models for most queries and failing over to an external provider when the self-hosted endpoint is unavailable.
7. Simulate a failover by disabling the self-hosted endpoint and verifying OGX routes to the fallback.
8. Call OGX's OpenAI-compatible vector store APIs (`/v1/vector_stores`, `/v1/embeddings`, `/v1/files`) to upload a document and retrieve relevant chunks.
9. Review the before/after comparison: many per-team provider configurations vs. one OGX routing layer.

## Key Takeaways

- OGX provides a single API surface for all model providers — self-hosted, MaaS, and external — using OpenAI-compatible endpoints, so any existing agent or tool works without modification.
- Provider routing and failover are configured in OGX rather than in application code, keeping agent logic clean.
- OGX's vector store APIs follow the OpenAI Responses API spec — RAG becomes provider-agnostic.
- OGX is deployed as a first-class RHOAI operator component, not a separate sidecar or proxy.

## Infrastructure Notes

- OGX must be available as a deployable component in the RHOAI operator.
- At least two model endpoints must be active for the routing/failover exercise (one self-hosted from Module 1, one external or MaaS).
- Note: exercises are TBD in source content — this outline reflects the design intent; actual exercise details will be filled in during content development.
