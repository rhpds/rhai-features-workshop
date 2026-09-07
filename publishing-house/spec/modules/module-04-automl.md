# Module 04 — Predictive AI with AutoML

## Brief Overview

Participants configure and launch an AutoML binary classification job against a mortgage loan dataset entirely through the RHOAI UI — no code required. They analyze the resulting model leaderboard, interpret accuracy metrics, and examine which features drive automated loan approval predictions, introducing predictive AI as a complement to generative AI in the mortgage workflow.

## Audience and Time

- **Target personas:** AI Engineers, AI Developers, Platform Engineers
- **Prerequisites for this module:** Access to RHOAI Console; no completion dependency on prior modules
- **Estimated duration:** 25 minutes

## Learning Objectives

- Explore a mortgage loan dataset and understand its features and classification target
- Configure and launch an AutoML binary classification run in RHOAI
- Analyze model accuracy, balanced accuracy, and leaderboard rankings
- Interpret feature importance driving automated loan approval decisions

## Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Explore the training data | 5 min |
| 2 | Create an AutoML run | 8 min |
| 3 | Analyze AutoML results | 7 min |
| 4 | Interpret feature importance | 5 min |

## Detailed Steps

1. In the RHOAI Console, navigate to `Develop & Train > AutoML`.
2. Create a new AutoML run named `loan_underwriter_app`.
3. Upload the dataset `loan_applications_300-2.csv` and review its columns (decision_reason, risk_score, dti, etc.).
4. Set the task type to binary classification; set Top N models to 3.
5. Launch the run and wait for it to complete.
6. Open the results page and review the model leaderboard — the best model is `ExtraTreesGini_BAG_L1_FULL`.
7. Examine the accuracy metrics: Accuracy 0.917, Balanced Accuracy 0.938, MCC 0.881.
8. Navigate to the feature importance chart and identify the top three features: `decision_reason` (29.17%), `risk_score` (11.67%), `dti` (5.00%).
9. Review the before/after comparison in the lab guide: manual underwriting rules vs. AutoML-trained model.
10. Note that the trained model is now available for invocation from Lenora agent tools (referenced in Module 8).

## Key Takeaways

- AutoML reduces model selection and hyperparameter tuning from days of experimentation to a single UI-driven run.
- The feature importance chart makes the model's decision logic inspectable — critical for regulatory compliance in financial services (ECOA, ATR/QM, TRID).
- Predictive AI (classification) and generative AI (LLM) are complementary: the AutoML model provides structured loan approval signals that the Lenora agent can use as tool outputs.
- The trained model is registered in RHOAI and becomes a callable tool in the agentic workflow visible in Module 8's MLflow traces.

## Infrastructure Notes

- RHOAI AutoML component must be enabled in the RHOAI operator configuration.
- The `loan_applications_300-2.csv` dataset must be available for upload (can be pre-staged in MinIO or provided as a direct upload).
- AutoML run results (the `ExtraTreesGini_BAG_L1_FULL` model) must be accessible for the Module 8 trace inspection exercise.
