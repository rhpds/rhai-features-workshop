# Module 08 — Evaluations and Tracing with MLflow

## Brief Overview

Participants explore how MLflow autologging captures the full decision trace of the Lenora agent — from input shield through tool calls to final output — including the AutoML predictive model invocation from Module 4. They then trigger an evaluation pipeline to score agent quality against a named dataset, and use EvalHub to compare system prompt versions side by side.

## Audience and Time

- **Target personas:** AI Engineers, AI Developers, Platform Engineers
- **Prerequisites for this module:** Completion of Module 4 (AutoML run) recommended; the mortgage-ai experiment must have pre-seeded traces from the Fed Aura Capital app
- **Estimated duration:** 30 minutes

## Learning Objectives

- Navigate MLflow Experiments and locate agent traces for the `mortgage-ai` experiment
- Deep-dive into a multi-step agent trace and reconstruct the agent decision path
- Verify that the AutoML predictive model from Module 4 appears in traces as a tool call
- Run an automated evaluation pipeline with a named dataset and agent parameters
- Use EvalHub for centralized, cross-version prompt evaluation and comparison

## Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Explore MLflow Experiments | 6 min |
| 2 | Deep-dive into a trace | 8 min |
| 3 | Verify predictive model integration | 4 min |
| 4 | Run an evaluation pipeline | 8 min |
| 5 | Explore EvalHub | 4 min |

## Detailed Steps

1. Open the MLflow Console tab and navigate to `Develop & Train → Experiments`.
2. Locate the `mortgage-ai` experiment (tagged GenAI) and open it.
3. Browse the trace list — identify a trace for a risk assessment application with significant latency (~16s).
4. Click into the trace and review the full execution timeline: `input_shield > agent > ChatOpenAI > tool_auth > tools`.
5. Expand the `ChatOpenAI` span and inspect the system prompt, user message, and completion text.
6. Expand the tool authorization span — review which tools were permitted and why.
7. Locate the tool call to `uw_predict_loan_approval` — verify this corresponds to the AutoML model deployed in Module 4.
8. Examine the tool's input (loan application features) and output (approval/denial prediction with confidence score).
9. Navigate to `Pipelines → Runs → Create Run`.
10. Select the evaluation pipeline; set `agent_name=public-assistant` and `dataset_name=public_assistant_eval_simple`.
11. Run the pipeline and wait for the four steps to complete: setup-mlflow-op, create-dataset-op, run-eval-op, report-results-op.
12. Navigate to the Evaluations section and open EvalHub.
13. Compare `system_prompt_version` v1 vs. v2 — review quality scores across the evaluation dataset and identify which version performs better.

## Key Takeaways

- MLflow autologging (`mlflow.langchain.autolog()`) captures the full decision trace with zero application code changes — every LLM call, tool invocation, and shield check is recorded.
- The AutoML model from Module 4 appears as a tool call within the agent trace — demonstrating how predictive and generative AI are combined in a single agentic workflow.
- Evaluation pipelines run standardized quality assessments against named datasets — enabling continuous quality monitoring without manual notebook runs.
- EvalHub makes prompt version comparison visual and auditable — the right tool for teams managing prompt regressions across releases.

## Infrastructure Notes

- MLflow tracking server must be deployed and accessible with the `mortgage-ai` experiment pre-seeded with traces from the Fed Aura Capital application.
- The AutoML model from Module 4 must be deployed and callable as a tool from the Lenora agent.
- Data Science Pipelines must be operational and the evaluation pipeline YAML must be pre-imported or available for import.
- EvalHub must be enabled in the RHOAI/MLflow configuration.
