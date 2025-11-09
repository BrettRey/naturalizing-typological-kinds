# Codex Review Fixes - Implementation Report

**Date**: 2025-11-08
**Branch**: feature/two-layer-measurement-model
**Status**: ✅ All fixes complete and verified

---

## Summary

All 4 issues identified by Codex have been resolved. The document now has mathematically consistent formalism with complete identifiability.

---

## Fix 1: Removed Legacy Equation from §3.1 ✅

**Issue**: Lines 173-177 contained old single-layer equation that contradicted two-layer model

**Old code** (REMOVED):
```latex
\noindent Even better, treat $w_L$ as a \emph{parameter to be refined} by the
measurement model (Section~\ref{sec:measurement}) rather than pre-specified.
In this approach, each diagnostic $d_i$ provides evidence for the latent
comparandum $\eta_c$, and the model estimates the mapping strength via:
\[
  \text{logit}(p(d_i = 1 \mid \eta_c, L)) = \alpha_i + \beta_i \cdot w_L(c, \phi) \cdot \eta_c
\]
where $w_L(c,\phi)$ is estimated as part of the model, constrained by partial
pooling across languages and families. This avoids circularity: the weights are
\emph{inferred} from diagnostic patterns rather than stipulated by analysts.
```

**New code** (line 171):
```latex
\paragraph{Interpretation and identifiability.} The weight function $w_L(c,\phi)$
measures the conditional probability that form $\phi$ is selected when comparandum
$c$ is at maximum strength... Identifiability is ensured by anchoring the latent
scale (fixing $\text{Var}(\eta)=1$ and $\mathbb{E}[\eta]=0$), enforcing monotonicity
($\lambda_{c,\phi} \geq 0$), and separating diagnostic evidence (Level~I) from
realization evidence (Level~III). The two-layer measurement model (Section~\ref{sec:measurement})
estimates $w_L$ as a derived quantity from structural parameters $\kappa$ and $\lambda$,
avoiding circularity by ensuring diagnostics never condition on Level~III forms.
```

**Why this fixes the problem**:
- Removed the w_L · η product (identifiability problem)
- Removed diagnostic dependence on w_L (anti-circularity violation)
- Added explicit mention of location constraint (E[η]=0)
- Points to two-layer model for details

---

## Fix 2: Removed δ_fam from Layer 2 ✅

**Issue**: Generative model included δ_fam but derived weights dropped it

**Old code** (line 452):
```latex
\text{logit}(\rho_{L,c,\phi,t}) &= \kappa_{L,c,\phi} + \lambda_{c,\phi} \eta_{L,c} + \delta_{\text{fam}(\phi)}
```

With prior:
```latex
\delta_{\text{fam}} &\sim \text{Normal}(0, 0.5)
```

**New code** (line 446):
```latex
\text{logit}(\rho_{L,c,\phi,t}) &= \kappa_{L,c,\phi} + \lambda_{c,\phi} \eta_{L,c}
```

δ_fam prior removed.

**Why this fixes the problem**:
- Now w_L = σ(κ + λ) actually equals Pr(F=1|η=1) as claimed
- q_L = σ(κ) actually equals Pr(F=1|η=0) as claimed
- No discrepancy between generative model and interpretation

**Design choice**: Removed δ_fam rather than including it in derived weights
- Simpler model
- Weights are universal, not family-specific
- Genealogical variation already captured by u_fam in Layer 1

---

## Fix 3: Fixed Table 2 Caption ✅

**Issue**: Caption said "80% credible intervals" but parentheses showed q_L

**Old caption** (line 203):
```latex
... values show posterior means with 80\% credible intervals.
False-positive rates $q_L(c,\phi)$ shown in parentheses.
```

**New caption** (line 197):
```latex
... values show posterior means. False-positive rates
$q_L(c,\phi)=\Pr(F_{L,c,\phi}=1 \mid \eta_{L,c}=0)$ shown in parentheses.
```

**Why this fixes the problem**:
- Removed false claim about credible intervals
- Added explicit definition of q_L
- Caption now matches table content

---

## Fix 4: Added Location Constraint and Missing Priors ✅

**Issue**: No constraint on μ_family, missing priors for Layer 1 parameters

### Change A: Fixed η distribution (line 432)

**Old**:
```latex
$\eta_{L,c} \sim \text{Normal}(\mu_{\text{family}}, 1)$ is the latent comparandum
strength (variance fixed at 1 to anchor the scale)
```

**New**:
```latex
$\eta_{L,c} \sim \text{Normal}(0, 1)$ is the latent comparandum strength
(mean fixed at 0 and variance at 1 to anchor location and scale)
```

### Change B: Added missing priors (lines 434-438)

**Old**:
```latex
\item $\alpha_i$ is diagnostic-specific difficulty
\item $\beta_i$ is diagnostic discrimination (how informative the test is)
\item $u_{\text{fam}}$ captures phylogenetic clustering via partial pooling
\item $v_{\text{coder}}$ captures systematic coder biases
```

