# TODO: DAG Updates Required

**Date**: 2025-11-08
**Status**: ✅ COMPLETE - New DAG created and integrated

---

## Issue

The DAG figure (Figure 2) PDF files exist but the .tex source files are missing:
- `dag_figure_page1.pdf`
- `dag_figure_page2.pdf`
- `dag_figure.pdf`

No corresponding `.tex` files found in project directory.

---

## Updates Needed

The DAG needs to reflect the updated two-layer measurement model:

### Parameter Changes

**Layer 1 (Diagnostic evidence)**:
- η_{L,c} ~ Normal(0, 1) [was: Normal(μ_family, 1)]
- Added explicit priors: α_i ~ Normal(0, 2), β_i ~ Normal(0, 1)
- Added: u_fam ~ Normal(0, σ_fam), v_coder ~ Normal(0, σ_coder)
- Added: σ_fam, σ_coder ~ Exponential(1)

**Layer 2 (Realization evidence)**:
- REMOVED: δ_fam term
- Model: logit(ρ) = κ + λη [was: κ + λη + δ_fam]
- Priors: κ ~ Normal(μ_κ, 1.5), λ ~ HalfNormal(0, 1)

**Derived quantities**:
- w_L(c,φ) = σ(κ + λ) = Pr(F|η=1)
- q_L(c,φ) = σ(κ) = Pr(F|η=0)

### Structural Elements to Show

1. **Two-layer architecture**:
   - Layer 1: d_i → η (diagnostics to latent comparandum)
   - Layer 2: η → F (latent comparandum to forms)

2. **Independence condition**: (F ⊥ d | η) - no direct path d → F

3. **Identifiability constraints**:
   - E[η] = 0 (location anchor)
   - Var(η) = 1 (scale anchor)
   - λ ≥ 0 (monotonicity)

4. **Random effects**:
   - Family-level: u_fam (in Layer 1)
   - Coder-level: v_coder (in Layer 1)
   - NO family effects in Layer 2 (δ_fam removed)

---

## Options for Creating New DAG

### Option A: TikZ/pgf in LaTeX
Create standalone .tex files with TikZ code that can be compiled to PDF:
```latex
\documentclass{standalone}
\usepackage{tikz}
\usetikzlibrary{shapes,arrows,positioning}
% ... DAG code
```

### Option B: External Tool
- Use graphviz/dot
- Use draw.io or similar
- Export as PDF

### Option C: Python (networkx + matplotlib)
```python
import networkx as nx
import matplotlib.pyplot as plt
# ... generate DAG
```

---

## Recommended Approach

Create two TikZ .tex files:

1. **dag_layer1.tex** - Layer 1 measurement model
   - Shows: diagnostics d_i → η with parameters α, β, u_fam, v_coder
   - Highlights: Anti-circularity (no φ nodes)

2. **dag_layer2.tex** - Layer 2 measurement model
   - Shows: η → F_{L,c,φ} with parameters κ, λ
   - Highlights: Derived quantities w_L, q_L

Or combine into one two-panel figure showing both layers with clear separation.

---

## Next Steps

1. Decide on DAG creation method (TikZ recommended for consistency)
2. Create source .tex files
3. Compile to PDF
4. Update main.tex if filenames change
5. Verify Figure 2 caption accurately describes new model

---

**Priority**: Medium (figures should match formalism, but text is now correct)

---

## COMPLETION NOTE

**Date**: 2025-11-08

✅ **Task complete**. Created `dag_two_layer_model.tex` - a comprehensive Pearl-style causal DAG showing:

- Both layers in unified framework
- All parameters, hyperparameters, and random effects
- Conditional independence (F ⊥ d | η) visually clear
- Four identifiability constraints annotated
- Derived quantities w_L and q_L shown
- Complete prior specifications

Replaced two-page DAG (dag_figure_page1.pdf, dag_figure_page2.pdf) with single comprehensive diagram.

**See**: `reviews/dag-update-complete.md` for full details.

**Compilation**: ✅ Clean (30 pages, 415KB)
