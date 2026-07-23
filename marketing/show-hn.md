# Show HN: Quality Guardian — AI agent that tests any product like real users

## Title

**Show HN: Quality Guardian — AI-powered QA framework that finds bugs without reading source code**

---

## Post Body

I built an open-source AI testing framework that found 4 P0 bugs in my own project on the first run. Two of them would have been catastrophic if shipped.

The core insight: **you cannot objectively test your own work.** Your brain fills in the gaps. You know where everything is supposed to be. So you miss the things a real user would stumble on.

### How it works

Quality Guardian is a Claude Code skill framework. Drop it into any project and run one command. It does not read your source code, your API docs, or your database schema. Instead, it:

1. **Auto-detects your project type** — Web, CLI, API, game, mobile app, desktop app, mini program
2. **Finds and connects to your running dev server** — scans common ports (3000, 5173, 8080, 4200), reads your config
3. **Dispatches 6 Guardians in parallel** — each tests one quality dimension (reachability, understandability, reliability, responsiveness, delight, inclusivity)
4. **Dispatches 4+ Simulators** — AI agents acting as real user personas (newcomer, power user, impatient user, perfectionist) that *use* your product and report in first person
5. **Compiles everything** into a structured acceptance report with scores, P0/P1/P2 findings, and simulator feedback

### The architecture that makes blind testing possible

The key design decision was **isolation**. Each Guardian and Simulator runs as an independent sub-agent with:

- **No filesystem access** — they cannot read your project files
- **No source code leakage** — the orchestrator never passes code, configs, or schemas to agents
- **Only visible surface** — product URL, screenshots, and the quality framework definitions

This means the testing is truly blind. A Guardian evaluating your web app doesn't know whether you used React, Vue, or vanilla JS. It only knows what it sees in the browser.

### 4 depth levels for different contexts

| Level | Time | Cost | Use Case |
|-------|------|------|----------|
| L1 `--quick` | 5-10 min | ~$0.50 | Daily dev check, quick smoke test |
| L2 (default) | 20-40 min | ~$2-3 | Pre-PR acceptance, standard QA |
| L3 `--deep` | 1-3 hr | ~$8-15 | Pre-release deep audit |
| L4 `--exhaustive` | 4-8 hr | ~$20-50 | Compliance, pre-launch final gate |

The depth levels don't just change runtime — they change the scope of testing. L1 tests only happy paths with 1 simulator. L3 does systematic boundary exploration with 4-5 simulators. L4 runs full Cartesian product coverage with security and accessibility audits.

### Real results

I tested this on [Starlight Tarot](https://github.com/1685yhy/starlight-tarot), a WeChat mini-program I built. The report gave it **63/100** and found:

- **P0: Pricing mismatch** — Frontend displayed $19.9/month, backend charged $29.9/month
- **P0: JWT secret default** — `"change-me-in-production"` still in production config
- **P0: Zero accessibility** — No alt text on 78 card images
- **P0: No upgrade path** — Free users hit a paywall with no guidance

The pricing bug alone would have been a consumer compliance issue. The JWT bug would have exposed all user data.

### What makes it different from existing tools

| Tool | Approach | Source code access? | User simulation? |
|------|----------|-------------------|-----------------|
| Playwright/Cypress | Predefined assertions | Yes (test code) | No |
| ESLint/SonarQube | Static analysis | Yes | No |
| Lighthouse | Performance audit | No | No |
| **Quality Guardian** | **AI blind testing** | **No** | **Yes (persona simulation)** |

It's not a replacement for unit tests or E2E tests. It's a **complementary layer** that catches the things traditional testing misses — usability issues, cognitive load, emotional response, and configuration mistakes that static analysis won't flag.

### CI/CD integration

A one-file GitHub Actions workflow provides automatic PR-level quality gating:

```
.github/workflows/quality-check.yml
```

Every PR gets automated checks for page accessibility, console errors, Core Web Vitals (LCP/FCP/CLS), security headers, and an auto-posted summary comment.

### Getting started

```bash
cd your-project
git clone https://github.com/1685yhy/quality-guardian.git .claude/quality-guardian
# In Claude Code:
/quality-guardian accept --quick
```

That's it. Complete acceptance report in 5 minutes.

### What I'd love feedback on

1. **The persona system** — We have 8 base personas that get dynamically combined per project. Does this cover enough user types? What's missing?
2. **Scoring methodology** — 6 dimensions with weighted scoring. The weights shift based on product type (reliability gets heavier for payment apps, delight gets heavier for games). Is this approach sound?
3. **CI/CD integration** — Should we add a GitHub Action directly, or is the YAML template enough?
4. **Pricing/Cost concerns** — What runtime cost would be acceptable for a CI-integrated version?

---

**GitHub**: https://github.com/1685yhy/quality-guardian

MIT License. Written in Markdown (skill definitions) with shell scripts for Chrome automation.

Would love to hear your thoughts, critiques, and ideas.

🛡️
