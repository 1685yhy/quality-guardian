# Product Hunt Launch — Quality Guardian

## Product Info

**Name**: Quality Guardian
**Tagline**: AI-powered QA team that tests your product like real users would

**Description**:

Quality Guardian is an open-source Claude Code skill framework that transforms AI agents into a complete QA team for any product — web apps, mini programs, CLI tools, APIs, desktop apps, mobile apps, and games.

Unlike traditional testing tools that check against predefined test cases, Quality Guardian works by **blind testing**: it never reads your source code, never sees your API docs, never accesses your database schema. Instead, it dispatches 6 Guardians (structured quality checkers across reachability, understandability, reliability, responsiveness, delight, and inclusivity) plus 4+ Simulators (AI agents that act as real user personas — newcomer, power user, impatient user, perfectionist) to independently explore and test your product.

The result is an acceptance report with a 0-100 score, prioritized P0/P1/P2 findings with specific evidence, and first-person simulator feedback that reads like real user testing transcripts. All in 5 minutes (quick scan) to 8 hours (exhaustive audit), with CI/CD integration for automatic PR-level quality gating.

**Category**: Developer Tools
**Subcategory**: Testing / QA
**Pricing**: Free (MIT License, open source on GitHub)
**Website / GitHub**: https://github.com/1685yhy/quality-guardian

**Key Features**:
- Tests ANY product type — Web, Mini Program, CLI, API, Desktop, Game, Mobile App
- 4 depth levels from 5-min quick scan to 8-hr exhaustive audit
- 6 parallel Guardians scoring across quality dimensions
- 4+ Simulator personas providing real first-person user feedback
- Blind testing — no source code access needed
- Auto-detects project type and running dev servers
- Chrome MCP browser automation for web testing
- CI/CD integration with automatic PR commenting
- Conflict resolution between structured analysis and user simulation
- Progressive learning — tracks quality history across releases

---

## First Comment (Origin Story)

"We built Quality Guardian out of frustration.

I'm a PM by trade (Yan Haiyang at TAL Education). I kept running into the same problem: as developers, we cannot objectively test our own work. Our brains fill in the gaps. We know where the button 'should' be, so we don't notice it's hidden. We know what the price 'should' be, so we don't verify the frontend matches the backend.

During work on a tarot reading mini-program called Starlight Tarot, I built an AI agent to do acceptance testing without reading any source code. It found 4 critical P0 bugs that would have been catastrophic:
- Pricing mismatch between frontend and backend
- JWT secret still set to 'change-me-in-production'
- Zero accessibility — 78 card images with no alt text
- No upgrade path for free users hitting their limits

The 63/100 score report was humbling but invaluable. Two of those bugs would have destroyed user trust on launch day.

So I turned the idea into a general-purpose framework. Quality Guardian is the result — an open-source skill that can drop into any project and give it the same AI-powered, blind-testing treatment.

We hope it saves you from the same kind of embarrassment it saved us from."

— Yan Haiyang, Creator of Quality Guardian

---

## Maker Comment Template

Hi Product Hunt! 👋

I'm Yan, the creator of Quality Guardian.

As a PM turned builder, I've always been frustrated by how hard it is to do real quality assurance without a dedicated QA team. Unit tests and CI catch technical bugs, but they don't tell you if your product is actually usable, understandable, and delightful.

Quality Guardian is my attempt to solve this with AI agents. The key insight was: **don't read the source code.** If you want to know if a product is good, use it like a user would — not like a developer would.

The framework is completely open source under MIT license. Drop it into any project, run `/quality-guardian accept`, and get back a complete acceptance report with scores, prioritized findings, and first-person simulator feedback.

Would love your feedback and questions! Happy to share more about the architecture, the starlight tarot case study, or how we handle CI/CD integration.

🛡️

---

## Suggested Launch Details

**Day**: Tuesday (highest conversion day for Dev Tools launches)
**Alternative**: Wednesday (second best)
**Time**: 12:01 AM PST (aligns with PH daily reset for maximum 24-hour exposure)
**Date suggestion**: Pick a Tuesday with no major tech conferences or Apple events. Avoid US holiday weeks.

**Pre-launch checklist**:
- [ ] Polish README with screenshots of the acceptance report
- [ ] Add a GIF showing the terminal demo (from demo-script.md)
- [ ] Get 3-5 beta users to try it and provide quotes
- [ ] Prepare a short demo video (60-90 seconds)
- [ ] Post on Maker Communities (dev.to, reddit) 24h before to warm up
- [ ] Prepare a PH first comment (provided above)
- [ ] Pre-write replies to anticipated questions

**Anticipated questions & prepared answers**:

Q: "How is this different from Playwright/Cypress?"
A: Traditional tools test against predefined assertions. Quality Guardian doesn't know what the 'right answer' is — it discovers problems by exploring like a real user. It's complementary to structured testing, not a replacement.

Q: "Does it work in CI?"
A: Yes! We provide a ready-to-use GitHub Actions workflow. Every PR gets page accessibility checks, console error detection, Core Web Vitals measurement, and an auto-posted comment with results.

Q: "Is it only for web apps?"
A: No. It auto-detects your project type and adapts. Web apps use Chrome MCP. CLI tools use command execution. APIs use curl. Games use engine detection + screenshot analysis. Mini programs use DevTools. Everything falls back gracefully.

Q: "How much does it cost?"
A: It's free. MIT licensed. The only cost is the LLM API calls (Claude Code) to power the agents. You can choose your depth level to control cost.

Q: "Is the acceptance report accurate?"
A: In our testing against the Starlight Tarot project, it identified issues that took us days to manually verify. The Simulator feedback (first-person user experience) is uniquely valuable — these aren't test assertions, they're genuine-feeling user reactions. We recommend using it as part of a broader QA strategy, not as a replacement for human judgment.
