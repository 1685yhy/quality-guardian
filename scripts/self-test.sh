#!/bin/bash
# Quality Guardian 工程自检 — 验证框架内部一致性
# 每次提交前运行: bash scripts/self-test.sh

PASS=0
FAIL=0
ERRORS=""

check() {
  local desc="$1"
  local cmd="$2"
  if eval "$cmd" 2>/dev/null; then
    echo "✅ $desc"
    ((PASS++))
  else
    echo "❌ $desc"
    ((FAIL++))
    ERRORS="$ERRORS\n  - $desc"
  fi
}

echo "═══════════════════════════════════"
echo "  Quality Guardian 工程自检"
echo "═══════════════════════════════════"
echo ""

echo "── 文件完整性 ──"
check "README.md exists" "test -f README.md"
check "LICENSE exists" "test -f LICENSE"
check "orchestrator.md exists" "test -f orchestrator.md"
check ".gitignore exists" "test -f .gitignore"

echo ""
echo "── 框架核心文件 ──"
for f in framework/quality-dimensions.md framework/persona-system.md framework/deep-testing-guide.md framework/design-validation-guide.md framework/competitive-benchmarks.md framework/visual-regression-guide.md; do
  check "$f exists" "test -f $f"
done

echo ""
echo "── Guardian 团队 (6) ──"
for f in reachability understandability reliability responsiveness delight inclusivity; do
  check "guardians/$f.md exists" "test -f guardians/$f.md"
done

echo ""
echo "── Simulator 团队 (9) ──"
for f in persona-generator browser-user visual-user scenario-player feedback-compiler api-tester cli-tester desktop-tester native-app-tester miniapp-user game-tester; do
  check "simulators/$f.md exists" "test -f simulators/$f.md"
done

echo ""
echo "── 模板文件 (6) ──"
for f in acceptance-report user-experience-log iteration-backlog calibration-report test-scripts-output; do
  check "templates/$f.md exists" "test -f templates/$f.md"
done
check "templates/history.json exists" "test -f templates/history.json"

echo ""
echo "── 平台指南 (4) ──"
for f in README mini-program native-app game; do
  check "platforms/$f.md exists" "test -f platforms/$f.md"
done

echo ""
echo "── 脚本 ──"
check "scripts/start-chrome.sh exists" "test -f scripts/start-chrome.sh"
check "scripts/start-chrome.sh is executable" "test -x scripts/start-chrome.sh"

echo ""
echo "── 评分一致性 ──"
# All guardians must have scoring scale
check "All guardians have 0-3 scoring scale" \
  "test $(grep -l '0.*缺失\|1.*存在但有问题\|2.*合格\|3.*超出预期' guardians/*.md | wc -l) -eq 6"
# All guardians must have blind testing
check "All guardians mandate blind testing" \
  "test $(grep -l '无文件访问' guardians/*.md | wc -l) -eq 6"
# All guardians must reference deep testing guide
check "All guardians reference deep-testing-guide" \
  "test $(grep -l 'deep-testing-guide' guardians/*.md | wc -l) -eq 6"

echo ""
echo "── 交叉引用 ──"
check "orchestrator references all simulators" \
  "test $(grep -c 'simulators/' orchestrator.md) -ge 8"
check "persona-generator references persona-system" \
  "grep -q 'persona-system.md' simulators/persona-generator.md"
check "browser-user references Chrome MCP" \
  "grep -q 'mcp__plugin_superpowers-chrome_chrome__use_browser' simulators/browser-user.md"

echo ""
echo "── CI/CD ──"
check ".github/workflows/quality-check.yml exists" "test -f .github/workflows/quality-check.yml"

echo ""
echo "── Marketing ──"
check "Marketing materials present" "test -d marketing && test $(ls marketing/*.md 2>/dev/null | wc -l) -ge 5"

echo ""
echo "═══════════════════════════════════"
echo "  Results: $PASS passed, $FAIL failed"
echo "═══════════════════════════════════"

if [ $FAIL -gt 0 ]; then
  echo ""
  echo "Failed checks:$ERRORS"
  exit 1
else
  echo ""
  echo "✅ All checks passed. Framework is internally consistent."
  exit 0
fi
