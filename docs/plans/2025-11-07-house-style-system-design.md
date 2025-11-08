# House Style System Design

**Date:** 2025-11-07
**Purpose:** Create a reusable house style framework for LaTeX academic papers with multi-AI agent support

## Problem Statement

Working across multiple LaTeX papers with multiple AI assistants (Claude Code, Kimi/Codex CLI, Gemini) requires:
1. Consistent LaTeX conventions and writing style
2. Machine-readable rules that AI assistants can follow
3. Automated enforcement to catch style violations
4. Easy project creation with all scaffolding pre-configured
5. Ability to freeze papers (under review/published) while allowing live papers to evolve

Previously worked in Overleaf with manual copy-paste to web chat LLMs. Moving to multi-agent CLI workflow requires more structured approach.

## Solution Overview

A three-tier house style system with:
1. **Central source of truth** - Canonical house style in parent directory
2. **Project snapshots** - Each paper gets frozen copy at creation time
3. **Three agents** - Creation, guidance during writing, enforcement before commit

## Architecture

### 1. Central House Style Directory

Located at: `~/Documents/LLM-CLI projects/.house-style/`

```
.house-style/
├── VERSION                    # Semantic version (e.g., 1.0.0)
├── style-rules.yaml          # Machine-readable conventions
├── preamble.tex              # LaTeX setup (packages, macros)
├── style-guide.md            # Human-readable guide
├── templates/
│   ├── paper-template/       # Complete skeleton project
│   │   ├── main.tex
│   │   ├── references.bib
│   │   ├── Makefile
│   │   ├── .gitignore
│   │   ├── CLAUDE.md         # All three AI docs
│   │   ├── AGENTS.md         # include house style
│   │   ├── GEMINI.md         # and stay synced
│   │   ├── .git/hooks/pre-commit
│   │   └── .house-style-version
│   └── agents/
│       ├── create-paper.sh   # Project creation agent
│       └── enforce-style.py  # Style enforcement checker
└── README.md                  # Documentation
```

### 2. Individual Paper Structure

When created from template:

```
Paper_Project_Name/
├── .house-style-version       # "1.0.0" - snapshot reference
├── .house-style/              # Local snapshot (frozen at creation)
│   ├── style-rules.yaml
│   └── preamble.tex
├── main.tex                   # Uses: \input{.house-style/preamble.tex}
├── references.bib
├── Makefile
├── .gitignore
├── CLAUDE.md                  # Base content + house style rules
├── AGENTS.md                  # Same content (kept in sync)
├── GEMINI.md                  # Same content (kept in sync)
├── .git/hooks/pre-commit      # Syncs AI docs + enforces style
├── docs/plans/                # Design documents
└── src/                       # Code/specifications (if needed)
```

### 3. Three-Agent Workflow

**Agent 1: Project Creation** (`create-paper.sh`)
- Lives in central `.house-style/templates/agents/`
- Creates new paper from template
- Customizes for paper name/title
- Copies house style snapshot
- Initializes git with hooks

**Agent 2: AI Guidance During Writing**
- AI assistants read house style from their .md files
- All three files (CLAUDE.md, AGENTS.md, GEMINI.md) contain same rules
- Rules extracted from `style-rules.yaml` and embedded in markdown

**Agent 3: Style Enforcement** (`enforce-style.py`)
- Runs via pre-commit hook
- Checks .tex files for style violations
- Three modes: warning (default), strict, auto-fix
- Integrated with existing AI doc sync hook

## Component Details

### Machine-Readable Style Rules (style-rules.yaml)

Structure:

```yaml
version: "1.0.0"
name: "Brett Reynolds House Style"

# LaTeX conventions
latex:
  mention_vs_quotation:
    rule: "Use \\term{} for mention, \\enquote{} for quotations"
    examples:
      correct: "\\term{going forward} is a preposition"
      incorrect: "\"going forward\" is a preposition"

  dashes:
    em_dash: "Use en dash with spaces for parenthetical: foo~-- bar~-- baz"
    range: "Use en dash for ranges: 2001--2025"
    hyphen: "Use hyphen only for compounds: corpus-based"

  cross_linguistic_notation:
    rule: "Use \\textsubscript{\\Cross} for cross-ling, \\textsubscript{eng} for language"
    examples:
      - "\\textsc{subject}\\textsubscript{\\Cross}"
      - "\\textsc{subject}\\textsubscript{eng}"

# Writing style
prose:
  contractions: "preferred"
  paragraph_length:
    target: 60
    max: 100

  avoid:
    - "throat-clearers like 'It is important to note that'"
    - "paragraph{} headings - use topic sentences"
    - "bold labels in prose for enumeration"
    - "hackneyed adverbs: moreover, furthermore"

  prefer:
    - "direct verbs and short clauses"
    - "simple coordinators: and, but"
    - "ordinal markers: first, second, third"
    - "concrete before abstract"

# Citations
citations:
  parenthetical: "\\citep{key}"
  textual: "\\textcite{key}"

# Structure
document_structure:
  sections:
    allowed: ["\\section{}", "\\subsection{}"]
    avoid: ["\\paragraph{}"]

  lists:
    use_for:
      - "hypothesis/prediction lists"
      - "linguistic examples"
      - "codebook entries"
    avoid_for:
      - "argumentative sequences (use prose)"
      - "objection-reply pairs (use discourse markers)"
```

