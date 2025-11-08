# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

**TEST EDIT:** This line was added to test the sync hook.

## Project Overview

This is an academic research paper in linguistic typology titled "Naturalizing Typological Kinds: Comparanda, Mechanisms, and Measurement" by Brett Reynolds. The paper proposes a homeostatic framework for handling cross-linguistic comparison that separates comparative concepts from language-specific realizations.

## Build System

This LaTeX project requires **XeLaTeX or LuaLaTeX** (not pdfLaTeX) due to the Charis SIL font requirement.

### Compilation Commands

```bash
# Full build sequence
lualatex main.tex
biber main
lualatex main.tex
lualatex main.tex

# Alternative with XeLaTeX
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

The multiple runs are necessary to resolve all cross-references and citations.

### Bibliography Management

- Bibliography file: `references.bib`
- Uses `biblatex` with `biber` backend (not BibTeX)
- Citation style: APA via `biblatex-apa`
- Language mapping: British English with American-style quotations

## Document Architecture

### Three-Level Ontological Framework

The paper's core theoretical contribution is a three-tier ontology that separates:

1. **Level I (Cross-linguistic pressures)**: Semantic targets and discourse roles (e.g., \textsc{specificity}ₓ, \textsc{topic}ₓ)
2. **Level II (Cross-linguistic syntax)**: Functions and categories as comparative concepts (e.g., \textsc{subject}ₓ, \textsc{V}ₓ)
3. **Level III (Language-internal syntax)**: Language-specific realizations (e.g., \textsc{subject}ₑₙ𝒈, \textsc{V}ₑₙ𝒈)

This distinction is maintained through subscript notation throughout the document.

### Subscript Conventions

- `\textsubscript{\Cross}` - Cross-linguistic comparative concepts
- `\textsubscript{Eng}`, `\textsubscript{Jpn}`, etc. - Language-specific realizations
- `\textsubscript{$L$}` - Generic language-internal reference

### Custom Macros

- `\term{text}` - Italicized technical terminology
- Uses `\textcite{}` for in-text citations and `\parencite{}` for parenthetical citations

## Key LaTeX Packages

- `langsci-gb4e` - Linguistic example numbering and glossing
- `fontspec` - Font management (requires XeLaTeX/LuaLaTeX)
- `csquotes` - Context-sensitive quotation marks
- `hyperref` - PDF hyperlinks and metadata
- `array`, `booktabs` - Enhanced table formatting
- Custom column type: `\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}`

## File Structure

- `main.tex` - Main document source
- `references.bib` - BibTeX bibliography database
- `dag_figure.pdf`, `dag_figure_page1.pdf`, `dag_figure_page2.pdf` - DAG diagrams
- `matrix_figure.pdf`, `matrix_figure_v2.pdf` - Matrix visualization figures
- **Note**: The paper references `src/typology.py` as a supplementary Python specification, but this file is not currently present in the repository

## Content Organization

The paper follows this structure:

1. **Orientation** (§1) - Introduces the three-level ontology and terminological framework
2. **Failure Modes** (§2) - Diagnoses four systematic conflation errors in typological research
3. **Matrix Framework** (§3) - Operationalizes the three-level mapping
4. **Syntax-Semantics Hygiene** (§4) - Protocol for testing semantic targets independently
5. **Naturalized Comparative Concepts** (§5-6) - Mechanisms for stabilizing comparative concepts
6. **Measurement** (§7) - Latent variable models
7. **Predictions** (§8) - Falsifiable predictions with declared thresholds
8. **Illustrations** (§9) - Applications to typological debates
9. **Objections** (§10) - Addresses measurement feasibility and circularity concerns

## Terminological Discipline

The paper maintains strict distinctions between:

- **Function** - Syntactic functions only (unqualified)
- **Target** - Semantic targets
- **Role** - Discourse/pragmatic roles
- **Category** - Syntactic categories
- **Comparanda** - Cross-linguistic phenomena being compared (distinct from language-specific realizations)

## Common Editing Tasks

### Adding Citations

1. Add entry to `references.bib` following existing format
2. Use `\textcite{key}` for narrative citations: "Smith (2020) argues..."
3. Use `\parencite{key}` for parenthetical citations: "...as shown previously (Smith 2020)"

### Adding Linguistic Examples

Use the `gb4e` environment and commands from `langsci-gb4e` package.

### Including Figures

- Store as PDF files
- Use `\includegraphics[scale=X]{filename.pdf}`
- Figures are currently placed with `[ht]` positioning

### Working with Tables

- Use `booktabs` package commands: `\toprule`, `\midrule`, `\bottomrule`
- Custom `L{width}` column type available for left-aligned paragraph columns
- Use `\addlinespace[4pt]` for spacing between table rows

## Academic Context

The paper engages with foundational typological literature (Haspelmath, Croft, Dixon) and applies homeostatic property cluster (HPC) theory from philosophy of science (Boyd, Khalidi) to linguistic typology. It aims to preserve the empirical ambition of typology while avoiding universalist overreach.
