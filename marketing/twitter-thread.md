🧵 **10 tweets about Quality Guardian — the AI QA team I built that found 4 critical bugs in my own project**

---

1/10
I built an AI QA team that tests products without reading a single line of source code.

It found 4 P0 bugs in my own project before launch.

One of them would have been a direct hit to my users' trust.

Here's the story 🧵

---

2/10
This was the acceptance report for Starlight Tarot, a WeChat mini-program I've been building.

The AI gave it 63/100.

Scores by dimension:
• Response: 94% ✅
• Delight: 95% ✅
• Reachability: 65% ❌
• Understandability: 47% ❌
• Reliability: 44% ❌
• Inclusivity: 43% ❌

> 2 dimensions passed. 4 failed. 2 P0 bugs.

---

3/10
The 4 P0 bugs found:

1️⃣ Frontend showed $19.9/mo, backend charged $29.9/mo — pricing fraud risk
2️⃣ JWT_SECRET = "change-me-in-production" — still default. Anybody could forge tokens
3️⃣ 78 tarot cards, 0 alt text, 1 aria-label across entire project — blind users locked out
4️⃣ Zero membership upgrade paths on homepage — free users hit a paywall popup with no guidance

All found by an agent that never saw my source code.

---

4/10
Here's the architecture that makes this work:

**6 Guardians** — structured quality checkers
• Reachability — can users FIND it?
• Understandability — can users GET it?
• Reliability — does it WORK correctly?
• Responsiveness — is it FAST enough?
• Delight — is it ENJOYABLE?
• Inclusivity — can EVERYONE use it?

Each scores independently, then weighted into a final grade.

---

5/10

**4+ Simulators** — AI agents that act like real users:

• Newcomer: first time, clicks around, gets confused
• Power User: fast, keyboard-driven, hates inefficiency
• Impatient: zero patience, will close the tab if slow
• Perfectionist: notices every pixel misalignment

"They don't analyze the product. They USE it. And they tell you how it feels."

---

6/10
Real simulator feedback from the Starlight Tarot test:

> "Change default mode from 'immersive' to 'quick'. Don't gamble conversion rates with everyone's time."
> — Impatient user "Ajie"

> "What is a 'spread'? 'Lovers Triangle'? 'Celtic Cross'? No explanations at all."
> — Newcomer "Xiaoyu"

> "Same .heading-1 class, different font sizes across pages. Architecture problem."
> — Perfectionist "Vivian"

First-person. Honest. Actionable.

---

7/10
The Feedback Compiler reconciles Guardian vs Simulator findings:

• Simulator found it, Guardian missed → Simulator wins
• Guardian says pass, Simulator got stuck → Simulator wins
• Guardian flagged, no Simulator hit it → Guardian wins (downgraded to theoretical risk)
• Both agree → Highest confidence

Rule #1: "Real users don't lie."

---

8/10
CI/CD integration is one YAML file away.

Every PR gets:
✅ Page accessibility check
✅ Console error detection
✅ Core Web Vitals (LCP/FCP/CLS)
✅ Security headers audit
✅ Comment posted directly on the PR

```yaml
# .github/workflows/quality-check.yml
name: Quality Guardian Check
on: [pull_request]
jobs:
  quality-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Clone Quality Guardian
        run: git clone https://github.com/1685yhy/quality-guardian.git /tmp/quality-guardian
      - name: Run Quick Check
        run: bash /tmp/quality-guardian/scripts/start-chrome.sh 9222
```

---

9/10
Quality Guardian has 4 depth levels:

L1 Quick (--quick): 5-10 min, 1 simulator, happy path only
L2 Standard: 20-40 min, 3-4 simulators, happy + error paths
L3 Deep (--deep): 1-3 hours, 4-5 simulators, systematic boundary testing
L4 Exhaustive (--exhaustive): 4-8 hours, all simulators, security + accessibility audit

Quick for daily dev. Deep before release. Exhaustive for compliance.

---

10/10
It works for ANY product type:

• Web apps → Chrome MCP browser automation
• WeChat mini-programs → DevTools MCP
• CLI tools → command execution
• APIs → curl testing
• Native apps → adb + xcrun
• Games → engine detection + WebGL
• Desktop apps → screenshot analysis

→ No source code access. No dev context. Pure blind testing.

**GitHub**: https://github.com/1685yhy/quality-guardian

Try it. Star it. Break your own assumptions about your code.

🛡️

---

*Quality Guardian — AI-powered acceptance testing for any product. Open source. MIT.*

[github.com/1685yhy/quality-guardian](https://github.com/1685yhy/quality-guardian)
