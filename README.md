# Agent Skills — Bug Bounty & Offensive Security Skill Library

A library of **93 agent skills** for bug bounty hunting, external red-team
operations, and offensive security research. Every skill is a single
`SKILL.md` package written to the open
[Agent Skills standard](https://agentskills.io/specification) — one file,
**every AI coding agent**.

> **Authorization required.** This library is for **authorized security
> testing only**. You may only use these skills against assets you own or
> have explicit written permission to test. Unauthorized testing is illegal
> in most jurisdictions and violates the terms of every bug bounty platform.
> The skills are a methodology; the discipline is yours.

---

## What makes this library different

- **Verify-or-kill triage discipline** — `triage-validation` gates every
  finding through a 7-question check before you spend time writing a report.
  Kills the weak candidates early so your N/A ratio stays low.
- **A→B→C chain-building economics** — `hunt-*` skills ship as exploit
  primitives plus explicit "chain to X" sections, so a CSRF becomes an ATO
  and an SSRF becomes a cloud-metadata compromise.
- **Per-class gate / verify / kill tables** — every vulnerability class has
  concrete validation gates (e.g. "OOB callback or it didn't happen" for
  blind SSRF) so you stop hunting after proof, not after suspicion.
- **Modern classes, not 2015-era checklists** — agentic AI security
  (OWASP ASI01–ASI10), CI/CD & GitHub Actions abuse, HTTP/2 single-packet
  races, protocol-version shadow APIs.
- **Operator field notes** — hard-won lessons from real authorized
  engagements, packaged as "what broke on a live target and why" nuggets.
- **An orchestrator, not a pile** — `bb-methodology` + the `bb-*` family
  form an end-to-end campaign workflow: recon → enrichment → dispatch →
  verification → reporting, mirroring a multi-agent bug-bounty operating
  system.

---

## Install — one `SKILL.md`, every agent

### Quick start (recommended)

```bash
git clone https://github.com/murrtada/bug-bounty-agent-skills.git
cd bug-bounty-agent-skills
./install.sh          # auto-detects your installed agents and copies skills in
```

### Per-platform paths

| Platform | Global (all projects) | Per-project | Notes |
|---|---|---|---|
| **opencode** | `~/.config/opencode/skills/` | `.opencode/skills/` | also reads `~/.claude/skills`, `~/.agents/skills` |
| **Claude Code** | `~/.claude/skills/` | `.claude/skills/` | native; also via plugin marketplaces |
| **Gemini CLI** | `~/.gemini/skills/` | `.gemini/skills/` | also `~/.agents/skills`; `gemini skills install` works |
| **GitHub Copilot** (VS Code / CLI) | `~/.config/github-copilot/skills/` | `.github/skills/` | needs Copilot agent mode; reads `~/.claude/skills` too |
| **Codex CLI** | `~/.codex/skills/` | `.codex/skills/` | `CODEX_HOME/skills` |
| **Cursor** | `~/.cursor/skills/` | `.cursor/skills/` | skips your `~/.cursor/skills` when a project one exists |
| **Universal** | `~/.agents/skills/` | `.agents/skills/` | interop alias honored by most agents |

Manual install for a single agent:

```bash
cp -r skills/* ~/.claude/skills/            # Claude Code (global)
cp -r skills/* ~/.config/opencode/skills/   # opencode (global)
cp -r skills/* ~/.gemini/skills/            # Gemini CLI (global)
cp -r skills/* .github/skills/              # GitHub Copilot (this project)
cp -r skills/* ~/.codex/skills/             # Codex CLI (global)
```

Or use the cross-agent **Skills CLI**:

```bash
npx skills add murrtada/bug-bounty-agent-skills -a claude-code      # also: -a opencode -a gemini -a codex -a copilot -a cursor
```

Start a new session after installing. Skills activate automatically when your
request matches their `description`. You can hint explicitly by name, e.g.
"use the `hunt-ssrf` skill".

> The format is identical across agents — only the target directory differs.
> Write once, copy to each agent, done. See
> [agentskills.io](https://agentskills.io) for the standard.

---

## Library map

### Orchestration & methodology
`bb-methodology` · `bb-recon` · `bb-local-toolkit` · `bug-bounty` · `recon-scope-triage`

### Client-side / web
`bb-web` · `hunt-xss` · `hunt-dom` · `hunt-html-injection` · `hunt-csrf` ·
`hunt-cors` · `hunt-clickjacking` · `hunt-open-redirect` · `hunt-websocket` ·
`hunt-cache-poison` · `hunt-http-smuggling` · `hunt-host-header`

### Injection & code execution
`bb-injection` · `hunt-sqli` · `hunt-nosqli` · `hunt-ldap` · `hunt-ssti` ·
`hunt-deserialization` · `hunt-xxe` · `hunt-lfi` · `hunt-rce`

### Server-side request & file bugs
`hunt-ssrf` · `hunt-file-upload` · `hunt-exceptional-conditions` · `hunt-misc`

### Auth, accounts & sessions
`bb-authz` · `hunt-idor` · `hunt-ato` · `hunt-auth-bypass` · `hunt-forgot-password` ·
`hunt-mfa-bypass` · `hunt-brute-force` · `hunt-captcha-bypass` · `hunt-session` ·
`hunt-jwt-crypto` · `hunt-oauth` · `hunt-saml` · `hunt-ntlm-info`

### APIs & modern surfaces
`bb-api` · `hunt-api-misconfig` · `hunt-graphql` · `hunt-grpc` · `hunt-spa-api` ·
`hunt-source-leak` · `hunt-shadow-api` · `hunt-nextjs` · `hunt-nodejs` ·
`hunt-laravel` · `hunt-aspnet` · `hunt-springboot` · `hunt-sharepoint`

### Cloud, infra, CI/CD & mobile
`bb-cloud` · `hunt-cloud-misconfig` · `cloud-iam-deep` · `hunt-k8s` · `hunt-cicd` ·
`supply-chain-attack-recon` · `vmware-vcenter-attack` · `enterprise-vpn-attack` ·
`m365-entra-attack` · `okta-attack` · `apk-redteam-pipeline` · `ios-redteam-pipeline`

### AI / LLM security
`bb-ai` · `hunt-llm-ai` · `hunt-rag-vector`

### Business logic & logic bugs
`bb-logic` · `hunt-business-logic` · `hunt-race-condition`

### Offensive OSINT & recon
`offensive-osint` · `osint-methodology` · `web2-recon` · `hunt-subdomain` ·
`hunt-tls-network`

### Reporting, triage & red-team operations
`bb-report` · `bb-verify` · `bb-handoff` · `report-writing` ·
`triage-validation` · `evidence-hygiene` · `bugcrowd-reporting` ·
`redteam-mindset` · `redteam-report-template` · `mid-engagement-ir-detection` ·
`hunt-dispatch`

### Payloads, arsenal & web3
`security-arsenal`

### Web3 & token security
`meme-coin-audit` · `web3-audit`

> The consolidated end-to-end workflow lives in **`bug-bounty`** — start there
> if you want the full campaign loop, or in **`bb-methodology`** for the
> standalone 5-phase hunting framework.

---

## Usage notes

- Skills are **on-demand expertise**: only a skill's `name` + `description`
  occupy context until it is triggered. Installing all 93 costs almost no
  context until you actually use one.
- The `bb-*` family models a multi-agent operating system (ScopeGuard,
  Router, Analyzers, Verifier, Reporter). Standalone hunters can ignore the
  OPS plumbing and use the `hunt-*` skills directly.
- Every skill was battle-tested against the classes it documents; validation
  gates mark what counts as *proof* versus *suspicion*.

---

## License

MIT. This repository is a derivative of
[**Agentic-Bug-Hunter**](https://github.com/Awarexone/Agentic-Bug-Hunter)
(MIT) by Awarexone — see [LICENSE](LICENSE). The skill methodology content is
extended, reorganized, and rewritten into the standalone Agent Skills format;
upstream remains the credited origin of the bug-bounty workflow lineage.

## Security

Found a problem in a skill, or think a skill leaks something it shouldn't?
See [SECURITY.md](SECURITY.md).