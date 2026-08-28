#!/usr/bin/env bash
# agent-skills installer
#
# Copies every <category>/SKILL.md in ./skills into the skill directories of
# whichever agents are installed on this machine. Skips unknown/absent agents
# and prints a summary at the end.
#
# Usage:
#   ./install.sh                 # auto-detect every installed agent
#   ./install.sh --agent codex   # install into ONE agent only
#   ./install.sh --dry-run       # show what WOULD be installed, do nothing
#
# Per-agent detection + target directory (global scope):
#   opencode        ~/.config/opencode/skills
#   claude-code     ~/.claude/skills
#   gemini          ~/.gemini/skills
#   copilot         ~/.config/github-copilot/skills
#   codex           ~/.codex/skills
#   cursor          ~/.cursor/skills

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"
DRY_RUN=0
ONLY_AGENT=""

declare -A AGENT_BIN=( ["opencode"]="opencode" ["claude-code"]="claude" ["gemini"]="gemini" ["copilot"]="copilot" ["codex"]="codex" ["cursor"]="cursor" )
declare -A AGENT_DIR=( ["opencode"]="$HOME/.config/opencode/skills" ["claude-code"]="$HOME/.claude/skills" ["gemini"]="$HOME/.gemini/skills" ["copilot"]="$HOME/.config/github-copilot/skills" ["codex"]="$HOME/.codex/skills" ["cursor"]="$HOME/.cursor/skills" )

usage() {
  sed -n '2,14p' "${BASH_SOURCE[0]}"
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent)
      ONLY_AGENT="$2"; shift 2 ;;
    --dry-run)
      DRY_RUN=1; shift ;;
    -h|--help)
      usage ;;
    *)
      echo "error: unknown argument: $1" >&2; exit 1 ;;
  esac
done

if [[ ! -d "$SKILLS_DIR" ]]; then
  echo "error: no ./skills directory next to this script" >&2
  exit 1
fi

count_files() {
  find "$SKILLS_DIR" -mindepth 2 -maxdepth 2 -name SKILL.md | wc -l
}

is_installed() {
  local bin="${AGENT_BIN[$1]}"
  [[ -n "$bin" ]] && command -v "$bin" >/dev/null 2>&1
}

install_for_agent() {
  local agent="$1" dest="${AGENT_DIR[$1]}"
  if ! is_installed "$agent"; then
    echo "  - $agent: binary '${AGENT_BIN[$agent]}' not found, skipping"
    return 1
  fi
  if [[ -n "$ONLY_AGENT" ]]; then
    dest="${AGENT_DIR[$ONLY_AGENT]}"
  fi
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "  (dry-run) $agent -> $dest  ($(count_files) skills)"
    return 0
  fi
  mkdir -p "$dest"
  local installed=0
  for skill_dir in "$SKILLS_DIR"/*/; do
    local name; name="$(basename "$skill_dir")"
    if [[ -f "$skill_dir/SKILL.md" ]]; then
      mkdir -p "$dest/$name"
      cp "$skill_dir/SKILL.md" "$dest/$name/SKILL.md"
      installed=$((installed + 1))
    fi
  done
  echo "  - $agent -> $dest  ($installed skills installed)"
  return 0
}

echo "agent-skills installer"
echo "----------------------"
echo "skill library: $SKILLS_DIR"
echo ""

if [[ -n "$ONLY_AGENT" ]]; then
  if [[ -z "${AGENT_DIR[$ONLY_AGENT]:-}" ]]; then
    echo "error: unknown agent '$ONLY_AGENT' (known: ${!AGENT_DIR[@]})" >&2
    exit 1
  fi
  install_for_agent "$ONLY_AGENT"
else
  local_agents=("${!AGENT_BIN[@]}")
  matched=0
  for agent in "${local_agents[@]}"; do
    if install_for_agent "$agent"; then
      matched=$((matched + 1))
    fi
  done
  if [[ $matched -eq 0 ]]; then
    echo ""
    echo "no supported agents found (looked for: $(IFS=,; echo "${!AGENT_BIN[@]}"))."
    echo "install manually, e.g.:  cp -r skills/* ~/.claude/skills/"
    echo "or into the universal interop dir:  cp -r skills/* ~/.agents/skills/"
  fi
fi

echo ""
echo "done. Start a new session — skills activate when your request matches their description."