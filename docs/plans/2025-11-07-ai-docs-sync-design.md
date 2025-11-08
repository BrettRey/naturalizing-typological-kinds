# AI Documentation Sync System Design

**Date:** 2025-11-07
**Purpose:** Keep CLAUDE.md, AGENTS.md, and GEMINI.md synchronized automatically

## Problem

The project uses three different AI assistants (Claude Code, Kimi/Codex, and Gemini), each with their own documentation file (CLAUDE.md, AGENTS.md, GEMINI.md respectively). These files serve the same purpose - providing codebase guidance to AI assistants - but can drift out of sync when edited independently.

## Solution Overview

Implement a pre-commit git hook that automatically synchronizes the three documentation files by copying the most recently modified file to the others before each commit.

## Architecture

### Components

1. **Local git repository** - Version control for the LaTeX research paper
2. **Pre-commit hook** - Bash script at `.git/hooks/pre-commit`
3. **Three documentation files** - CLAUDE.md, AGENTS.md, GEMINI.md

### Workflow

1. User edits any of the three .md files while working with their preferred AI
2. User stages changes and initiates commit: `git commit -m "message"`
3. Pre-commit hook executes automatically:
   - Detects if any of the three files are staged
   - Compares modification timestamps
   - Copies newest file content to the other two
   - Auto-stages the synchronized files
   - Prints notification of what was synced
4. Commit proceeds with all three files in sync

### Example

```bash
# User edits GEMINI.md while working with Gemini
# Later commits:
git add .
git commit -m "Updated theoretical framework section"

# Hook output:
# [SYNC] GEMINI.md is newest (modified 5 minutes ago)
# [SYNC] Copied to AGENTS.md and CLAUDE.md
# [SYNC] Files synchronized and staged
```

## Pre-commit Hook Implementation

### Script Structure

```bash
#!/bin/bash
# .git/hooks/pre-commit

# 1. File detection - check if any docs are staged
# 2. Modification time comparison - find newest file
# 3. Content synchronization - copy to others
# 4. Auto-staging - add updated files to commit
```

### Core Logic

1. **Detection**: Check if any of the three files are in staged changes
2. **Comparison**: Use `stat -f %m` (macOS) to get modification timestamps
3. **Sync**: Use `cp` to copy newest file to the others
4. **Stage**: Use `git add` to include synchronized files in commit

### Error Handling

- Skip if none of the three files are staged (unrelated commits)
- Skip if files don't exist yet (initial setup)
- Skip if all three already have identical content
- Always exit with status 0 (never block commits)

## Initial Setup

### Steps

1. Initialize git repository: `git init`
2. Create `.gitignore` for LaTeX build artifacts
3. Create and install pre-commit hook script
4. Make hook executable: `chmod +x .git/hooks/pre-commit`
5. Sync all three files to CLAUDE.md (most comprehensive)
6. Make initial commit

### .gitignore Contents

Exclude LaTeX temporary files:
```
*.aux
*.bbl
*.bcf
*.blg
*.log
*.out
*.run.xml
*.toc
*.fdb_latexmk
*.fls
*.synctex.gz
```

## Edge Cases

### Handled Scenarios

1. **Multiple files edited** - Most recently modified timestamp wins
2. **Files already identical** - Skip with notification message
3. **Only one file exists** - Copy to create missing files
4. **No files staged** - Skip hook entirely (fast path)

### Platform Compatibility

- Uses macOS-compatible `stat -f %m` for modification times
- Pure bash, no external dependencies
- Tested on macOS (Darwin 25.0.0)

## Benefits

- **Zero friction** - Works transparently through normal git workflow
- **AI-agnostic** - Edit whichever file you want with any assistant
- **Transparent** - Always shows what got synced
- **Safe** - Never blocks commits, only enhances them
- **Local** - No remote dependencies or services

## Future Enhancements (Optional)

1. **Manual sync script** - `scripts/sync-docs.sh` for syncing without committing
2. **Content validation** - Verify synced content makes semantic sense
3. **Sync logging** - Record sync history for debugging
4. **Hook template** - Store hook in `scripts/pre-commit` for backup/sharing

## Maintenance

- **Disable temporarily**: `mv .git/hooks/pre-commit .git/hooks/pre-commit.disabled`
- **Update hook**: Edit `.git/hooks/pre-commit` directly
- **Remove**: Delete `.git/hooks/pre-commit`

## Testing Plan

1. Edit AGENTS.md with test content
2. Stage and commit changes
3. Verify CLAUDE.md and GEMINI.md updated automatically
4. Check git log shows all three files in commit
5. Verify notification message appeared

## Success Criteria

- All three documentation files stay synchronized across commits
- No manual intervention required during normal workflow
- Clear visibility into what gets synced
- Works reliably across different editing patterns
