# Expected Outcomes: Formalism Re-Review

**Date**: 2025-11-08
**Status**: Re-review in progress

---

## Original Issues (from formalism-review-wl-agent-output.md)

### 1. Identifiability Crisis ❌
**Original problem**: One equation, two unknowns (w_L and η_c) - infinite solutions

**Fix applied**:
- Added E[η]=0 constraint (location anchor)
- Kept Var(η)=1 constraint (scale anchor)
- Two-layer model provides independent measurements
- Added monotonicity λ≥0

**Expected outcome**: ✅ RESOLVED

---

### 2. Type Safety Disaster ❌
**Original problem**: w_L defined as deterministic but treated as random parameter

**Fix applied**:
- w_L now consistently a derived random variable
- w_L = σ(κ + λ) where κ,λ have priors
- Removed conflicting "deterministic function" language from §3.1
- Clear throughout: w_L is posterior-derived

**Expected outcome**: ✅ RESOLVED

---

### 3. No Generative Model ❌
**Original problem**: Missing priors, joint distribution, simulation framework

**Fix applied**:
- ALL priors specified:
  - Layer 1: α_i ~ N(0,2), β_i ~ N(0,1), η ~ N(0,1)
  - Random effects: u_fam ~ N(0,σ_fam), v_coder ~ N(0,σ_coder)
  - Hyperpriors: σ_fam, σ_coder ~ Exp(1)
  - Layer 2: κ ~ N(μ_κ,1.5), λ ~ HalfNormal(0,1)
- Complete joint distribution defined
- Posterior predictive validation mentioned

**Expected outcome**: ✅ RESOLVED

---

### 4. Arbitrary Thresholds ❌
**Original problem**: 90%, 60%, 30% cutoffs unjustified

**Fix applied**:
- Marked as "provisional" throughout §3.1
- Changed "1.0: Canonical" → "Provisional 1.0: Canonical"
- Added posterior decision rules: Pr(w_L ≥ 0.90 | data) ≥ 0.80
- Referenced calibration via cross-validation

**Expected outcome**: ✅ RESOLVED

---

## Additional Improvements Made

### 5. Anti-Circularity Formalization
- Removed legacy equation where diagnostics depended on w_L
- Layer 1 now explicitly: diagnostics depend ONLY on η
- Independence condition: (F ⊥ d | η)

### 6. Mathematical Consistency
- Removed δ_fam from Layer 2 (was inconsistent with derived weights)
- Now: w_L = σ(κ+λ) exactly equals Pr(F|η=1) as claimed

### 7. Table 2 Caption
- Fixed false claim about "credible intervals"
- Now accurately describes content (w_L with q_L in parentheses)

---

## What Review Should Find

### Gelman (Statistical Rigor)
**Before**: "You can't estimate what you haven't identified"
**After**: Should find identifiability complete via 4 constraints

**Expected verdict**: ✅ Statistically sound

### Pearl (Causality)
**Before**: "Causal language without causal machinery"
**After**: Should find:
- Two-layer model with clear causal paths (η → F)
- Anti-circularity formalized
- Intervention interpretation clear

**Expected verdict**: ✅ Causally coherent (though could still ask for deeper DAG)

### Gazdar (Computational Precision)
**Before**: "Type theory confused - pick one"
**After**: Should find w_L consistently a derived random variable

**Expected verdict**: ✅ Type safe

### Semanticist (Logical Clarity)
**Before**: "Intension vs extension unclear"
**After**: Should find:
- w_L clearly defined as conditional probability
- Quantifiers explicit (for all languages L, comparanda c, forms φ)
- Compositionality clear (from κ,λ to w_L via logistic)

**Expected verdict**: ✅ Logically clear

---

## If Review Finds Remaining Issues

Possible remaining concerns (not critical, but worth addressing):

1. **Empirical validation**: Still missing actual data/simulations
2. **Prior sensitivity**: Should do sensitivity analysis
3. **Computational tractability**: MCMC algorithm not specified
4. **Cross-validation protocol**: Mentioned but not detailed

These would be "nice to have" not "must have" for theoretical soundness.

---

## Timeline

- Re-review started: 2025-11-08 ~16:45
- Expected completion: ~5-10 minutes
- Review file: `reviews/formalism-review-RERUN-kimi.md`
