# Red Hat OpenShift AI 3 Features Workshop

## Overview

Traditional AI demos show a model answering questions. Production AI requires a complete platform: model serving, governed access, domain grounding, tool integration, observability, evaluation, and security. Each capability solves a real business problem, and they must work together.

This workshop takes you through the full Red Hat OpenShift AI product portfolio by putting you inside a real production deployment. You've just joined Fed Aura Capital as an engineer — the AI platform is already running, and your job is to understand every layer of it. Each module introduces a capability, shows you what Fed Aura Capital's setup looks like in practice, and gives you hands-on time with the same tools. By the end, you'll know why the platform looks the way it does and what each component contributes.

The central AI assistant is *Lenora*, a mortgage assistant serving four business personas (borrower, loan officer, CEO, and engineer). Participants work through the platform across four transformation waves: self-hosted inference, domain grounding, agentic tool integration, and safety/security.

## Target Audience

- **Role:** Platform Engineers, AI Engineers, AI Developers, Site Reliability Engineers
- **Experience level:** Intermediate
- **What they already know:** Basic Kubernetes concepts (pods, namespaces, routes, `oc` CLI); basic AI/ML conceptual familiarity (what an LLM is, what "agent" means)
- **What they don't know:** How to build and govern a production AI platform on RHOAI; how MaaS governance, RAG, AutoML, MCP, OGX, and AI safety components work together in an enterprise deployment

## Prerequisites

- Basic Kubernetes familiarity: comfortable navigating the OpenShift web console and running `oc` CLI commands
- Basic AI/ML conceptual familiarity: understands what an LLM is and what "agent" means
- No prior Red Hat OpenShift AI experience required
- No local setup required — environment is fully pre-provisioned; participants work through six browser tabs

Prerequisites are trust-based and cannot be automatically validated by lab automation.

## Learning Objectives

1. Deploy an LLM from the RHOAI Model Catalog on CPU and with GPU acceleration using llm-d, and benchmark quantized vs. unquantized inference performance using TTFT metrics
2. Publish a deployed model as a governed MaaS endpoint with rate-limited API keys and consume it from a developer tool
3. Design and version domain-specific system prompts using the GenAI Playground and save them to the MLflow Prompt Registry
4. Configure and run an AutoML binary classification job to build a predictive loan underwriting model and interpret feature importance
5. Enable RAG-grounded responses by uploading a private policy document and validate that retrieved facts are grounded in the source
6. Deploy OGX as a unified agentic API surface and configure provider routing with failover between self-hosted and remote model providers
7. Inspect MCP server registrations and gateway routes, and invoke mortgage domain tools through GenAI Playground
8. Analyze MLflow traces to reconstruct agent decision paths, and run automated evaluation pipelines to measure agent quality across prompt versions
9. Configure NeMo Guardrails, deploy an agent into an OpenShell Agent Sandbox with deny-by-default policies, and review OCSF audit logs

## Content Type

Lab (hands-on)

## Products & Technologies

**Red Hat Products:**
- Red Hat OpenShift Container Platform (OCP 4.22)
- Red Hat OpenShift AI (RHOAI 3.5/3.6), including:
  - RHOAI Model Catalog
  - vLLM ServingRuntime
  - llm-d (distributed GPU inference)
  - GenAI Playground and Gen AI Studio
  - MaaS Gateway
  - AutoML
  - MLflow (Experiments, Tracing, Prompt Registry, EvalHub)
  - Data Science Pipelines (Kubeflow Pipelines)
  - Jupyter workbenches
  - Guardrails Orchestrator / NeMo Guardrails

**Agentic and Tooling:**
- OGX (Open GenAI Stack — unified agentic API surface)
- MCP (Model Context Protocol) servers and gateway
- MCPServerRegistration CRD
- OpenShell (CLI/SDK, Gateway, Supervisor)
- Agent Sandbox Controller

**Frameworks and Libraries:**
- LangGraph, LangChain
- OpenCode, VS Code

**Data and Storage:**
- PostgreSQL with pgvector (RAG knowledge store)
- AutoRAG

**Security and Observability:**
- Garak (adversarial LLM testing), Chatterbox Labs, SDG Hub, EvalHub
- SPIFFE/SPIRE (cryptographic workload identity)
- OPA (Open Policy Agent)
- Kata Containers
- OCSF v1.7.0 (audit logging)
- OpenTelemetry, Grafana

**Application Stack (pre-deployed):**
- FastAPI (mortgage-ai API service), React (Fed Aura Capital UI)
- NVIDIA Nemotron models (via RHOAI Model Catalog)

## Module Map

