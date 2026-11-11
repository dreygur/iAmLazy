#!/usr/bin/env bash
# Push to deploy for a VPS. Creates a bare repo whose post-receive hook
# checks the pushed branch out into the project folder, then runs the
# deploy command (build, restart) with output streamed back to `git push`.
#
#   your machine                     server
#   git push production main  ──>  ~/myapp.git (bare)
#                                    └─ hooks/post-receive
#                                         ├─ checkout -f into work tree
#                                         └─ build + restart
#
# Run on the server as the deploy user:
#   bash setup_git_deploy.sh myapp /var/www/myapp "npm ci && npm run build && pm2 restart myapp"
#
# Then on your machine:
#   git remote add production deploy@server:/home/deploy/myapp.git
#   git push production main
#
# The checkout is forced: files edited by hand in the work tree get
# overwritten on the next push.

set -euo pipefail

readonly BRANCH="${BRANCH:-main}"
readonly REPOS_DIR="${REPOS_DIR:-$HOME}"
readonly DEPLOY_PLACEHOLDER="# build and restart commands go here"

usage() {
  echo "usage: $0 <name> <work-tree> [deploy-command]" >&2
  echo "env: BRANCH (default main), REPOS_DIR (default \$HOME)" >&2
  exit 1
}

write_hook() {
  local hook="$1" repo="$2" work_tree="$3" deploy_cmd="$4"

  cat > "$hook" <<EOF
#!/usr/bin/env bash
set -euo pipefail

readonly BRANCH="$BRANCH"
readonly WORK_TREE="$work_tree"
readonly REPO="$repo"

while read -r _ new ref; do
  if [[ "\$ref" != "refs/heads/\$BRANCH" ]]; then
    echo "[*] skipping \$ref, only \$BRANCH deploys"
    continue
  fi

  echo "[*] checking out \$BRANCH into \$WORK_TREE"
  git --work-tree="\$WORK_TREE" --git-dir="\$REPO" checkout -f "\$BRANCH"

  cd "\$WORK_TREE"
  ${deploy_cmd:-$DEPLOY_PLACEHOLDER}

  echo "[+] deployed \${new:0:7}"
done
EOF

  chmod +x "$hook"
}

main() {
  if [[ $# -lt 2 ]]; then
    usage
  fi

  local name="$1"
  local work_tree
  work_tree="$(mkdir -p "$2" && cd "$2" && pwd)"
  local deploy_cmd="${3:-}"
  local repo="$REPOS_DIR/$name.git"

  if [[ -e "$repo" ]]; then
    echo "[-] $repo already exists" >&2
    exit 1
  fi

  git init --quiet --bare "$repo"
  git --git-dir="$repo" symbolic-ref HEAD "refs/heads/$BRANCH"
  write_hook "$repo/hooks/post-receive" "$repo" "$work_tree" "$deploy_cmd"

  echo "[+] bare repo: $repo"
  echo "[+] work tree: $work_tree"
  echo "[*] on your machine:"
  echo "    git remote add production $(whoami)@<server>:$repo"
  echo "    git push production $BRANCH"
}

main "$@"
