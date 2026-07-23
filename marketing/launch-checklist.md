# Quality Guardian — Launch Operations Checklist

> **Status tracking**: [ ] = not started | [x] = done | [-] = skipped

---

## PHASE 0: Pre-Launch (2-3 weeks before launch day)

### Repo Polish

- [ ] **README review**: Is it clear, well-formatted, with proper badges? Include:
  - [ ] MIT license badge
  - [ ] Claude Code skill badge
  - [ ] Screenshot of the acceptance report (from Starlight Tarot case study)
  - [ ] Quick-start section with copy-paste commands
  - [ ] Architecture diagram (ASCII or image)
  - [ ] Links to case studies
  - [ ] CI/CD one-file setup
- [ ] **Add a GIF/demo** to README showing terminal walkthrough
- [ ] **Ensure `.claude/settings.json`** is in repo for auto-skill detection
- [ ] **Add GitHub Topics**: `acceptance-testing`, `ai-agent`, `claude-code`, `developer-tools`, `quality-assurance`, `ux-testing`
- [ ] **Add a LICENSE file** (MIT)
- [ ] **Add a CONTRIBUTING.md** with contribution guidelines
- [ ] **Set up GitHub Pages** or wiki for detailed docs

### Documentation

- [ ] **Write comprehensive README** (done)
- [ ] **Document architecture** in `docs/architecture.md`
- [ ] **Write growth strategy** in `docs/growth-strategy.md` (exists)
- [ ] **Add a `docs/faq.md`** with anticipated questions
- [ ] **Add examples** for each product type:
  - [x] `examples/web-app-example.md`
  - [x] `examples/game-example.md`
  - [x] `examples/mini-program-example.md`
  - [x] `examples/mobile-app-example.md`
- [ ] **Add CI/CD integration docs** (`docs/ci-cd-integration.md`)

### Case Studies

- [x] **Starlight Tarot case study** (in `case-studies/`)
  - [x] Acceptance report with 63/100 score
  - [x] Guardian findings (6 dimensions)
  - [x] Simulator feedback (4 personas)
  - [x] Conflict resolution records
  - [x] P0/P1/P2 prioritized fix list
- [ ] **Add 2-3 more case studies** from beta testers (if available)
- [ ] **Get permission** to quote tester feedback publicly

### Beta Testing

- [ ] **Recruit 5-10 beta testers** from developer communities
  - [ ] r/programming
  - [ ] r/webdev
  - [ ] r/ClaudeAI
  - [ ] Hacker News
  - [ ] Twitter/X developer circles
- [ ] **Collect beta tester quotes** for marketing materials
- [ ] **Fix critical bugs** found by beta testers
- [ ] **Test on multiple project types**: Web, CLI, API, static site

### Social Presence

- [ ] **Create Twitter/X account** (@qualityguardian or similar) — optional
- [ ] **Create Product Hunter account** (if launching on PH)
- [ ] **Write draft posts** for all platforms (done in this package)
- [ ] **Prepare 3-5 screenshots/GIFs** for social sharing
- [ ] **Create a demo video** (60-90 seconds, see demo-script.md)
- [ ] **Upload demo video** to YouTube (unlisted, ready for launch)

### Assets

- [ ] **Logo / avatar image** (shield icon suggested — theme fits "Quality Guardian")
- [ ] **Social sharing image** (1200x630 for Twitter/Facebook)
- [ ] **Terminal recording** terminalizer or asciinema of quick start
- [ ] **Product Hunt assets**:
  - [ ] Logo (required)
  - [ ] Screenshot gallery (3-5 images)
  - [ ] Demo video or GIF

---

## PHASE 1: Launch Day (D-Day)

### Time Planning

> **Recommended**: Tuesday or Wednesday, 12:01 AM PST
> This aligns with Product Hunt's daily reset for maximum 24h exposure.
> Hacker News has best engagement early morning US time (6-8 AM ET).

### Sequence (optimized for maximum cross-platform momentum)

**06:00 AM PST (09:00 AM ET)** — Kickoff

