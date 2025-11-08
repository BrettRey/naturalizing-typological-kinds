# Single-Session Orchestration Workflow

**Goal:** Work with ONE LLM session at a time, let it orchestrate others as needed.

**Problem:** Managing 4 terminal windows (Claude, Kimi, Gemini, Codex) is hectic and it's hard to track what each is doing.

**Solution:** Use one primary session that coordinates work via filesystem + strategic model switching.

---

## Core Principle: Rotating Primary

Since Claude has token limits, the "primary" orchestrator **rotates throughout the day** based on availability and task type.

```
Morning:     Claude is primary (tokens fresh)
Midday:      Kimi is primary (Claude limit hit)
Evening:     Claude is primary (tokens refreshed)
```

The **filesystem** maintains state between rotations - no context is lost.

---

## Decision Tree: Which Model is Primary Right Now?

### Start Here Every Session

Ask yourself:

**1. Do I have Claude tokens available?**
   - YES → Go to Question 2
   - NO → **Kimi is primary** (skip to Kimi Primary Workflow)

**2. What type of work am I doing?**
   - Strategic planning, architecture, review → **Claude is primary**
   - Bulk iteration, many revisions → **Kimi is primary**
   - Deep analysis of large codebase → **Gemini is primary**

**3. How long will this session be?**
   - Short (<20 messages) → **Claude is primary**
   - Long (40+ messages) → **Kimi is primary** (save Claude tokens)

---

## Claude as Primary (Strategic Sessions)

**When:** Morning, evening, or whenever you have tokens and need high-quality reasoning

**Session Pattern:**

```bash
# Open ONE terminal
claude

# Claude reads project state
> "Read AGENTS.md and TODO.md - what should I focus on today?"

# Claude analyzes and plans
> [Claude reads files, analyzes, suggests priorities]

# Claude writes plan to filesystem
> "Write today's plan to docs/plans/2025-11-07-session-plan.md"

# Claude orchestrates when needed
> "I need bulk examples for Section 3. Write a task for Kimi in TODO.md:"
>   - [ ] Add 15 cross-linguistic examples to Section 3.2 (@kimi)
>   - [ ] Format with langsci-gb4e syntax (@kimi)
>   - [ ] Add to draft-section-3.2.md (@kimi)

# Claude does high-value work itself
> "Review Section 4 for coherence and suggest structural improvements"

# When token limit approaches
> "Write handoff notes to HANDOFF-TO-KIMI.md with context for continuing"

# Close session
exit
```

**What Claude Writes to Filesystem:**

```
docs/plans/2025-11-07-session-plan.md    # Today's priorities
TODO.md                                   # Tasks for other models
HANDOFF-TO-KIMI.md                       # Context for next session
REVIEW-NOTES.md                          # Feedback on drafts
```

---

## Kimi as Primary (Execution Sessions)

**When:** Midday bulk work, when Claude tokens are exhausted, or for high-volume iteration

**Session Pattern:**

```bash
# Open ONE terminal
kimi

# Kimi reads handoff from Claude
> "Read HANDOFF-TO-KIMI.md and TODO.md - show me my tasks"

# Kimi executes bulk work
> "Complete all @kimi tasks in TODO.md"
> [Kimi adds examples, formats, iterates]

# Kimi can spawn other models via Task tool
> "I need Claude-quality review of this draft"
> [Uses Task tool to spawn Claude subagent]
> [Gets review, integrates feedback]

# Kimi writes progress back
> "Update TODO.md with completed tasks, write status to STATUS.md"

# If you need to switch
> "Write handoff notes to HANDOFF-TO-CLAUDE.md"

# Close session
exit
```

**What Kimi Writes:**

```
STATUS.md                    # What's done, what's pending
TODO.md                      # Updated task list
draft-*.md                   # Draft sections for review
HANDOFF-TO-CLAUDE.md        # Context for next Claude session
```

---

## Gemini as Primary (Analysis Sessions)

**When:** You need to analyze entire codebase, large document sets, or multimodal content

**Session Pattern:**

```bash
# Open ONE terminal
gemini

# Gemini reads previous context
> "Read AGENTS.md and latest HANDOFF notes - what analysis is needed?"

# Gemini does large-scale analysis
> "Analyze all 50 papers in references.bib and find patterns"
> "Read entire LaTeX source and identify inconsistencies"

# Gemini writes structured output
> "Write findings to analysis/2025-11-07-pattern-analysis.md"
> "Create tasks for Claude and Kimi in TODO.md based on findings"

# Close session
exit
```

**What Gemini Writes:**

```
analysis/*.md               # Analysis reports
TODO.md                     # Tasks based on findings
HANDOFF-TO-CLAUDE.md       # Suggestions for next steps
```

---

## The Filesystem Coordination Layer

All models read and write these files - this IS the orchestration mechanism:

### Core Coordination Files

```
AGENTS.md                    # Project state (all models read this first)
TODO.md                      # Task queue with @model assignments
STATUS.md                    # Current state (updated by whoever is primary)
```

### Handoff Files (for session transitions)

```
HANDOFF-TO-CLAUDE.md        # Context for next Claude session
HANDOFF-TO-KIMI.md          # Context for next Kimi session
HANDOFF-TO-GEMINI.md        # Context for next Gemini session
```

### Work Product Files

```
docs/plans/*.md              # Plans and designs
analysis/*.md                # Analysis reports
draft-*.md                   # Draft sections
REVIEW-NOTES.md             # Review feedback
PROCEDURAL-ERROR-LOG.md     # Mistakes to avoid
```

### Format for TODO.md

```markdown
# TODO List

## High Priority
- [ ] Review Section 3 for coherence (@claude)
- [ ] Add 15 examples to Section 3.2 (@kimi)
- [ ] Analyze citation patterns across sections (@gemini)

## In Progress
- [x] Draft Section 4.1 (@claude) - COMPLETED 2025-11-07

## Blocked
- [ ] Revise introduction (waiting for reviewer feedback)

## Notes
- Claude token limit hit at 14:30, switched to Kimi
- Kimi completed bulk examples, ready for Claude review
```

---

## Example Full-Day Workflow

### Morning (08:00 - 10:00): Claude Primary

```bash
claude

# Strategic planning
> "Read AGENTS.md, review yesterday's work, what are today's priorities?"
> "Write plan to docs/plans/2025-11-07-session-plan.md"

# High-value work
> "Review Section 3 and write feedback to REVIEW-NOTES.md"
> "Design structure for Section 4, write outline to draft-section-4-outline.md"

# Delegate bulk work
> "Add tasks to TODO.md for Kimi to execute"
>   - [ ] Add 20 examples to Section 3 (@kimi)
>   - [ ] Format all references consistently (@kimi)

# Before token limit
> "Write HANDOFF-TO-KIMI.md with context"

exit
```