**New**:
```latex
\item $\alpha_i \sim \text{Normal}(0, 2)$ is diagnostic-specific difficulty
\item $\beta_i \sim \text{Normal}(0, 1)$ is diagnostic discrimination
\item $u_{\text{fam}} \sim \text{Normal}(0, \sigma_{\text{fam}})$ captures phylogenetic clustering
\item $v_{\text{coder}} \sim \text{Normal}(0, \sigma_{\text{coder}})$ captures systematic coder biases
\item $\sigma_{\text{fam}}, \sigma_{\text{coder}} \sim \text{Exponential}(1)$ are hierarchical standard deviations
```

### Change C: Updated identifiability paragraph (lines 468-476)

**Old**:
```latex
\paragraph{Identifiability.} Three mechanisms ensure unique parameter estimation:
\begin{enumerate}
  \item \textbf{Variance anchoring:} Fixing $\text{Var}(\eta)=1$ breaks the
        $(k \cdot w_L, \eta/k)$ scaling symmetry
  ...
```

**New**:
```latex
\paragraph{Identifiability.} Four mechanisms ensure unique parameter estimation:
\begin{enumerate}
  \item \textbf{Location anchoring:} Fixing $\mathbb{E}[\eta]=0$ eliminates
        translation invariance between $\eta$ and $\kappa$
  \item \textbf{Scale anchoring:} Fixing $\text{Var}(\eta)=1$ breaks the
        $(k \cdot w_L, \eta/k)$ scaling symmetry
  ...
```

### Change D: Updated multilevel explanation (line 485)

**Old**:
```latex
This is a multilevel model because languages share evolutionary history:
$\eta_{L,c} \sim \text{Normal}(\mu_{\text{family}}, 1)$ implements partial
pooling by genealogy...
```

**New**:
```latex
This is a multilevel model because languages share evolutionary history: the
phylogenetic random effect $u_{\text{fam}}$ implements partial pooling by genealogy,
preventing spurious correlations from areal clustering. The latent comparandum strength
$\eta_{L,c}$ is anchored at $\mathbb{E}[\eta]=0$ with $\text{Var}(\eta)=1$ to ensure
both location and scale identifiability.
```

**Why this fixes the problem**:
- E[η]=0 eliminates translation invariance: can't shift η and κ by constant Δ
- All Layer 1 parameters now have priors → complete joint distribution
- Identifiability proof now has 4 mechanisms (was missing location)
- Partial pooling now via u_fam, not via μ_family

---

## Mathematical Verification

### Translation Invariance Test

**Before fix**:
```
logit(p) = α + βη
logit(ρ) = κ + λη

If η' = η + Δ and κ' = κ - λΔ:
κ' + λη' = (κ - λΔ) + λ(η + Δ) = κ + λη  ✗ NOT IDENTIFIED
```

**After fix**:
```
Constraint: E[η] = 0

If we shift η' = η + Δ, then E[η'] = Δ ≠ 0  ✗ VIOLATES CONSTRAINT
∴ Cannot shift without violating constraint  ✓ IDENTIFIED
```

### Derived Weights Consistency Test

**Before fix**:
```
Layer 2: logit(ρ) = κ + λη + δ_fam
Derived: w_L = σ(κ + λ)  ✗ INCONSISTENT (missing δ_fam)
```

**After fix**:
```
Layer 2: logit(ρ) = κ + λη
Derived: w_L = σ(κ + λ) = σ(κ + λ·1) = Pr(F=1|η=1)  ✓ CONSISTENT
```

---

## Compilation Status

✅ Clean compilation (lualatex + biber)
✅ 31 pages, 381 KB
✅ No errors or warnings

---

## Files Modified

**main.tex only**:
- Line 171: Removed legacy equation, added location constraint to interpretation
- Line 197: Fixed Table 2 caption
- Lines 432-438: Fixed η distribution and added all missing priors
- Lines 446: Removed δ_fam from Layer 2 equation
- Lines 452-453: Removed δ_fam prior
- Lines 468-476: Updated identifiability paragraph (3 → 4 mechanisms)
- Line 485: Updated multilevel explanation

---

## Summary of Mathematical Corrections

| Issue | Status | Fix |
|-------|--------|-----|
| w_L · η product in §3.1 | ✅ FIXED | Removed legacy paragraph |
| δ_fam inconsistency | ✅ FIXED | Removed from Layer 2 |
| Table caption mismatch | ✅ FIXED | Removed false interval claim |
| Location indeterminacy | ✅ FIXED | E[η]=0 + all priors specified |

**Identifiability**: Now complete with 4 mechanisms
**Type safety**: w_L consistently derived random variable
**Anti-circularity**: Diagnostics never reference forms
**HPC preservation**: No sum-to-1 constraint maintained

---

## Next Step

Ready for Codex/Kimi to re-review or to rerun the original formalism review agent.
