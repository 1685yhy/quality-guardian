# I Built an AI Agent That Does Acceptance Testing — It Found 4 Critical Bugs I Missed

## The Problem Nobody Talks About

Here's an uncomfortable truth about software development: **you cannot objectively test your own work.**

Your brain fills in the gaps. You know where the button "should" be, so you don't notice it's hidden. You know what that icon means, so you don't realize new users won't. You know the payment flow *should* work, so you don't double-check that the frontend price matches the backend price.

I learned this the hard way.

I was building [Starlight Tarot](https://github.com/1685yhy/starlight-tarot), a WeChat mini-program for tarot readings. On paper, it was feature-complete. The UI was beautiful — a 300-line CSS design system with parallax stars, breathing glow effects, and a three-stage ritual loading animation. The animations alone took weeks.

But before launch, I ran an experiment: I built an AI agent that would test my project **without reading a single line of source code**. No API docs. No database schemas. No development context. Just: "Here's the product. Go use it."

What it found was humbling.

## 4 Critical Bugs (Yes, P0)

The AI acceptance report gave the project **63/100**. Here's what it uncovered:

### 1. Pricing Fraud Risk (P0)
Frontend showed: Membership at $19.9/month, $168/year, $9.9/student  
Backend actually charged: $29.9/month, $198/year, student plan doesn't exist  

The prices were hardcoded differently in frontend and backend. If shipped, this would be a compliance nightmare and a trust destroyer.

### 2. JWT Default Secret (P0)
`JWT_SECRET = "change-me-in-production"`  

Right there in the config. Not changed. Any attacker could forge arbitrary user tokens and access the entire user database.

### 3. Zero Accessibility (P0)
78 tarot cards. 78 images. Zero alt text. One single `aria-label` across the entire project. Blind users couldn't use a single feature.

### 4. No Upgrade Path (P0)
The homepage had zero entry points for the membership upgrade. When free trials ran out, users just got an obnoxious popup blocking their path with no guidance.

---

Two of these — the pricing mismatch and the JWT secret — could have destroyed the product on launch day. I caught them because an AI agent tested my work the way a real user would.

The idea was too valuable to keep to myself.

## Enter Quality Guardian

**Quality Guardian** is an open-source Claude Code skill framework that turns AI agents into a full QA team. Drop it into any project, run one command, and it orchestrates a parallel testing operation:

- 6 **Guardians** — structured quality assessment across 6 dimensions
- 4+ **Simulators** — first-person user personas that *use* your product like real humans
- 1 **Feedback Compiler** — conflict resolution between structured analysis and real-user feedback

### The Architecture

**6 Guardians (Quality Dimensions):**

| Guardian | Core Question | Weight |
|----------|--------------|--------|
| Reachability | Can users find it? | 15% |
| Understandability | Can users understand it? | 20% |
| Reliability | Does it work correctly? | 25% |
| Responsiveness | Is it fast and responsive? | 15% |
| Delight | Is it enjoyable to use? | 15% |
| Inclusivity | Can everyone use it? | 10% |

**Simulator Personas:**

| Persona | Type | Focus |
|---------|------|-------|
| Newcomer | First-time user | Onboarding, clarity, guidance |
| Power User | Expert, frequent user | Efficiency, shortcuts, batch ops |
| Impatient | Low tolerance user | Speed, error recovery, no-nonsense |
| Perfectionist | Detail-obsessed | Visual consistency, polish |
| Explorer | Casual discoverer | Serendipity, richness |
| Accessibility-need | User with disabilities | Contrast, screen readers, font size |
| Tough-environment | Poor network/device | Offline, slow network, small screen |
| Edge-case-user | Malicious/tricky | Input validation, boundaries |

### How the Conflict Resolution Works

The Feedback Compiler cross-references Guardian and Simulator findings:

- **Simulator finds a problem that Guardian missed** → Simulator wins. Marked as "Guardian miss," priority unchanged.
- **Guardian says pass, but Simulator got stuck** → Simulator wins. Real users don't lie.
- **Guardian finds a problem, but no Simulator encountered it** → Guardian wins. Marked as "theoretical risk," priority downgraded.
- **Both agree** → Highest confidence, directly into the report.

### 4 Depth Levels

| Level | Time | Items/Dimension | Simulators | Coverage |
|-------|------|----------------|------------|----------|
| L1 Quick (`--quick`) | 5-10 min | 3-5 | 1 | Happy path only |
| L2 Standard (default) | 20-40 min | 8-12 | 3-4 | Happy + error paths |
| L3 Deep (`--deep`) | 1-3 hr | 15-25 | 4-5 | Systematic boundary testing |
| L4 Exhaustive (`--exhaustive`) | 4-8 hr | Full coverage | All | Security + accessibility audit |

### Universal Product Testing

Quality Guardian auto-detects your product type and selects the right testing approach:

| Product Type | Testing Method |
|-------------|---------------|
| Web App / SaaS | Chrome MCP (real browser automation) |
| WeChat Mini Program | DevTools MCP |
| CLI / Command-line Tool | Command execution testing |
| API / Backend Service | curl endpoint testing |
| Native App (iOS/Android) | adb + xcrun automation |
| Game (Unity/Unreal/Godot) | Engine detection + WebGL + screenshot analysis |
| Desktop App (Electron/Qt/.NET) | Web version -> CLI -> UIA |
| No automation available | Screenshot/scenario degradation (L2/L3) |

## Real Simulator Feedback

Here's what the Simulators said about Starlight Tarot:

> **Impatient user "Ajie" (programmer, age 30):**
> "Change the default mode from 'immersive' to 'quick'. Let the people who want ceremony go turn it on themselves. Don't gamble conversion rates with everyone's time."

> **Newcomer "Xiaoyu" (social media operator, age 25):**
> "What is a 'spread'? I had no idea what 'Lovers Triangle' or 'Celtic Cross' meant. There was no explanation at all."

> **Perfectionist "Vivian" (UI designer, age 32):**
> "The same `.heading-1` class renders at different font sizes on different pages. This is an architecture problem, not a styling issue."

These aren't analytical conclusions — they're **first-person experiences**. Reading them feels like having 4 real users test your product simultaneously. That's the core value of Quality Guardian.

## CI/CD Integration

Every PR can automatically trigger a quality scan:

```yaml
name: Quality Guardian Check
on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  quality-check:
    runs-on: ubuntu-latest
    timeout-minutes: 30
    steps:
      - uses: actions/checkout@v4
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      - name: Install Chromium
        run: npx playwright install chromium
      - name: Clone Quality Guardian
        run: git clone https://github.com/1685yhy/quality-guardian.git /tmp/quality-guardian
      - name: Run Quick Check
        run: |
          bash /tmp/quality-guardian/scripts/start-chrome.sh 9222
          # Automatic page checks + console error detection
      - name: Post results
        uses: actions/github-script@v7
        with:
          script: |
            # Automatically posts results to the PR
```

Every PR gets: page accessibility check, console error detection, Core Web Vitals (LCP/FCP/CLS), security headers audit, and a summary comment posted directly to the PR.

## Getting Started

```bash
cd your-project
git clone https://github.com/1685yhy/quality-guardian.git .claude/quality-guardian
```

Then in Claude Code:

```
/quality-guardian accept --quick
```

That's it. It scans your running dev server, launches Chrome, dispatches the Guardian and Simulator teams, and produces a complete acceptance report.

## The Vision

I believe that soon, **every PR will automatically run AI-powered acceptance testing**, the same way every PR runs CI today.

Quality Guardian is my attempt to build that future, starting today.

It's open source. MIT licensed. A single command away.

**GitHub**: https://github.com/1685yhy/quality-guardian

Star it. Clone it. Run it on your next project. You might be surprised what it finds.
