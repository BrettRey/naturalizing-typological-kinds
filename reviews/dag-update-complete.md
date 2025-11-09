# DAG Update: Complete

**Date**: 2025-11-08
**Status**: ✅ Complete

---

## Summary

Created a new Pearl-style causal DAG showing the complete two-layer hierarchical measurement model. The single comprehensive DAG replaces the previous two-page figure.

---

## What Was Created

### File: `dag_two_layer_model.tex`

A standalone TikZ document showing:

**Layer 1 (Diagnostic Evidence)**:
- Latent variable: η_{L,c} (comparandum strength)
- Observed: d_{L,i} (diagnostics)
- Parameters: α_i, β_i (diagnostic-specific)
- Random effects: u_fam, v_coder
- Hyperparameters: σ_fam, σ_coder
- Plate notation for i ∈ {1,...,I}

**Layer 2 (Realization Evidence)**:
- Latent variable: η_{L,c} (same as Layer 1)
- Observed: F_{L,c,φ,t} (forms)
- Parameters: κ_{L,c,φ}, λ_{c,φ}
- Plate notation for φ ∈ Φ_c

**Key Features**:
- Visual styles distinguish observed (filled circles), latent (unfilled circles), parameters (rectangles), hyperparameters (rounded rectangles), and derived quantities (diamonds)
- Clear causal arrows showing dependencies
- Annotation boxes for:
  - Anti-circularity condition: F ⊥ d | η
  - Four identifiability constraints
  - Prior distributions for both layers
  - Derived weight formulas

**Pearl-style Design**:
- Proper causal DAG structure
- Conditional independence visually clear (no direct d → F path)
- All parameters and hyperparameters shown
- Plate notation for repeated measurements
- Mathematically complete

---

## Changes to main.tex

**Lines 284-289** (Figure 2):

**Before**: Two separate PDFs (dag_figure_page1.pdf, dag_figure_page2.pdf) showing Stage 1 and Stage 2

**After**: Single comprehensive DAG (dag_two_layer_model.pdf)

**New Caption**:
> Two-layer hierarchical measurement model with causal structure. **Layer~1** (left) diagnoses latent comparandum strength η_{L,c} from behavioural diagnostics d_{L,i} without reference to morphosyntactic forms, incorporating diagnostic-specific parameters (α_i, β_i), family-level random effects (u_fam), and coder-level effects (v_coder). **Layer~2** (right) models how η_{L,c} causes observable forms F_{L,c,φ,t} via structural parameters κ_{L,c,φ} and λ_{c,φ}. The conditional independence (F ⊥ d | η) ensures anti-circularity: diagnostics never condition on forms. Four identifiability constraints (location anchoring 𝔼[η]=0, scale anchoring Var(η)=1, monotonicity λ≥0, and two independent measurement layers) ensure unique parameter estimation. Derived quantities w_L(c,φ)=σ(κ+λ) and q_L(c,φ)=σ(κ) measure conditional probabilities of form selection.

---

## Compilation Status

✅ **dag_two_layer_model.tex**: Compiles cleanly to PDF (1 page, 73KB)
✅ **main.tex**: Compiles cleanly with new DAG (30 pages, 415KB)
✅ No errors or warnings (except minor ISBN validation in biber)

---

## Design Decisions

### Why One DAG Instead of Two?

The single DAG is superior because:
1. Shows both layers in unified causal framework
2. Makes conditional independence (F ⊥ d | η) visually obvious
3. Displays all identifiability constraints in one view
4. Includes complete prior specifications
5. Shows derived quantities and their relationship to structural parameters
6. More compact while being more comprehensive

### Pearl-Style Elements

Following Judea Pearl's causal graphical model conventions:
- Nodes represent variables (observed/latent/parameters)
- Directed edges represent direct causal influence
- Absence of edges represents conditional independence
- Plate notation for repeated measurements
- Clear distinction between observed and latent via visual style
- Annotations for key constraints and independence conditions

### What the DAG Shows That Old Version Didn't

1. **Complete parameter set**: All 9 parameters with their priors
2. **Hyperparameter hierarchy**: σ_fam, σ_coder → u_fam, v_coder
3. **Identifiability constraints**: All 4 mechanisms annotated
4. **Derived quantities**: w_L and q_L shown as functions of κ, λ
5. **Monotonicity constraint**: λ ≥ 0 explicitly noted
6. **Independence structure**: (F ⊥ d | η) highlighted in red box

---

## Files Modified

1. **Created**: `dag_two_layer_model.tex` (standalone TikZ document)
2. **Modified**: `main.tex` (lines 284-289, figure reference and caption)

---

## Relation to Formalism Fixes

This DAG update completes the formalism fix cycle:

1. ✅ **Identifiability**: DAG shows all 4 constraints visually
2. ✅ **Type safety**: w_L shown as derived from κ, λ (not primary parameter)
3. ✅ **Generative model**: All priors displayed on DAG
4. ✅ **Anti-circularity**: Independence (F ⊥ d | η) highlighted

The DAG is now a faithful visual representation of the two-layer measurement model described in §6.1.

---

## Old Files (Can Be Removed)

The following files are now obsolete:
- `dag_figure_page1.pdf`
- `dag_figure_page2.pdf`
- `dag_figure.pdf` (if it exists)

**Recommendation**: Keep old files for archival purposes, but they are no longer referenced in main.tex.

---

## Next Steps

None required. DAG update is complete and paper compiles successfully.

If further refinements are desired:
- Adjust node positions for optimal layout
- Modify colors/styles for publication requirements
- Add/remove annotations based on space constraints

---

**Created by**: Claude Sonnet 4.5
**Compilation**: Verified clean on 2025-11-08
