# Changelog

All notable changes to "Naturalizing Typological Kinds: Comparanda, Mechanisms, and Measurement" will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added
- Complete documentation infrastructure
  - README.md with build instructions and project overview
  - LICENSE (CC BY 4.0)
  - This CHANGELOG.md
  - Makefile for automated builds
- Python specification (`src/typology.py`)
  - Three-level ontology implementation
  - Comparanda-realization mappings
  - Weight functions and reliability scores
  - Syntax-semantics hygiene protocol
  - Naturalized comparative concepts framework
  - Homeostatic mechanisms
  - Measurement models with latent variables
- AI assistant documentation sync system
  - Pre-commit hook for keeping CLAUDE.md, AGENTS.md, GEMINI.md synchronized
  - Design document at `docs/plans/2025-11-07-ai-docs-sync-design.md`
- Git version control initialized

## [1.0.0] - 2025-11-07

### Added
- Initial paper structure
- Three-level ontology framework (Level I, II, III)
- Comparanda-realization mapping apparatus
- Syntax-semantics hygiene protocol
- Four systematic failure modes identified:
  - Dual-use terminology and category-function conflation
  - Cluster reduction
  - Template import
  - False universalization
- Naturalized comparative concepts framework
- Homeostatic mechanisms (cognitive, discourse, diachronic, community)
- Measurement models using latent variables
- Five falsifiable predictions with declared thresholds
- Biological interlude on character-identity mechanisms (Section 6)
- Applications to three typological debates (Section 9)
- Responses to objections (Section 10)
- Complete bibliography with APA citations

### Content Sections
1. Orientation - Terminological discipline and three-level ontology
2. Where typology goes wrong - Four failure modes
3. Comparanda-realization matrix - Formal mapping apparatus
4. Syntax-semantics hygiene - Independent diagnostic protocols
5. Naturalized comparative concepts - Promotion criteria
6. Homeostatic mechanisms - Including biological analogy (eyes)
7. Measurement - Latent variable models
8. Predictions - Five falsifiable predictions
9. Illustrations - Applications to debates
10. Threats - Addressing objections

### Technical Details
- Uses LuaLaTeX/XeLaTeX compilation (Charis SIL font)
- Bibliography via biblatex-apa with Biber backend
- Custom subscript notation for cross-linguistic vs. language-specific
- Linguistic examples via langsci-gb4e package
- Figures: DAG diagrams and matrix visualizations

### Acknowledgments
- AI assistance: ChatGPT o1, Claude Sonnet 4.5, Gemini Pro 2.5
- Author: Brett Reynolds (Humber Polytechnic & University of Toronto)
- ORCID: 0000-0003-0073-7195

---

## Version History Notes

This paper is under active development. Version numbers follow semantic versioning:
- **Major** (X.0.0): Significant theoretical revisions or restructuring
- **Minor** (0.X.0): New sections, substantial additions, or major edits
- **Patch** (0.0.X): Corrections, clarifications, bibliography updates

### Future Planned Additions
- [ ] Empirical case studies with quantitative data
- [ ] Extended Python specification with statistical models
- [ ] Interactive visualizations of comparanda-realization mappings
- [ ] Supplementary materials with worked examples
- [ ] Response to peer review (when submitted)
