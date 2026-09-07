# Module 07 — MCP Ecosystem

## Brief Overview

Participants compare how a regular chatbot responds to an affordability question versus an agentic chatbot with MCP tool access, then trace how that tool access is governed — inspecting MCPServerRegistration CRDs in OpenShift and verifying the MCP gateway route. They conclude by wiring MCP tools into the GenAI Playground and submitting a mortgage affordability query to observe live tool invocation. Note: all five exercises are currently TBD placeholders in source content.

## Audience and Time

- **Target personas:** AI Engineers, Platform Engineers, AI Developers
- **Prerequisites for this module:** Basic familiarity with CRDs and OpenShift console navigation
- **Estimated duration:** 25 minutes

## Learning Objectives

- Distinguish regular chatbots from agentic chatbots with tool access
- Explore MCP server registrations in the RHOAI console
- Examine MCPServerRegistration CRDs in the OpenShift console
- Verify the MCP gateway route and connectivity in the `gateway-system` project
- Use MCP tools (affordability_calc, risk_assessment, pricing_engine) through GenAI Playground

## Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Compare regular vs. agentic responses | 5 min |
| 2 | Explore MCP servers in RHOAI | 5 min |
| 3 | Examine MCPServerRegistrations in OpenShift | 5 min |
| 4 | Verify the MCP gateway | 5 min |
| 5 | Use MCP tools in Playground | 5 min |

## Detailed Steps

1. Open the GenAI Playground without MCP tools connected and ask a mortgage affordability question. Note the generic, calculation-free response.
2. In the RHOAI Console, navigate to Gen AI Studio → AI asset endpoints → MCP servers tab.
3. Locate the two deployed MCP servers: `predictive-ai-loan-mcp` and `risk-server-mcp`. Review their registered tools.
4. Open the OCP Console tab and navigate to Custom Resource Definitions → MCPServerRegistrations.
5. Open the `mortgage-ai` project and inspect the MCPServerRegistration YAML — review the tool schema, endpoint URL, and authentication configuration.
6. Navigate to the `gateway-system` project → Routes → `mcp-gateway` and note the external URL.
7. Open the GenAI Playground and navigate to Configure → MCP tab.
8. Connect to the MCP gateway and enable the `affordability_calc`, `risk_assessment`, and `pricing_engine` tools.
9. Submit an affordability query: "Can a borrower earning $85,000/year with $1,200/month in existing debt afford a $400,000 home at 6.5% interest?"
10. Observe the tool invocations in the response trace and review the calculated affordability result.

## Key Takeaways

- MCP (Model Context Protocol) is an open standard for connecting AI models to external tools and data sources without framework-specific code.
- MCPServerRegistration is a CRD that governs which MCP servers are available to agents and the GenAI Playground — tool access is cluster-native, not ad hoc.
- The MCP gateway route provides a single, authenticated entry point for all MCP tool calls — enabling centralized auditing and rate limiting.
- Platform engineers control tool availability at the cluster level; AI developers consume approved tools without managing individual integrations.

## Infrastructure Notes

- Two MCP servers (`predictive-ai-loan-mcp`, `risk-server-mcp`) must be deployed with their MCPServerRegistration CRDs in the `mortgage-ai` project.
- MCP gateway route must be active in the `gateway-system` project.
- GenAI Playground must support MCP tool connection (the Configure → MCP tab must be present).
- Note: exercises are TBD in source content — this outline reflects the design intent from the scaffolded module structure.
