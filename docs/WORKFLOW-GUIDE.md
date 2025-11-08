# Multi-Agent CLI Workflow Guide

**For academic LaTeX papers with Claude Code, Kimi CLI, and Gemini**

## Coming from Overleaf: Key Differences

### What Changes

**Before (Overleaf + Web Chat):**
- Edit LaTeX in browser
- Copy-paste to ChatGPT/Claude/Gemini web interfaces
- Manual file management
- Limited to one conversation at a time
- No version control integration

**Now (CLI + Multi-Agent):**
- Edit locally in your preferred editor (VS Code, etc.)
- AI agents work directly with your files
- Automated builds, git commits, style enforcement
- Run multiple agents in parallel
- Full git history and branching

### What Stays the Same

- Still writing LaTeX
- Still collaborating with AI
- Still building PDFs
- Still managing references

## Choosing Which AI Agent to Use

### Claude Code (claude.ai/code)
**Best for:**
- Initial project setup and scaffolding
- Complex refactoring across multiple files
- Implementing new sections with careful architecture
- Code review and quality checks
- Understanding existing codebase structure

**Strengths:**
- Excellent at reading entire codebases
- Strong planning and architecture
- Good at following complex instructions
- Built-in tools for file operations

**When to use:**
- "Set up a new section on X with proper structure"
- "Refactor these three sections to improve flow"
- "Review this section and suggest improvements"

### Kimi CLI / Codex
**Best for:**
- Quick edits and iterations
- Writing new content based on specific prompts
- Fixing specific issues or bugs
- BibTeX management
- Fast turnaround tasks

**Strengths:**
- Very fast responses
- Good at focused tasks
- Excellent for iterative writing
- Strong with citations and references

**When to use:**
- "Add a paragraph explaining X"
- "Fix this awkward sentence"
- "Add these three citations to the bibliography"
- "Polish this section for clarity"

### Gemini
**Best for:**
- Research and fact-checking
- Generating examples and illustrations
- Brainstorming ideas and approaches
- Literature review support
- Multi-modal tasks (if using images/diagrams)

**Strengths:**
- Strong research capabilities
- Good at generating varied examples
- Can work with images and diagrams
- Creative brainstorming

**When to use:**
- "Find examples of X in the literature"
- "Help me brainstorm approaches to Y"
- "Check if this claim is accurate"
- "Generate test cases for this analysis"

## Recommended Workflows

### Starting a New Paper

```bash
# 1. Create from template (once house style is set up)
cd ~/Documents/LLM-CLI\ projects/
.house-style/templates/agents/create-paper.sh "Paper Title"

# 2. Enter directory
cd Paper_Title/

# 3. Use Claude Code for initial structure
claude
# Ask: "Help me plan the structure for a paper on X"
# Then: "Set up skeleton sections with TODOs"

# 4. First commit
git add .
git commit -m "Initial paper structure"
```

### Daily Writing Session

**Pattern: Brainstorm → Draft → Refine → Review**

```bash
# Morning: Brainstorm with Gemini
gemini
# "I want to write about X. Help me explore approaches."

# Draft with Kimi (fast iteration)
kimi
# "Write a first draft of the methodology section"

# Refine with Claude Code
claude
# "Review and improve this section for clarity and flow"

# Commit frequently
git add main.tex
git commit -m "Draft methodology section"
```

### Handling Revisions

**Use branches for major revisions:**

```bash
# Create revision branch
git checkout -b revision/reviewer-comments

# Work through comments with appropriate AI
kimi    # For quick fixes
claude  # For structural changes
gemini  # For new examples/research

# Commit incrementally
git commit -m "Address reviewer comment #1"

# When done
git checkout main
git merge revision/reviewer-comments
```

## Git Workflow for Academic Papers

### Branch Strategy

**Main branch:** Always submission-ready
- Only merge when section/revision is complete
- Keep clean commit history

**Feature branches:** For new sections
```bash
git checkout -b section/background
# Write section...
git commit -m "Add background section"
git checkout main
git merge section/background
```

**Revision branches:** For reviewer feedback
```bash
git checkout -b revision/round-1
# Address comments...
git commit -m "Address reviewer comments"
```

**Experiment branches:** For trying ideas
```bash
git checkout -b experiment/alternative-framework
# Try different approach...
# If good: merge. If bad: delete branch
```

### Commit Frequency

**Commit often, but meaningfully:**