**Filesystem after Claude session:**
- ✓ docs/plans/2025-11-07-session-plan.md (today's plan)
- ✓ REVIEW-NOTES.md (feedback on Section 3)
- ✓ draft-section-4-outline.md (structure for Section 4)
- ✓ TODO.md (updated with @kimi tasks)
- ✓ HANDOFF-TO-KIMI.md (context for next session)

### Midday (10:30 - 15:00): Kimi Primary

```bash
kimi

# Read handoff
> "Read HANDOFF-TO-KIMI.md and TODO.md"

# Execute bulk work
> "Complete all @kimi tasks"
> [Adds 20 examples, formats references]

# Spawn Claude for quality check
> "Use Task tool to spawn Claude: Review draft-section-3-with-examples.md"
> [Claude subagent provides feedback]
> "Integrate feedback"

# Update status
> "Update TODO.md, write status to STATUS.md"
> "Write HANDOFF-TO-CLAUDE.md for evening review"

# Git operations
> "Commit today's work with descriptive message"

exit
```

**Filesystem after Kimi session:**
- ✓ draft-section-3-with-examples.md (bulk work complete)
- ✓ TODO.md (tasks marked complete)
- ✓ STATUS.md (current state)
- ✓ HANDOFF-TO-CLAUDE.md (ready for evening review)
- ✓ Git commit made

### Evening (18:00 - 19:00): Claude Primary (Tokens Refreshed)

```bash
claude

# Read handoff
> "Read HANDOFF-TO-CLAUDE.md and STATUS.md"

# Review day's work
> "Review draft-section-3-with-examples.md and provide final polish"
> "Check overall coherence between Sections 3 and 4"

# Final decisions
> "Approve changes and write final notes to STATUS.md"

# Plan tomorrow
> "Write tomorrow's priorities to TODO.md"

exit
```

---

## Handling Token Limits Mid-Session

### If Claude Hits Limit Mid-Task

```bash
# Claude detects limit approaching
> "I'm approaching my token limit. Writing current context to HANDOFF-TO-KIMI.md"

# Claude writes detailed handoff
HANDOFF-TO-KIMI.md:
  - Current task: Revising Section 3.2
  - What's done: Paragraphs 1-3 revised
  - What's next: Paragraphs 4-6 need same treatment
  - Key points to preserve: [specific details]
  - Style to match: [examples]

exit

# Switch to Kimi
kimi
> "Read HANDOFF-TO-KIMI.md and continue the task"
```

**No context loss** - filesystem preserves everything.

---

## Spawning Subagents (When Primary Model Needs Help)

Any model can spawn others via the Task tool when they need specialized capabilities:

### Kimi Spawning Claude for Quality

```bash
kimi

# Kimi recognizes need for Claude's quality
> "I've drafted Section 3. I need Claude to review for style and coherence."
> "Use Task tool: spawn Claude subagent to review draft-section-3.md"

# Wait for Claude's review
> [Claude subagent reads, provides feedback, writes to REVIEW-NOTES.md]

# Kimi integrates
> "Read REVIEW-NOTES.md and revise draft based on feedback"
```

### Claude Spawning Gemini for Analysis

```bash
claude

# Claude recognizes need for deep analysis
> "I need to understand patterns across all 50 references"
> "Use Task tool: spawn Gemini to analyze references.bib"

# Wait for analysis
> [Gemini analyzes, writes to analysis/citation-patterns.md]

# Claude uses results
> "Read analysis/citation-patterns.md and incorporate findings into Section 2"
```

**Key Point:** Subagent spawning happens **within the primary session** - you still only have ONE window open.

---

## Benefits of This Approach

**Single Window:**
- Only one terminal open at a time
- Clear which model is "in charge"
- No mental overhead tracking 4 sessions

**No Context Loss:**
- Filesystem preserves all state
- Handoff files make transitions seamless
- Any model can pick up where another left off

**Token Efficient:**
- Use Claude strategically when tokens available
- Kimi handles bulk work
- Gemini does large-scale analysis

**Transparent:**
- All coordination visible in files
- Easy to see what's done, what's pending
- Clear audit trail

**Flexible:**
- Switch primary model anytime
- Spawn subagents when needed
- Adapt to token availability

---

## Quick Reference: Which Model When?

| Situation | Primary Model | Why |
|-----------|--------------|-----|
| Morning planning | Claude | Fresh tokens, need strategy |
| Bulk drafting (20+ iterations) | Kimi | Generous limits, fast |
| Claude tokens exhausted | Kimi | No choice, but can spawn Claude |
| Large codebase analysis | Gemini | 1M token context window |
| Evening review | Claude | Tokens refreshed, need quality |
| Git operations | Kimi | Strong tool use, file ops |
| Quick fixes | Kimi | Fast, efficient |
| Complex reasoning | Claude | Best quality reasoning |
| Research synthesis | Gemini | Multimodal, large context |

---

## Implementation Checklist

- [ ] Create core coordination files:
  - [ ] AGENTS.md (project state)
  - [ ] TODO.md (task queue)
  - [ ] STATUS.md (current state)

- [ ] Create handoff templates:
  - [ ] HANDOFF-TO-CLAUDE.md
  - [ ] HANDOFF-TO-KIMI.md
  - [ ] HANDOFF-TO-GEMINI.md

- [ ] Add to AGENTS.md:
  ```markdown
  ## Current Primary Model
  Claude (as of 08:00, tokens available)

  ## Session Status
  - Last session: Claude, 08:00-10:00
  - Current session: Kimi, 10:30-ongoing
  - Next handoff: To Claude when tokens refresh (17:00)
  ```

- [ ] Update TODO.md format with @model tags

- [ ] Test workflow:
  - [ ] Claude session → writes handoff → Kimi session
  - [ ] Kimi spawns Claude subagent
  - [ ] Check filesystem preserves all context

---

## Anti-Patterns to Avoid

**❌ Don't:** Run multiple LLM terminals simultaneously
**✓ Do:** One primary, spawn subagents only when needed

**❌ Don't:** Try to bypass Claude token limits via Kimi spawning
**✓ Do:** Accept limits, use strategic scheduling

**❌ Don't:** Keep context only in chat history
**✓ Do:** Write everything important to filesystem

**❌ Don't:** Let one model dominate (e.g., only use Claude)
**✓ Do:** Rotate primary based on tokens and task type

**❌ Don't:** Make ad-hoc decisions about which model to use
**✓ Do:** Follow the decision tree at start of each session

---

## Troubleshooting

**Problem:** "I forgot which model was last primary"
→ Check AGENTS.md ## Current Primary Model section

**Problem:** "Context was lost between sessions"
→ Did previous session write HANDOFF-TO-*.md? If not, read STATUS.md and TODO.md

**Problem:** "Claude limit hit unexpectedly"
→ Add to session checklist: check token usage every 10-15 messages

**Problem:** "Kimi and Claude gave conflicting advice"
→ You decide. Write decision to AGENTS.md ## Decisions section

**Problem:** "Too many handoff files piling up"
→ Archive old ones: `mkdir archive && mv HANDOFF-* archive/`

---

## Next Steps

1. **Today:** Test this workflow
   - Start Claude session
   - Write handoff
   - Switch to Kimi
   - Verify context preserved

2. **This Week:** Refine based on experience
   - Which transitions are smooth?
   - Where does context get lost?
   - Update this document

3. **Ongoing:** Maintain coordination files
   - Keep AGENTS.md current
   - Update TODO.md daily
   - Archive completed handoffs

**Remember:** The filesystem is your orchestration layer. Trust it.
