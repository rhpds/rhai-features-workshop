# Module 01 — Model Catalog and Deployment

## Brief Overview

Participants explore the RHOAI Model Catalog and deploy the same LLM twice: once on CPU using a standard vLLM ServingRuntime, and a second time with GPU acceleration via llm-d distributed inference. They then run a benchmark comparing quantized and unquantized variants using Time-to-First-Token (TTFT) metrics, making the performance trade-offs of self-hosted inference concrete.

## Audience and Time

- **Target personas:** Platform Engineers, AI Engineers, AI Developers
- **Prerequisites for this module:** None — this is the first module
- **Estimated duration:** 25 minutes

## Learning Objectives

- Navigate the RHOAI Model Catalog and identify validated models available for deployment
- Deploy an LLM on CPU using the vLLM ServingRuntime and hardware profile selection
- Deploy an LLM with GPU acceleration using llm-d distributed inference
- Benchmark quantized vs. unquantized model variants and interpret TTFT metrics

## Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Explore the Model Catalog | 5 min |
| 2 | Deploy an LLM on CPU | 8 min |
| 3 | Deploy with GPU and llm-d | 7 min |
| 4 | Benchmark quantized vs. unquantized | 5 min |

## Detailed Steps

1. Open the RHOAI Console tab and navigate to the Model Catalog.
2. Browse validated models and identify the NVIDIA Nemotron entry to be deployed.
3. Launch the deploy wizard: select hardware profile (CPU), choose vLLM ServingRuntime.
4. Confirm the endpoint is available and test it via the GenAI Playground quick test.
5. Return to the Model Catalog and deploy the same model a second time using a GPU hardware profile with llm-d as the serving runtime.
6. Confirm the GPU-backed endpoint is available in the GenAI Playground.
7. Use the benchmark tool to run TTFT comparisons between the quantized and unquantized variants of the same model.
8. Read the results: compare TTFT values and note the speedup ratio.
9. Review the key takeaways table in the lab guide contrasting cloud API vs. self-hosted deployment.

## Key Takeaways

- The RHOAI Model Catalog provides validated, pre-certified model packages — participants deploy from catalog rather than sourcing models manually.
- CPU and GPU deployments use the same deploy wizard; hardware profile selection and ServingRuntime choice determine acceleration.
- llm-d enables distributed GPU inference across multiple GPU slices — relevant for models too large for a single GPU.
- Quantized models offer meaningfully lower TTFT (e.g., 1.69× speedup) with acceptable quality trade-offs for latency-sensitive workloads.

## Infrastructure Notes

- GPU node (g6.2xlarge, NVIDIA L4) must be provisioned and tainted before lab starts; Module 1 is the first exercise to schedule a workload on it.
- vLLM ServingRuntime must be available in the RHOAI operator configuration.
- llm-d must be enabled in the RHOAI operator.
- GenAI Playground must be accessible from the RHOAI Console tab.