✅ **Good commits:**
- After completing a paragraph
- After fixing a specific issue
- Before and after major changes
- At end of writing session

❌ **Avoid:**
- Committing broken LaTeX (won't compile)
- Huge commits with unrelated changes
- Committing without testing build

### Commit Message Patterns

```bash
# Structural changes
git commit -m "Add theoretical framework section"
git commit -m "Reorganize results section"

# Content additions
git commit -m "Expand discussion of X with examples"
git commit -m "Add subsection on methodology"

# Revisions
git commit -m "Revise introduction for clarity"
git commit -m "Address reviewer comment #3"

# Fixes
git commit -m "Fix citation formatting"
git commit -m "Correct typo in Table 2"

# Infrastructure
git commit -m "Update preamble with new macro"
git commit -m "Add figure files for Section 4"
```

## Working with Pre-commit Hooks

### AI Doc Sync Hook

Already set up! Keeps CLAUDE.md, AGENTS.md, GEMINI.md in sync.

**What happens:**
```bash
# Edit GEMINI.md while working with Gemini
git add .
git commit -m "Update analysis"

# Hook automatically:
# - Detects GEMINI.md changed
# - Copies to CLAUDE.md and AGENTS.md
# - Stages all three files
# - Commits them together
```

### Style Enforcement Hook (Future)

Once house style system is implemented:

**Warning mode (default):**
```bash
git commit -m "Add new section"

# Output:
# [STYLE] Found 2 potential violations:
# - Line 42: Use \term{} instead of quotes
# - Line 89: Paragraph heading detected
# Commit allowed. Review warnings.
```

**How to handle:**
- Review warnings
- Fix if they're real issues
- Ignore if false positives
- Override if needed: `git commit --no-verify`

## Multi-Agent Collaboration Patterns

### Pattern 1: Parallel Development

Use different agents for different sections simultaneously:

```bash
# Terminal 1: Claude working on theory section
claude
# "Develop the theoretical framework section"

# Terminal 2: Kimi working on literature review
kimi
# "Add relevant citations to background"

# Terminal 3: Gemini researching examples
gemini
# "Find cross-linguistic examples of X"
```

Then integrate their outputs with commits.

### Pattern 2: Sequential Refinement

Pass work through multiple agents:

```bash
# Step 1: Gemini generates ideas
gemini
# "Brainstorm arguments for X"

# Step 2: Kimi drafts
kimi
# "Write first draft based on these ideas"

# Step 3: Claude refines
claude
# "Review and improve structure and clarity"
```

### Pattern 3: Specialist Tasks

Use each agent for what they're best at:

```bash
# Gemini: Research and examples
gemini
# "Find empirical studies supporting X"

# Kimi: Fast content generation
kimi
# "Write transition paragraphs between sections"

# Claude: Architecture and review
claude
# "Review overall structure and identify gaps"
```

## File Management

### Project Organization

```
Paper_Project/
├── main.tex              # Main document (edit this)
├── sections/             # Optional: split into files
│   ├── intro.tex
│   ├── background.tex
│   └── methods.tex
├── figures/              # Store figure sources
│   ├── diagram.pdf
│   └── graph.R           # Scripts that generate figures
├── references.bib        # Bibliography
├── docs/
│   ├── plans/           # Design documents
│   └── notes/           # Research notes
└── build/               # Optional: build outputs
```

### When to Split Files

**Keep in main.tex when:**
- Paper is < 30 pages
- Working alone
- Early draft stage

**Split into sections/ when:**
- Paper is > 30 pages
- Collaborating with others
- Multiple agents working on different sections
- Want to track section changes separately

**How to split:**
```latex
% main.tex
\documentclass{article}
% ... preamble ...
\begin{document}

\input{sections/intro.tex}
\input{sections/background.tex}
\input{sections/methods.tex}

\printbibliography
\end{document}
```

## Build and Test Workflow

### Quick Build Loop

```bash
# Make changes
vim main.tex

# Quick build
make quick

# Check for errors
# If errors: fix and repeat
# If good: full build

make
```

### Full Build Before Commit

```bash
# Clean build
make clean
make

# Check PDF
make view  # or: open main.pdf

# If good, commit
git add .
git commit -m "Complete section X"
```

## Dealing with AI Mistakes

### When AIs Hallucinate Citations

**Problem:** AI adds fake references

**Solution:**
```bash
# After AI suggests citations, check references.bib
cat references.bib | grep "Fake2024"

# If missing, ask AI:
# "Find the actual reference for this claim"
# or add manually
```

### When AIs Break LaTeX

**Problem:** AI generates invalid LaTeX

**Solution:**
```bash
# Build immediately after AI changes
make

# If build fails, read error
# Ask AI: "Fix this LaTeX error: [paste error]"
# or use: git diff to see what changed
# or use: git checkout main.tex to revert
```

### When AIs Lose Context

**Problem:** AI forgets what it was doing

**Solution:**
- Commit before switching tasks
- Use git commit messages as breadcrumbs
- Reference specific files/sections: "Look at main.tex:142-156"
- Show git diff: "Here's what changed: [paste diff]"

## Managing Multiple Papers

### Active vs. Frozen

**Active papers:**
- In current work directory
- Can update house style
- Frequent commits

**Papers under review:**
- Create tag: `git tag -a v1.0-submission`
- Work on revision branch if needed
- Don't update house style (frozen)

**Published papers:**
- Create tag: `git tag -a v1.0-published`
- Archive or move to published/ directory
- Truly frozen unless errata needed

### Switching Between Papers

```bash
# Save current work
git add .
git commit -m "WIP: section X"

# Switch projects
cd ../Other_Paper/

# Resume
git log -1  # See where you left off
```

## Tips for Smooth Workflow

### 1. Commit Before Asking AI for Big Changes

```bash
git add main.tex
git commit -m "Before restructuring section 3"

# Now ask AI to restructure
# If it goes wrong: git checkout main.tex
```

### 2. Use Branches for Experiments

```bash
git checkout -b experiment/alternative-intro

# Try new approach with AI
# If good: merge
# If bad: git checkout main && git branch -d experiment/alternative-intro
```

### 3. Build Often

```bash
# After any significant change
make quick

# Catch errors early!
```

### 4. Keep AI Docs Updated

When you discover new conventions or patterns:

```bash
# Edit CLAUDE.md (or any of the three)
# Add new convention
git add CLAUDE.md
git commit -m "Document X convention"

# Pre-commit hook syncs to others automatically
```

### 5. Use TODO Comments

```latex
% TODO: Add empirical example here
% TODO: Verify this citation
% FIXME: Awkward phrasing
% NOTE: Come back to this argument
```

Then search: `grep -n "TODO" main.tex`

## Troubleshooting

### "Pre-commit hook is slow"

```bash
# Skip hook temporarily
git commit --no-verify -m "Quick fix"

# But remember to run manually later
.git/hooks/pre-commit
```

### "AI docs are out of sync"

```bash
# Run hook manually
.git/hooks/pre-commit

# Or copy manually
cp CLAUDE.md AGENTS.md
cp CLAUDE.md GEMINI.md
```

### "Can't compile after AI change"

```bash
# See what changed
git diff main.tex

# Revert if needed
git checkout main.tex

# Or revert specific lines
git checkout main.tex -- main.tex
```

### "Lost track of what changed"

```bash
# See recent commits
git log --oneline -10

# See what's uncommitted
git status
git diff

# See specific commit
git show abc123
```

## Quick Reference Commands

```bash
# Project creation (once house style exists)
.house-style/templates/agents/create-paper.sh "Paper Name"

# Build
make              # Full build
make quick        # Fast build
make clean        # Clean artifacts
make view         # Open PDF

# Git workflow
git status                    # What's changed?
git diff                      # Show changes
git add .                     # Stage all
git commit -m "message"       # Commit
git log --oneline -5         # Recent commits

# Branches
git checkout -b branch-name   # Create branch
git checkout main             # Back to main
git merge branch-name         # Merge branch

# AI assistants
claude        # Claude Code
kimi          # Kimi CLI
gemini        # Gemini

# Recovery
git checkout main.tex         # Revert file
git reset --soft HEAD~1       # Undo last commit (keep changes)
git reset --hard HEAD~1       # Undo last commit (lose changes)
```

## Next Steps

1. **Set up house style system** (see design doc)
2. **Practice with current paper** - commit often, try different agents
3. **Start next paper from template** - experience the full workflow
4. **Refine style rules** - update based on what you learn
5. **Build muscle memory** - the CLI workflow gets faster with practice

Remember: The goal is to make the AI agents work for you efficiently while maintaining quality and version control. Start simple, add complexity as needed.
