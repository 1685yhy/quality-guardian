# Reddit Posts — Quality Guardian

---

## r/programming — Technical Deep-Dive

**Title**: Quality Guardian — An AI framework that acceptance-tests your project without reading source code. Found 4 critical bugs in my own app.

**Post**:

I built an AI-powered acceptance testing framework called **Quality Guardian**, and the first time I ran it on my own project, it found 4 P0 bugs I had completely missed.

The approach is different from traditional testing tools, so I wanted to share the architecture and design decisions.

### The problem with self-testing

When you test your own code, you suffer from cognitive biases:
- **Confirmation bias**: you subconsciously navigate paths you know work
- **The Curse of Knowledge**: you know what every button does, so you don't notice unclear labels
- **Blind spots**: you never think to check if the JWT secret is still the default value because "of course I changed it"

Traditional tools don't solve this. Playwright/Cypress test against predefined assertions — you write what you expect, and you don't write assertions for things you didn't think of. Static analysis catches code issues but can't evaluate UX.

### The architecture

Quality Guardian uses **multi-agent orchestration** with strict isolation:

**6 Guardian agents** (structured quality checking):
- Reachability: Can users find features? (navigation depth, entry points, discoverability)
- Understandability: Do users get it? (cognitive load, terminology, self-explanatory interfaces)
- Reliability: Does it work? (error handling, data safety, edge cases)
- Responsiveness: Is it fast? (loading states, feedback latency, animations)
- Delight: Is it enjoyable? (visual quality, micro-interactions, emotional design)
- Inclusivity: Can everyone use it? (accessibility, i18n, device adaptation)

Each guardian operates as an **independent sub-agent with no filesystem access**. It only receives the product URL, a screenshot, and its quality dimension definition. No source code, no config files, no DB schemas.

**4+ Simulator agents** (first-person user simulation):
- Act as specific user personas (newcomer, power user, impatient, perfectionist, etc.)
- Interact with the product using browser automation (Chrome MCP)
- Report in first person: "I got confused here", "This button made me angry"
- Each simulator has a backstory, skill level, and emotional disposition

**Feedback Compiler** (conflict resolution):
- Cross-references Guardian and Simulator findings
- Resolves contradictions using priority rules (simulator experience > theoretical analysis)
- Produces the final acceptance report with scores and prioritized findings

### Blind testing is the key constraint

The most important design decision was **information isolation**. The orchestrator is the only component that knows about the project structure. Every Guardian and Simulator operates in a blank context:

```
Orchestrator (knows everything)
  ├── Guardian: Reachability (knows nothing about the project)
  ├── Guardian: Reliability (knows nothing about the project)
  ├── Simulator: Newcomer "Xiaoyu" (knows nothing about the project)
  └── Simulator: Impatient "Ajie" (knows nothing about the project)
```

This prevents the AI from using its knowledge of the codebase to rationalize away problems. If a Guardian can't find the registration button, it can't think "well, I know the auth code is in `src/auth/login.tsx`, so maybe the button is loading" — it has to report what it actually sees.

### Real results

Testing on a WeChat mini-program (Starlight Tarot) revealed:

- **P0: Pricing mismatch** — UI showed different prices than backend charged (hardcoded discrepancy)
- **P0: JWT secret on default** — `JWT_SECRET = "change-me-in-production"` in production
- **P0: Zero accessibility** — No alt text on any of 78 images
- **P0: Missing conversion paths** — No upgrade entry points on homepage

The full report scored 63/100, with Reliability at 44% and Inclusivity at 43%.

### Depth levels as a cost-control mechanism

| Level | Time | Agent cost | Coverage |
|-------|------|-----------|----------|
| L1 (--quick) | 5-10 min | ~$0.50 | 1 simulator, happy path only |
| L2 (default) | 20-40 min | ~$2-3 | 3-4 simulators, happy + error |
| L3 (--deep) | 1-3 hr | ~$8-15 | 4-5 simulators, boundary testing |
| L4 (--exhaustive) | 4-8 hr | ~$20-50 | All simulators, security + a11y audit |

### Tech stack details

- **Framework**: Markdown agent definitions consumed by Claude Code
- **Browser automation**: Chrome MCP protocol (Playwright-based)
- **Project detection**: scans package.json, vite.config, next.config for port/type info
- **CI/CD**: GitHub Actions with `actions/github-script@v7` for PR commenting
- **Scoring**: Weighted 6-dimension model (Reliability at 25% weight, Understandability at 20%, etc.)
- **Licensing**: MIT

### Questions for discussion

1. How do you handle QA for personal projects without a dedicated QA team?
2. Do you think AI-based blind testing could replace human QA for certain categories?
3. What's your experience with using AI agents for testing — useful gimmick or genuinely practical tool?

**GitHub**: https://github.com/1685yhy/quality-guardian

---

## r/webdev — Web Testing Specific

**Title**: I made an AI that acceptance-tests web apps like a real user — it runs in the browser, catches UX bugs, and posts results to PRs automatically

**Post**:

As a web developer, I've always struggled with one thing: **I can't test my own work objectively.**

I know where every button is. I know every URL. I know what every error message means because I wrote it. So my "manual testing" is really just me walking through paths I'm confident work.

I built **Quality Guardian** to solve this for myself, and it's been eye-opening.

### How it tests web apps

When you run it, here's what happens:

1. It scans your dev server (port 3000, 5173, 8080, etc.)
2. Opens Chrome and navigates to your app (via Chrome MCP)
3. Dispatches 6 parallel reviewers that each check one aspect:
   - **Reachability** — Can users find everything? (navigation depth, discoverability)
   - **Understandability** — Is the UX self-explanatory? (labels, terminology, cognitive load)
   - **Reliability** — Error handling, input validation, confirmations
   - **Responsiveness** — Loading states, feedback, animations
   - **Delight** — Visual polish, micro-interactions, emotional design
   - **Inclusivity** — Accessibility, responsive design, contrast, font sizes

