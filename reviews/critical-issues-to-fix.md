# Critical Issues from Codex Review

**Date**: 2025-11-08
**Source**: reviews/implementation-review-codex.md

---

## Issue 1: Legacy Equation in §3.1 (lines 173-178) - BLOCKER

**Problem**: Section still contains old single-layer equation:
```latex
logit(p(d_i = 1 | η_c, L)) = α_i + β_i · w_L(c,φ) · η_c
```

This:
- Reintroduces identifiability problem (w_L · η product)
- Violates anti-circularity (diagnostics reference forms via w_L)
- Contradicts the new two-layer model in §6.1

**Fix**: Remove or rewrite this paragraph to align with two-layer architecture

---

## Issue 2: Missing δ_fam in Derived Weights (lines 465-470) - BLOCKER

**Problem**: Layer 2 equation includes genealogical effect:
```latex
logit(ρ) = κ_{L,c,φ} + λ_{c,φ} η_{L,c} + δ_fam(φ)
```

But derived weights drop it:
```latex
w_L(c,φ) = σ(κ_{L,c,φ} + λ_{c,φ})
q_L(c,φ) = σ(κ_{L,c,φ})
```

This makes w_L ≠ Pr(F=1|η=1) as claimed.

**Fix Options**:
A) Include δ_fam in transformation (language/family-specific weights)
B) Remove δ_fam from Layer 2 equation (simpler, weights are universal)
C) Marginalize over δ_fam distribution (population-average weights)

**Recommendation**: Option B - Remove δ_fam from Layer 2 for now

---

## Issue 3: Table 2 Caption Mismatch (lines 203-214) - MINOR

**Problem**: Caption says "posterior means with 80% credible intervals" but table shows:
```
w_Eng (q)
0.98 (0.02)
```

The parentheses are q_L (false positives), not intervals.

**Fix**: Rewrite caption to match actual content:
"Values show posterior mean weights w_L with false-positive rates q_L in parentheses."

---

## Issue 4: Location Indeterminacy (lines 431-481) - BLOCKER

**Problem**: Var(η)=1 fixes scale but not location. Translation symmetry remains:
- Shift all η by Δ
- Shift all κ by -λΔ
- Likelihood unchanged

No priors specified for: α_i, β_i, μ_family, u_fam, v_coder

**Fix**: Add location constraint:
```latex
μ_family ~ Normal(0, σ_μ)  OR  μ_family = 0 (fixed)
```

And specify missing priors.

---

## Severity Assessment

- **Issue 1**: BLOCKER - Mathematical contradiction
- **Issue 2**: BLOCKER - Formula doesn't match interpretation
- **Issue 3**: MINOR - Caption/content mismatch
- **Issue 4**: BLOCKER - Identifiability still incomplete

---

## Fix Priority

1. **First**: Remove legacy equation (Issue 1)
2. **Second**: Fix δ_fam inconsistency (Issue 2)
3. **Third**: Add location constraint (Issue 4)
4. **Fourth**: Fix table caption (Issue 3)

---

## Questions for User

1. Should w_L be language-specific (include δ_fam) or universal (exclude it)?
2. Should μ_family be fixed at 0 or have a prior?
3. Do we need to rerun full formalism review after fixes?