### AI Documentation Integration

Each AI's .md file contains:

1. **Project-specific context**
   - Build commands
   - File structure
   - Architecture overview

2. **House style rules** (auto-generated from YAML)
   ```markdown
   ---

   ## House Style (v1.0.0)

   ### LaTeX Conventions
   [extracted from style-rules.yaml]

   ### Writing Style
   [extracted from style-rules.yaml]
   ```

**Generation process:**
- Template includes converter script: `yaml-to-markdown.py`
- Converts `style-rules.yaml` → markdown section
- Appends to AI documentation files
- Pre-commit hook keeps all three synced

### Style Enforcement Agent (enforce-style.py)

**Capabilities:**

```python
class StyleEnforcer:
    def __init__(self, style_rules_yaml):
        self.rules = load_yaml(style_rules_yaml)

    def check_tex_files(self, files):
        violations = []

        for file in files:
            violations += self.check_mention_vs_quotation(file)
            violations += self.check_paragraph_headings(file)
            violations += self.check_cross_ling_notation(file)
            violations += self.check_prohibited_phrases(file)

        return violations
```

**Three enforcement modes:**

1. **Warning mode** (default)
   ```
   [STYLE] Found 3 potential violations in main.tex:
   - Line 42: Consider using \term{} instead of quotes
   - Line 89: Paragraph heading detected
   - Line 103: Throat-clearer detected

   Commit allowed. Review warnings above.
   ```

2. **Strict mode**
   ```
   [STYLE] ERROR: 3 violations must be fixed before commit
   ```

3. **Auto-fix mode**
   ```bash
   .git/hooks/pre-commit --fix
   ```

**Pre-commit hook integration:**

```bash
#!/bin/bash
# 1. Sync AI documentation (existing system)
# 2. Enforce style rules (new)
# 3. Exit with combined status
```

### Project Creation Agent (create-paper.sh)

**Usage:**
```bash
cd ~/Documents/LLM-CLI\ projects/
.house-style/templates/agents/create-paper.sh "New Paper Title"
```

**Workflow:**

1. **Validate input**
   - Check paper name provided
   - Sanitize: "New Paper Title" → "New_Paper_Title"
   - Verify directory doesn't exist

2. **Copy and customize template**
   ```bash
   cp -r .house-style/templates/paper-template/ "New_Paper_Title/"
   cd "New_Paper_Title/"
   # Update main.tex title
   # Update AI docs with paper name
   # Copy house style snapshot
   ```

3. **Initialize git**
   ```bash
   git init
   git add .
   git commit -m "Initial commit from house-style v1.0.0"
   ```

4. **Report success**
   ```
   ✓ Created paper: New_Paper_Title
   ✓ House style version: 1.0.0
   ✓ Git initialized with hooks

   Next: cd New_Paper_Title && make
   ```

**Optional flags:**
- `--no-git` - Skip git initialization
- `--version X.Y.Z` - Use specific house style version
- `--update-style` - Update existing paper's snapshot

## Snapshot vs. Live Updates

**Philosophy:** Safety through isolation, flexibility through manual updates

**Frozen papers:**
- Papers under review or published
- Use snapshot from creation time
- No automatic updates
- Recorded in `.house-style-version`

**Live papers:**
- Active development
- Can manually update snapshot:
  ```bash
  cp ../.house-style/style-rules.yaml .house-style/
  cp ../.house-style/preamble.tex .house-style/
  # Regenerate AI docs
  ```

**Central updates:**
- Fix bugs in central `.house-style/`
- Increment VERSION
- Papers opt-in when ready

## Implementation Phases

### Phase 1: Bootstrap Current Project
1. Create `.house-style/` in parent directory
2. Extract preamble from current `house-style-and-preamble.tex`
3. Create initial `style-rules.yaml`
4. Build `create-paper.sh` script
5. Test by creating dummy project

### Phase 2: Style Enforcement
1. Build `enforce-style.py` with basic checks
2. Integrate with pre-commit hook
3. Test on current project
4. Add auto-fix capabilities

### Phase 3: AI Integration
1. Create `yaml-to-markdown.py` converter
2. Generate house style sections for AI docs
3. Update template to include in all three .md files
4. Test with each AI assistant

### Phase 4: Refinement
1. Interview to polish style rules
2. Add more enforcement checks
3. Create user documentation
4. Version 1.0.0 release

## Success Criteria

- ✓ Single command creates new paper with all scaffolding
- ✓ All three AI assistants follow house style consistently
- ✓ Pre-commit hook catches common violations
- ✓ Papers can be frozen or updated independently
- ✓ Central house style is single source of truth

## Future Enhancements

- Visual dashboard showing which papers use which house style version
- Automated migration scripts for major version updates
- Additional enforcement checks (BibTeX formatting, figure references)
- Integration with LaTeX linters (ChkTeX, LaTeXindent)
- Template variants (article, book, presentation)

## Migration Path from Overleaf

For existing Overleaf projects:
1. Export LaTeX source
2. Run `create-paper.sh "Existing Project Name"`
3. Copy content from Overleaf export into generated structure
4. Run style enforcement to identify needed adjustments
5. Commit to git with full version history going forward