4. Simultaneously dispatches 4+ simulator users with different personalities:
   - **Newcomer**: never used your app, navigating by intuition
   - **Power User**: wants keyboard shortcuts and hates extra clicks
   - **Impatient**: anything over 2 seconds is too slow
   - **Perfectionist**: notices every CSS inconsistency

5. A Feedback Compiler reconciles all findings into one report with scores and prioritized fixes

### The simulator feedback is the secret sauce

Traditional testing produces: "Test failed: element #submit-button not visible"

Simulator feedback produces:

> "I clicked 'Start Reading' and nothing happened for 4 seconds. I almost closed the tab. Change default mode from 'immersive' to 'quick' — let the people who want ceremony opt in."
> — Impatient user

> "What is a 'card spread'? The app has 10 options but none of them explain what they do. I guessed and picked the wrong one."
> — Newcomer

This first-person feedback is incredibly actionable. It tells you *how* to fix the problem, not just *that* there is one.

### Automated PR testing

One YAML file and every PR gets:

```yaml
- name: Clone Quality Guardian
  run: git clone https://github.com/1685yhy/quality-guardian.git /tmp/quality-guardian
- name: Start Chrome
  run: bash /tmp/quality-guardian/scripts/start-chrome.sh 9222
- name: Post Results
  uses: actions/github-script@v7
  # Auto-comments on the PR
```

Results include: page load check, console errors, Core Web Vitals (LCP/FCP/CLS), security headers, and a summary score.

### Real example

Tested on my Starlight Tarot project (WeChat mini-program, web-adjacent tech stack). Found:

- **P0**: Prices displayed on frontend didn't match backend charges
- **P0**: JWT secret was the default placeholder value
- **P0**: 78 images with zero alt text
- **P1**: "You have 3 free readings" but code showed only 1 — copy mismatch

Total score: 63/100. Four out of six quality dimensions failed.

The project looked polished (95% on Delight!) but had fundamental reliability issues that traditional testing would not catch because they were configuration errors, not logic errors.

### Try it

```bash
git clone https://github.com/1685yhy/quality-guardian.git .claude/quality-guardian
# Then in Claude Code:
/quality-guardian accept --quick
```

Free. Open source. MIT. Works on any web project.

**GitHub**: https://github.com/1685yhy/quality-guardian

---

## r/ClaudeAI — Claude Code Skill Showcase

**Title**: Quality Guardian — a Claude Code skill that turns AI into a full QA team for any project (found 4 P0 bugs in my own app)

**Post**:

I've been using Claude Code extensively for development, and one thing kept bugging me: **how do I test that Claude's code actually works well for real users?**

I can't test my own work objectively. And asking Claude to test its own output is circular reasoning.

So I built **Quality Guardian** — a Claude Code skill framework that orchestrates a team of independent AI agents to do acceptance testing on any project.

### How it uses Claude Code's agent capabilities

The framework is a set of agent definition files that Claude Code reads and executes. The orchestrator.md is the entry point — it defines the workflow:

1. **Auto-detect project type** — Claude reads package.json, config files, and directory structure
2. **Find the running dev server** — Claude scans ports or starts the dev server
3. **Launch Chrome** — via local Chrome MCP using the superpowers-chrome plugin
4. **Fork parallel sub-agents** — 6 Guardians + 4 Simulators run simultaneously as independent AI contexts
5. **Compile results** — Feedback Compiler merges everything into a report

### The key design choices

**Blind sub-agents**: Each Guardian and Simulator is launched with **zero project context**. No source code. No config. No API docs. They only get:
- The product URL (or screenshots)
- Their specific testing role definition
- A blank slate

This prevents the AI from rationalizing away problems. A Guardian that can't find the login button can't think "well, I know the auth module is there" — it has to report what it sees.

**First-person simulation**: Simulators don't write analysis, they write *experience reports*. The Impatient User Simulator says things like:

> "I clicked this and nothing happened for 3 seconds. I'm leaving."

This is way more actionable than "response time exceeds threshold."

**Conflict resolution**: When a Guardian says something is fine but a Simulator got stuck, the Simulator wins. The rule is: "real users don't lie."

### What Claude Code skills are good for

This project showed me something: Claude Code skills are incredibly powerful for defining **workflows**, not just single actions. The orchestrator pattern (one main agent that coordinates sub-agents) is something I think more Claude Code skills should adopt.

The skill definition is just Markdown files with structured prompts. No compilation, no packaging, no npm install. You clone the repo into `.claude/quality-guardian/` and you're done.

### Results from real testing

Used on Starlight Tarot (my WeChat mini-program project). Report: 63/100.

Found issues I never would have caught:
- Frontend/backend price mismatch (P0 - legal risk)
- Default JWT secret in production (P0 - security risk)  
- Zero accessibility on 78 images (P0 - exclusion)
- No membership upgrade path on homepage (P0 - lost revenue)

Fix rate after report: 100% for P0 issues, 60% for P1 issues within 48 hours.

### Getting started

```bash
cd your-project
git clone https://github.com/1685yhy/quality-guardian.git .claude/quality-guardian
```

Then in Claude Code:
```
/quality-guardian accept --quick
```

You'll get a complete acceptance report in 5 minutes.

### What I'd like feedback on

1. Does the orchestrator + sub-agent pattern work well in your Claude Code setup?
2. What kinds of products would you most want to test with this? (web, CLI, API, games, mobile?)
3. The 6-dimension quality model — does it cover what you'd want from an acceptance test?

**GitHub**: https://github.com/1685yhy/quality-guardian

MIT License. Free. Open source.
