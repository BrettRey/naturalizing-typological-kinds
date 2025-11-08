# Naturalizing Typological Kinds: Comparanda, Mechanisms, and Measurement

An academic research paper in linguistic typology by Brett Reynolds (Humber Polytechnic & University of Toronto).

## Overview

This paper proposes a homeostatic framework for linguistic typology that separates cross-linguistic comparative concepts from language-specific realizations. The framework addresses systematic conflation errors in typological research through:

1. A three-tier **comparanda-realization** mapping that distinguishes cross-linguistic functions, semantic targets, discourse roles, and categories from their language-specific realizations
2. A **syntax-semantics hygiene protocol** for diagnosing targets independently of morphosyntactic exponents
3. **Naturalized comparative concepts** with explicit homeostatic mechanisms and failure modes

The theoretical machinery is formalized in an auditable Python specification (`src/typology.py`).

## Prerequisites

### Required Software

- **LaTeX Distribution**: TeX Live, MiKTeX, or MacTeX
- **LaTeX Engine**: XeLaTeX or LuaLaTeX (pdfLaTeX will not work due to font requirements)
- **Bibliography Tool**: Biber (included with most LaTeX distributions)
- **Font**: Charis SIL (download from [SIL International](https://software.sil.org/charis/))

### Optional Tools

- **Python 3.8+**: For running the theoretical specification in `src/typology.py`
- **Make**: For using the automated build system (Makefile)
- **Git**: For version control

## Building the Paper

### Quick Build (Manual)

```bash
# Full compilation sequence
lualatex main.tex
biber main
lualatex main.tex
lualatex main.tex
```

Or with XeLaTeX:

```bash
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

### Automated Build (with Make)

```bash
# Build the PDF
make

# Clean build artifacts
make clean

# Clean everything including PDF
make distclean
```

### Why Multiple Runs?

- **First run**: Generates auxiliary files and collects citations
- **Biber**: Processes bibliography and generates .bbl file
- **Second run**: Incorporates bibliography and updates references
- **Third run**: Resolves all cross-references and finalizes layout

## Project Structure

```
.
├── main.tex                  # Main LaTeX document
├── references.bib            # BibTeX bibliography database
├── src/
│   └── typology.py          # Auditable specification of theoretical machinery
├── docs/
│   └── plans/               # Design documents
├── *.pdf                    # Figure files (DAG diagrams, matrices)
├── CLAUDE.md                # AI assistant guidance (auto-synced)
├── AGENTS.md                # AI assistant guidance (auto-synced)
├── GEMINI.md                # AI assistant guidance (auto-synced)
└── README.md                # This file
```

## Key Features

### Three-Level Ontology

The paper maintains strict separation between:

- **Level I**: Cross-linguistic pressures (semantic targets, discourse roles)
- **Level II**: Cross-linguistic syntax (functions and categories as comparative concepts)
- **Level III**: Language-internal syntax (language-specific realizations)

### Subscript Notation

Throughout the document:
- `\textsubscript{\Cross}` marks cross-linguistic comparative concepts
- `\textsubscript{Eng}`, `\textsubscript{Jpn}`, etc. mark language-specific realizations
- `\textsubscript{$L$}` marks generic language-internal references

### Custom LaTeX Macros

- `\term{text}` - Italicized technical terminology
- `\textcite{key}` - Narrative citations
- `\parencite{key}` - Parenthetical citations

## Adding References

1. Add entry to `references.bib` following existing APA format
2. Cite in text using `\textcite{key}` or `\parencite{key}`
3. Rebuild with biber to update bibliography

## Working with Multiple AI Assistants

This repository includes synchronized documentation for different AI assistants:

- **CLAUDE.md** - For Claude Code
- **AGENTS.md** - For Kimi CLI and Codex
- **GEMINI.md** - For Gemini

These files are automatically kept in sync via a pre-commit git hook. Edit any of them, and the changes will propagate to the others on commit.

## Theoretical Specification

The Python file `src/typology.py` provides an executable, auditable specification of:

- Comparanda-realization mappings
- Weight functions and reliability scores
- Syntax-semantics hygiene protocols
- Naturalization criteria
- Homeostatic mechanisms

Run tests with:

```bash
python -m pytest src/typology.py
```

## Author

**Brett Reynolds**
ORCID: [0000-0003-0073-7195](https://orcid.org/0000-0003-0073-7195)
Email: brett.reynolds@humber.ca
Affiliation: Humber Polytechnic & University of Toronto

## AI Assistance

This paper was developed with extensive assistance from ChatGPT o1, Claude Sonnet 4.5, and Gemini Pro 2.5. All material was reviewed, edited, and approved by the author.

## Citation

```bibtex
@unpublished{Reynolds2025Typology,
  author  = {Reynolds, Brett},
  title   = {Naturalizing Typological Kinds: Comparanda, Mechanisms, and Measurement},
  year    = {2025},
  note    = {Manuscript in preparation}
}
```

## License

See LICENSE file for details.

## Contributing

This is an individual research paper. For questions or comments, please contact the author directly.