| Module | Title | Duration |
|--------|-------|----------|
| 1 | Model Catalog and Deployment | 25 min |
| 2 | Models as a Service | 20 min |
| 3 | GenAI Playground | 20 min |
| 4 | Predictive AI with AutoML | 25 min |
| 5 | RAG and AutoRAG | 20 min |
| 6 | OGX: Unified Agentic API Surface | 20 min |
| 7 | MCP Ecosystem | 25 min |
| 8 | Evaluations and Tracing with MLflow | 30 min |
| 9 | AI Safety and Secure Agent Onboarding | 30 min |
| — | **Total** | **215 min (~3 hr 35 min)** |

Estimated total: 2–4 hours depending on participant pace and depth of exploration.

## Difficulty Level

Intermediate

## Assessment Strategy

Trust-based — no automated validation. Participants confirm completion by observing expected results: model endpoints responding in GenAI Playground, AutoML results populating in RHOAI, MLflow traces appearing, guardrail blocks triggering. There are no solve/validate buttons, scoring, or automated pass/fail checks. Prerequisites are self-assessed and cannot be validated by lab automation.

## Environment

**Learner view:** When the lab starts, participants are logged into an OpenShift cluster with the full Fed Aura Capital AI platform already running. Six browser tabs are pre-configured:
- **OCP Console** — cluster administration and CRD inspection
- **Terminal** — `oc` CLI access to the cluster
- **RHOAI Console** — model catalog, serving, AutoML, pipelines, Gen AI Studio, MLflow
- **Fed Aura Capital App** — the Lenora mortgage assistant UI with four business personas
- **MLflow Console** — experiments, traces, evaluations, prompt registry
- **Grafana** — infrastructure and AI metrics dashboards

Participants do not provision infrastructure. All platform components (RHOAI operator, model catalog, Lenora app, MaaS gateway, MCP servers, MLflow tracking server, NeMo Guardrails) are pre-deployed and operational.

**Automation needed:** Yes. The following must be provisioned before lab start:
- OCP 4.22 cluster on AWS (c6a.4xlarge control plane × 3, m6a.4xlarge workers, g6.2xlarge GPU node × 1)
- RHOAI operator with all components enabled (model catalog, llm-d, GenAI Playground/Gen AI Studio, MaaS gateway, AutoML, MLflow, Data Science Pipelines, Guardrails Orchestrator, OGX, OpenShell)
- Fed Aura Capital application stack deployed (FastAPI service, React UI, PostgreSQL with pgvector, MinIO)
- MCP servers deployed (`predictive-ai-loan-mcp`, `risk-server-mcp`) with MCP gateway route in `gateway-system` project
- MLflow tracking server with autologging pre-configured and `mortgage-ai` experiment pre-seeded with traces
- Keycloak (deployed, persona demo login enabled for four business personas)
- GitHub connectivity for runtime repo clone (Modules 5–6: `rh-ai-quickstart/multi-agent-loan-origination.git`)
- Showroom UI tabs pre-configured

## Infrastructure Requirements

- **Cloud provider:** AWS
- **Cluster type:** Multinode
- **OCP version:** 4.22 (minimum)
- **Topology:** Shared cluster — up to 30 concurrent users; multi-user (not per-user namespaced). Participants share cluster-level services (RHOAI, MLflow, Grafana, MCP gateway).
- **Base CI:** `agd_v2/private-llmaas-aws-v3`
- **Sizing:**
  - Control plane: 3 × c6a.4xlarge (16 vCPU / 32 GB RAM)
  - Workers: m6a.4xlarge — count is dynamic: `max(ceil(num_users × 0.3) + 4, 5)`; for 30 users = 13 workers (16 vCPU / 64 GB RAM each)
  - Bastion: 1 × t3a.small (RHEL96GOLD-latest)
  - GPU node: 1 × g6.2xlarge (NVIDIA L4, 500 GB root volume) — tainted `nvidia.com/gpu=l4-gpu:NoSchedule`. **The machineset is provisioned with `total_replicas: 0` by default and scaled to 1 manually before the workshop starts. This avoids GPU cost during idle/staging periods; the facilitator scales up the machineset from the OCP console prior to the session.**
- **Automation approach:** Ansible + GitOps (Helm + ArgoCD); agnosticd workloads drive cluster-wide service provisioning
- **AI/MaaS:** MaaS, open-source model tier; specific model TBD at staging (NVIDIA Nemotron models via RHOAI Model Catalog)
- **External services:** `github.com` — required both during provisioning (bootstrap/showroom role) and at student runtime (repo clone in Modules 5–6)
- **Non-GA products:** Red Hat OpenShift AI 3.5 — not GA at intake time; expected to GA before catalog release. Pre-GA access via RHDP internal provisioning. Infra reviewer to validate GA status at staging time.
- **Reporting:** `primaryBU: Artificial_Intelligence`
