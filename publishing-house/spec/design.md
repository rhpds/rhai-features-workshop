# Fed Aura Capital Workshop: AgentOps Observability with Red Hat OpenShift AI

## Overview

This workshop replaces the Parasol Insurance AI workshop and serves as the primary customer-facing vehicle for Red Hat OpenShift AI 3.x adoption across pre-sales, proof-of-concept, and post-sales AI journeys. It uses the Fed Aura Capital mortgage lending application — a five-agent LangGraph system that debuted at the Red Hat Summit 2026 AI Spotlight keynote — to make AgentOps observability concrete and role-relevant. Participants work through six modules covering the full observability stack: they explore a running multi-agent application, apply the three observability pillars (metrics, logs, traces) to real agentic workloads, instrument and analyze MLflow traces, and (optionally) build and run automated LLM evaluation pipelines to catch prompt regressions before production.

## Target Audience

- **Role:** Site Reliability Engineers (SREs), Platform Engineers, AI Developers / AI Engineers
- **Experience level:** Intermediate
- **What they already know:** Basic Kubernetes concepts (pods, namespaces, routes, `oc` CLI), basic familiarity with AI/ML terminology (agents, LLMs, inference)
- **What they don't know:** How to apply observability practices to multi-agent AI systems; how to use MLflow tracing, Grafana dashboards, and LokiStack in the context of agentic applications; how to run LLM evaluations and detect regressions

## Prerequisites

- Basic Kubernetes familiarity: comfortable navigating the OpenShift web console and running `oc` CLI commands
- Basic AI/ML familiarity: understands what an LLM is and what "agent" means in an AI context
- Basic Python literacy required for optional Modules 5–6 (reading and running Jupyter notebook cells)
- No GPU provisioning or model training experience required
- Prerequisites cannot be automatically validated by lab automation (declarative familiarity checks are not feasible)

## Learning Objectives

1. Explore a production-pattern multi-agent AI application and identify the observability gap that conventional monitoring tools cannot close
2. Monitor AI-specific metrics and KPIs — including LLM token usage, inference latency, and tool-call success rates — using pre-deployed Grafana dashboards
3. Analyze structured application logs for a multi-agent system using LokiStack and LogQL queries
4. Configure and use MLflow tracing to capture end-to-end agent execution spans, from input/output shields through LLM calls and tool invocations
5. Analyze agent traces to identify latency hotspots, failed tool calls, and multi-turn conversation context across user sessions
6. Deploy an automated evaluation pipeline and verify prompt regression detection using Red Hat OpenShift AI Data Science Pipelines and MLflow Prompt Registry (optional)

## Content Type

Lab (hands-on)

## Products & Technologies

**Red Hat Products:**
- Red Hat OpenShift Container Platform
- Red Hat OpenShift AI (includes MLflow tracking server, LokiStack, User Workload Monitoring, Data Science Pipelines, Jupyter workbenches)

**Observability Stack (upstream):**
- MLflow (Tracing, Evaluation, Prompt Registry, Sessions)
- Grafana (dashboards via GrafanaDashboard CRD)
- LokiStack (log aggregation and querying)
- Prometheus / OpenShift User Workload Monitoring
- OpenTelemetry

**AI/ML Frameworks (upstream):**
- LangGraph
- LangChain
- Kubeflow Pipelines (via RHOAI Data Science Pipelines)
- Model Context Protocol (MCP)

**Application Stack:**
- FastAPI, React, PostgreSQL with pgvector, MinIO

## Module Map

| Module | Title | Duration |
|--------|-------|----------|
| 1 | The Agentic App and Why Observability Matters | 25 min |
| 2 | Observability Pillars, Concepts, and Personas | 15 min |
| 3 | Metrics and Logs for Agentic Applications | 30 min |
| 4 | Tracing and MLflow | 35 min |
| 5 | Agent and LLM Evaluations (Optional) | 55 min |
| 6 | From Development to Production (Optional) | 55 min |
| — | **Core path total (Modules 1–4)** | **105 min (~1 hr 45 min)** |
| — | **Full lab total (Modules 1–6)** | **215 min (~3 hr 35 min)** |

## Difficulty Level

Intermediate

## Environment

**Learner view:** When the lab starts, participants log in to an OpenShift cluster with a pre-provisioned, per-user namespace. The Fed Aura Capital mortgage AI application is already deployed — five LangGraph agent personas running as a FastAPI service, with a React front end accessible via an OpenShift route. A shared MLflow tracking server is running and pre-configured with `mlflow.langchain.autolog()` enabled for the application. A Grafana instance with a pre-built Mortgage-AI dashboard (HTTP metrics + AI agentic metrics panels) is accessible. A LokiStack instance with OpenShift Logging is collecting structured JSON logs from all application pods. Participants immediately interact with the running application and observability stack; no cluster-level setup is required.

**Automation needed:** Yes. The following must be provisioned before lab start:
- OCP cluster with RHOAI operator and all required components enabled (MLflow tracking server, LokiStack, User Workload Monitoring, Data Science Pipelines)
- Grafana operator and GrafanaDashboard CRD with the Mortgage-AI dashboard deployed
- Fed Aura Capital application deployed in per-user namespaces (FastAPI service, React front end, PostgreSQL with pgvector, MinIO)
- MLflow tracking server with `mlflow.langchain.autolog()` pre-configured for the application
- MaaS LLM endpoint configured via `llm-credentials` secret (model: gpt-oss-120b, internal in-cluster)
- RHOAI Jupyter workbench image available for optional Modules 5–6
- GitHub connectivity for students cloning `rh-ai-quickstart/multi-agent-loan-origination.git` (Modules 5–6)

## Infrastructure Requirements

- **Cloud provider:** CNV (on-premise)
- **Cluster type:** Multinode
- **OCP version:** 4.20 (minimum)
- **Topology:** Shared-cluster — 15 concurrent users, each with a dedicated namespace (`wksp-userN`) provisioned via GitOps bootstrap-tenant (ArgoCD ApplicationSet); RHOAI, LokiStack, Grafana, and MLflow are shared cluster-level services
- **Sizing (initial estimate — subject to revision):**
  - Control plane: 3 nodes × 16 vCPU / 64 GB RAM (unchanged from compact multinode baseline)
  - Workers: 3 nodes × 64 vCPU / 256 GB RAM each (4× per-node capacity of the control plane nodes)
  - Total worker capacity: 192 vCPU / 768 GB RAM across 3 workers
  - **Note:** Sizing will be confirmed and adjusted during infra review once per-user workload resource profiles are measured from a test deployment with 15 tenants
- **Automation approach:** Ansible + GitOps (Helm + ArgoCD); bootstrap-infra deploys cluster-wide services; bootstrap-tenant (new) provisions per-user namespace and RBAC via ApplicationSet
- **AI/MaaS:** MaaS, open-source model (`gpt-oss-120b`, served via in-cluster LiteLLM endpoint)
- **External services:** `github.com` — required during provisioning via bootstrap/showroom role for cloning `rh-ai-quickstart/multi-agent-loan-origination.git` (used in Modules 5–6)
- **Non-GA products:** Red Hat OpenShift AI 3.5 — not GA at intake time; expected to GA before catalog release but not confirmed. Pre-GA access via RHDP internal provisioning. Infra reviewer to validate GA status at staging time.