- [ ] **Post to Hacker News** ("Show HN: Quality Guardian — AI agent that tests any product like real users")
  - URL: https://news.ycombinator.com/submit
  - Link: https://github.com/1685yhy/quality-guardian
  - Best time: morning US hours = highest HN engagement

**06:05 AM PST** — Reddit Posts

- [ ] **Post to r/programming**
  - Title: "Quality Guardian — AI framework for acceptance testing without source code access"
  - Link: https://github.com/1685yhy/quality-guardian
- [ ] **Post to r/webdev**
  - Title: "I made an AI that tests web apps like real users — catches UX issues traditional tools miss"
  - Link: https://github.com/1685yhy/quality-guardian
- [ ] **Post to r/ClaudeAI**
  - Title: "Quality Guardian — Claude Code skill for AI-powered acceptance testing (found 4 P0 bugs in my project)"
  - Link: https://github.com/1685yhy/quality-guardian

**06:30 AM PST** — Developer Blogs

- [ ] **Post to Dev.to** (English blog post)
  - Title: "I Built an AI Agent That Does Acceptance Testing — It Found 4 Critical Bugs I Missed"
  - URL: https://dev.to/new
  - Tags: ai, testing, quality-assurance, claude, devtools
- [ ] **Post to Medium** (English blog post)
  - URL: https://medium.com/new-story
  - Publication pitch: "Better Programming", "Level Up Coding", or self-publish
- [ ] **Post to 掘金 (Juejin)** (Chinese blog post)
  - Title: "我写了一个AI Agent，让它自动给我的项目做验收，结果发现了4个致命Bug"
  - URL: https://juejin.cn/post/new
- [ ] **Post to 知乎 (Zhihu)** (Chinese blog post)
  - URL: https://zhihu.com/question/new 或专栏

**07:00 AM PST** — Social Media

- [ ] **Post Twitter/X thread** (10 tweets)
  - Time: peak developer Twitter hours (8-10 AM ET)
  - Include a screenshot of the acceptance report (63/100 table)
  - Pin the thread to profile
- [ ] **Post to LinkedIn**
  - Shorter version of the story
  - Tag developer communities / colleagues
- [ ] **Post to 微信朋友圈 (WeChat Moments)**
  - Chinese version
  - Target: Chinese developer community

**08:00 AM PST** — Product Hunt

- [ ] **Submit to Product Hunt**
  - URL: https://www.producthunt.com/posts/new
  - Tagline: "AI-powered QA team that tests your product like real users would"
  - Category: Developer Tools > Testing / QA
  - Gallery images ready
  - First comment: Origin story (from producthunt.md)
  - Maker comment
  - Schedule for 12:01 AM PST if possible

### Launch Day Support

- [ ] **Monitor all platforms** for questions and comments
- [ ] **Reply to every HN comment** within 1 hour (HN ranks by engagement velocity)
- [ ] **Reply to every Reddit comment** within 30 minutes
- [ ] **Upvote and reply** to Product Hunt comments
- [ ] **Schedule 2-3 follow-up tweets** throughout the day
  - Tweet 1 (noon): "We hit [X] stars on GitHub! Thanks everyone!"
  - Tweet 2 (3 PM): A simulator quote that's getting traction
  - Tweet 3 (6 PM): "Day 1 stats: [X] clones, [Y] stars, [Z] case studies created"
- [ ] **Keep demo video available** for anyone asking "how does it work?"

---

## PHASE 2: Post-Launch (D+1 to D+14)

### Week 1: Engagement

- [ ] **Track metrics daily**:
  - GitHub stars
  - GitHub clones / forks
  - Website visits (goatcounter or similar)
  - Product Hunt upvotes
  - Reddit upvotes and comments
  - Twitter impressions and engagement
  - Blog post reads
- [ ] **Respond to all GitHub Issues** within 24 hours
- [ ] **Merge first community PRs** quickly to show activity
- [ ] **Post "Week 1 Results"** on dev.to / blog
  - "What we learned from launching Quality Guardian"
  - Include metrics, community feedback, lessons

