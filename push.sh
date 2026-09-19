# 一键把本地仓库推到 GitHub（需要先登录 gh，或用 PAT）
# 在 Windows git-bash 里跑：bash push.sh
set -euo pipefail

REPO_NAME="${REPO_NAME:-yushou-api-examples}"

cd "$(dirname "$0")"

if ! command -v gh >/dev/null 2>&1; then
  echo "[!] 没装 gh CLI。二选一："
  echo "    1) winget install --id GitHub.cli   然后：gh auth login"
  echo "    2) 手动在网页建好空仓库 $REPO_NAME，再执行下面三行："
  echo "       git init -b main && git add -A && git commit -m 'init: API examples'"
  echo "       git remote add origin git@github.com:<你的用户名>/$REPO_NAME.git"
  echo "       git push -u origin main"
  exit 1
fi

git init -b main 2>/dev/null || true
git add -A
git commit -m "init: OpenAI-compatible API examples (python / node / curl)" || true
gh repo create "$REPO_NAME" --public --source=. --push --description "Minimal examples for calling multiple LLMs through one OpenAI-compatible endpoint"
echo "[OK] 仓库已创建并推送：$(gh repo view "$REPO_NAME" --json url -q .url)"
