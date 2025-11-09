#!/bin/bash
# Orchestration workflow for formalism fixes
# This script coordinates between conceptual agents (Kimi/Codex) and Claude for implementation

set -e

WORK_DIR="/Users/brettreynolds/Documents/LLM-CLI projects/Functions_as_Comparanda__Categories_as_Kinds__A_Homeostatic_Approach_to_Typology"
REVIEWS_DIR="$WORK_DIR/reviews"
HANDOFF_FILE="$REVIEWS_DIR/handoff-to-conceptual-agents.md"

cd "$WORK_DIR"

echo "=== Formalism Fix Orchestration ==="
echo "Working directory: $WORK_DIR"
echo ""

# Phase 1: Run conceptual agents
echo "Phase 1: Generating conceptual proposals..."
echo ""

# Option to run Kimi
if [[ "$1" == "kimi" ]] || [[ "$1" == "both" ]]; then
    echo "→ Running Kimi agent..."
    KIMI_PROMPT=$(cat "$HANDOFF_FILE")
    KIMI_PROMPT="$KIMI_PROMPT

Please save your complete proposal following the template in the handoff document. Format your response as a complete markdown document that can be saved as 'formalism-fix-proposal-kimi.md'."

    kimi --print -w "$WORK_DIR" -c "$KIMI_PROMPT" > "$REVIEWS_DIR/formalism-fix-proposal-kimi.md"
    echo "✓ Kimi proposal saved to: reviews/formalism-fix-proposal-kimi.md"
    echo ""
fi

# Option to run Codex (ChatGPT)
if [[ "$1" == "codex" ]] || [[ "$1" == "both" ]]; then
    echo "→ Running Codex agent..."
    CODEX_PROMPT=$(cat "$HANDOFF_FILE")
    CODEX_PROMPT="$CODEX_PROMPT

Please save your complete proposal following the template in the handoff document. Format your response as a complete markdown document that can be saved as 'formalism-fix-proposal-codex.md'."

    cd "$WORK_DIR" && codex exec "$CODEX_PROMPT" > "$REVIEWS_DIR/formalism-fix-proposal-codex.md"
    echo "✓ Codex proposal saved to: reviews/formalism-fix-proposal-codex.md"
    echo ""
fi

echo "=== Phase 1 Complete ==="
echo ""
echo "Proposals generated. Next steps:"
echo "1. Review the proposals in reviews/"
echo "2. Select which proposal to implement (or merge elements)"
echo "3. Return to Claude with: 'Implement proposal from [filename]'"
echo ""
