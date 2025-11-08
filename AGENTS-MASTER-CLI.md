# Master CLI Orchestration Pattern

**Note**: This file should be moved to `/Users/brettreynolds/Documents/LLM-CLI projects/AGENTS.md` to serve as the master guide for all projects.

## Architecture

**Primary Interface**: Kimi CLI (this tool)
- **Role**: Main orchestrator, project manager, git operator
- **Strengths**: Tool use, file operations, subagent spawning, conversation history
- **When to use**: All initial interactions, project setup, git workflows, task coordination

**Specialized Subagents** (spawned by Kimi as needed):
- **Claude (Sonnet 4.5)**: Primary drafter for high-quality writing
  - **Strengths**: Nuanced writing, linguistic analysis, refactoring, multi-file coherence
  - **Use for**: Drafting sections, responding to reviews, complex rewrites, architectural decisions
  - **Token constraint**: Spawning Claude under Kimi's token budget avoids your 5-hour rate limit
  
- **Gemini (1.5 Pro/2.5)**: Large-scale analysis
  - **Strengths**: Massive context windows (1M+ tokens), multimodal, codebase-wide analysis
  - **Use for**: Initial project analysis, documentation generation, cross-file pattern detection
  
- **OpenAI/Codex**: Code generation specialists
  - **Strengths**: Mature tool ecosystem, reliable function calling
  - **Use for**: Specific code generation tasks, API integrations

## Communication Mechanism: The Filesystem

Since each CLI runs in isolation but shares a local directory, they communicate via **structured notes**:

### Communication Files

1. **`AGENTS.md`** (project-specific)
   - Project state, goals, architecture decisions
   - Which models are responsible for what
   - Style conventions and constraints

2. **`TODO.md`** or `todo-list.md`
   - Task queue with assignments
   - Format: `- [ ] Task description (@model)`
   - Example: `- [ ] Draft Section 3.2 (@claude)`

3. **`PROCEDURAL_ERROR_LOG.md`**
   - What not to do, learned from mistakes
   - Shared across all models to prevent repeated errors

4. **Code comments with `@model` tags**
   - `@claude: This needs your drafting touch`
   - `@gemini: Analyze this function for patterns`

5. **Structured output files**
   - `analysis-results.json` (for data exchange)
   - `draft-section-3.2-claude.md` (Claude's draft)
   - `code-review-notes.md`

### Workflow Pattern

**Instead of you managing 4 windows:**

```
You → Kimi: "Draft a response to Reviewer 2"

Kimi → Spawns Claude: 
  Prompt: "Write 300-word response addressing circularity 
           in Section 3. Reference hygiene protocol. 
           Formal but accessible tone."
  
Claude → Writes: draft-response.md

Kimi → Reviews: Checks consistency, adds citations

Kimi → You: "Here's a draft. Key points: [summary]"

You → Kimi: "Make paragraph 2 less defensive"

Kimi → Spawns Claude:
  Prompt: "Revise paragraph 2 to be less defensive 
           while maintaining technical points."
           
Kimi → You: Final version
```

**You interact with ONE CLI, get specialized quality, conserve tokens.**

## Token Management Strategy

**Problem**: You hit Claude's token limit every 5 hours

**Solution**: Let Kimi spawn Claude subagents
- Claude's output is generated under **Kimi's token budget**
- You get Claude-quality drafting without burning your Claude tokens
- Kimi's rate limits are more generous/less restrictive

**When to spawn Claude:**
- Drafting new sections
- Complex rewrites
- Responding to reviews
- Architectural explanations
- Any task where writing quality matters

**When NOT to spawn Claude:**
- Simple file operations (Kimi can do this)
- Git workflows (Kimi's strength)
- Searches and analysis (Kimi or Gemini)
- Quick fixes (Kimi)

## Git Workflow

```bash
# Kimi manages all git operations
# You never need to switch branches manually

# Feature branch creation
kimi> "Create a branch for revising Section 3"
→ git checkout -b feature/revise-section-3

# Claude does the work
kimi> "Draft the revision"
→ Spawns Claude with detailed prompt
→ Claude writes to working branch

# You review
kimi> "Show me what changed"
→ git diff master feature/revise-section-3

# Merge when ready (only after your approval)
kimi> "Merge this branch"
→ git checkout master
→ git merge feature/revise-section-3
→ git branch -d feature/revise-section-3
```

## Example Session

**You**: "I need to respond to Reviewer 2's concern about circularity in Section 3"

**Kimi**:
1. Reads Section 3, Reviewer 2 comments, AGENTS.md
2. Spawns Claude:
   ```
   Prompt: Reviewer 2 argues our hygiene protocol is circular 
   because diagnostics presuppose category membership. Draft a 
   300-word response that:
   - Addresses the circularity concern directly
   - Explains how behavioral diagnostics avoid presupposition
   - References the independence condition in Rule B
   - Maintains formal but accessible tone
   - Cites relevant literature (Boyd 1991, Haspelmath 2010)
   ```
3. Waits for Claude's draft
4. Reviews for consistency, adds citations if needed
5. Presents to you with summary

**You**: "Make it less defensive in paragraph 2"

**Kimi**:
1. Spawns Claude:
   ```
   Prompt: Revise paragraph 2 to be less defensive while 
   maintaining all technical points. Keep citations.
   ```
2. Integrates revision
3. Shows you final version

**You**: "Looks good, commit it"

**Kimi**:
1. Adds to git
2. Commits with descriptive message
3. Pushes if remote exists

## Best Practices

1. **Always start with Kimi** - Don't jump directly to other CLIs
2. **Let Kimi decide when to spawn** - Based on task type and constraints
3. **Use the filesystem for state** - Don't rely on context windows
4. **Document everything** - AGENTS.md, TODO.md, error logs
5. **Review before merge** - Kimi shows diffs, you approve merges
6. **Conserve tokens** - Spawn Claude for drafting, not for ops

## Benefits

- **One interface**: You only talk to Kimi
- **Quality where needed**: Claude for drafting, Gemini for analysis
- **Token efficiency**: Claude's output uses Kimi's budget
- **No context loss**: Filesystem stores state permanently
- **Transparent**: You see when subagents are spawned
- **Reviewable**: All changes shown before merging

## Current Implementation

This pattern is already partially implemented:
- Kimi CLI can spawn Claude subagents via Task tool
- Filesystem communication works (AGENTS.md, TODO lists)
- Git operations managed by Kimi
- Token limit management possible

**What's missing**: More proactive spawning of Claude for drafting tasks. Currently waits for explicit instruction rather than anticipating when specialized quality is needed.
