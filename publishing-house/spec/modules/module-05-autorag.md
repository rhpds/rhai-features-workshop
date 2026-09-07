# Module 05 — RAG and AutoRAG

## Brief Overview

Participants first observe RAG-grounded responses in the running Fed Aura Capital app by signing in as the CEO persona, then reproduce the experience themselves by enabling RAG in the GenAI Playground and uploading a private policy document. They run targeted queries comparing generic model output to document-grounded responses, learning how pgvector and AutoRAG enable private knowledge retrieval without model retraining.

## Audience and Time

- **Target personas:** AI Engineers, AI Developers, Platform Engineers
- **Prerequisites for this module:** Access to Fed Aura Capital App tab and RHOAI Console (GenAI Playground)
- **Estimated duration:** 20 minutes

## Learning Objectives

- Distinguish generic model knowledge from RAG-grounded responses
- Identify document-grounded behavior in the running Fed Aura Capital application
- Compare unsupported vs. RAG-enabled model outputs on the same queries
- Enable RAG and upload a private policy document in GenAI Studio
- Validate retrieved facts against the source document

## Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | See the problem — generic model knowledge | 4 min |
| 2 | Observe RAG in the Fed Aura app | 5 min |
| 3 | Enable RAG and upload a private document | 6 min |
| 4 | Validate RAG-grounded responses | 5 min |

## Detailed Steps

1. Open the GenAI Playground without RAG enabled.
2. Send a query about Fed Aura Capital's internal DTI ratio policy — observe a generic, ungrounded response.
3. Open the Fed Aura Capital App tab and sign in as CEO "David Park".
4. Ask the same DTI ratio question in the Lenora chat interface — observe a specific, policy-grounded response.
5. Return to the GenAI Playground and open Configure → Knowledge tab.
6. Toggle the RAG enable switch.
7. Upload `fed-aura-internal-policy.txt` as the knowledge document.
8. Send three targeted test prompts: DTI ratio threshold, exception approval process, and loan retention policy.
9. For each response, locate the cited passage in the uploaded document and verify that the retrieved fact is accurate.
10. Review the before/after comparison in the lab guide: generic model response vs. RAG-grounded response for the same query.

## Key Takeaways

- RAG allows models to answer questions about private, proprietary, or recent information without retraining — making it essential for enterprise AI applications.
- pgvector stores document embeddings alongside application data; AutoRAG handles the chunking, embedding, and retrieval pipeline.
- Validating RAG responses against source documents is a required step in regulated industries — participants learn to spot when retrieval is grounded vs. hallucinated.
- The same RAG infrastructure that powers the Fed Aura Capital app in production is what participants configure in this module.

## Infrastructure Notes

- PostgreSQL with pgvector must be deployed and reachable from the GenAI Playground's RAG backend.
- AutoRAG service must be enabled in the RHOAI/GenAI Studio configuration.
- `fed-aura-internal-policy.txt` document must be available for student upload (not pre-staged — students upload it themselves).
- The Fed Aura Capital App must have RAG pre-configured and functional for the observation exercise in Exercise 2.