### Week 2: Follow-up

- [ ] **Follow up on HN comments** — users who asked questions may not have seen replies
- [ ] **Write follow-up post** based on community feedback
- [ ] **Add top requested features** based on Issues
- [ ] **Reach out to dev tool newsletters**:
  - [ ] TLDR Newsletter
  - [ ] Bytes
  - [ ] Python Weekly / JavaScript Weekly
  - [ ] DevTools Weekly
  - [ ] Changelog Weekly
- [ ] **Reach out to AI/developer YouTubers** for reviews:
  - [ ] Fireship (AI Explained style)
  - [ ] Theo - t3.gg
  - [ ] NetworkChuck
  - [ ] Chinese tech YouTubers
- [ ] **Post to alternative aggregators**:
  - [ ] Lobste.rs
  - [ ] Echo JS (if JS project)
  - [ ] Terminal Trove (for terminal/CLI focus)

### Month 1: Sustain

- [ ] **Publish "Starlight Tarot case study deep-dive"** as a standalone blog post
- [ ] **Publish a tutorial** on integrating Quality Guardian with different project types
- [ ] **Add a "Tester Hall of Fame"** to README highlighting the most useful bugs caught
- [ ] **Release v1.0 milestone** with all critical features stable
- [ ] **Create GitHub Discussions** for community Q&A
- [ ] **Add a `--ci-mode` flag** optimized for CI environments
- [ ] **Publish npm/brew/one-liner installer** (make it even easier to try)

---

## Links for Each Platform

| Platform | URL | Action |
|----------|-----|--------|
| GitHub | https://github.com/1685yhy/quality-guardian | Main repo |
| Hacker News | https://news.ycombinator.com/submit | Submit "Show HN" |
| Product Hunt | https://www.producthunt.com/posts/new | Launch |
| Reddit r/programming | https://www.reddit.com/r/programming/submit | Link post |
| Reddit r/webdev | https://www.reddit.com/r/webdev/submit | Link post |
| Reddit r/ClaudeAI | https://www.reddit.com/r/ClaudeAI/submit | Link post |
| Dev.to | https://dev.to/new | Cross-post blog |
| Medium | https://medium.com/new-story | Cross-post blog |
| 掘金 (Juejin) | https://juejin.cn/post/new | Chinese blog |
| 知乎 (Zhihu) | https://zhuanlan.zhihu.com/write | Chinese blog |
| Twitter/X | https://twitter.com/compose/tweet | Thread |
| LinkedIn | https://linkedin.com | Status update |

---

## Metrics to Track

| Metric | Target (Day 1) | Target (Week 1) | Stretch Goal |
|--------|---------------|----------------|-------------|
| GitHub Stars | 50 | 200 | 500 |
| GitHub Clones | 100 | 500 | 1000 |
| Product Hunt Upvotes | 50+ | - | Top 5 of day |
| HN Upvotes | 50+ | - | Front page |
| Reddit (combined) | 100+ total | - | Hot on r/programming |
| Blog reads (combined) | 1000+ | 5000+ | 10000+ |
| Twitter impressions | 5000+ | 25000+ | 100000+ |
| PRs Merged | 0 | 3+ | 10+ |
| Case Studies Created | 1 | 5+ | 20+ |

---

## Emergency Rollback Plan

- If HN/Reddit comments are mostly negative:
  - [ ] Identify top 3 criticisms
  - [ ] Write honest response post acknowledging limitations
  - [ ] Focus on improvement roadmap
- If GitHub Issues report critical bugs:
  - [ ] Tag as P0, fix within 24 hours
  - [ ] Communicate fix timeline publicly
- If Product Hunt launch is underperforming:
  - [ ] Rally existing users to upvote (within PH rules)
  - [ ] Post update with new info to drive re-engagement
- If no traction by day 3:
  - [ ] Reassess positioning/messaging
  - [ ] Consider a different angle ("AI user testing" vs "acceptance framework")
  - [ ] Plan relaunch with improved messaging after 4-6 weeks
