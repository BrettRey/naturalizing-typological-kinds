# Formalism Review: Weight Function w_L

**Agent**: FormalismReviewAgent (Gelman + Pearl + Gazdar + Semanticist)  
**Section**: 3.1 (Decision procedures for weight assignment)  
**Date**: 2025-11-07  
**Status**: Review Complete

---

## Executive Summary

**Overall Assessment**: **PROBLEMATIC** - The formalism has fundamental issues that must be addressed before it can support any claims about naturalization.

**Critical Issues**:
1. **Identifiability crisis**: One equation, two unknowns (w_L and η_c) - model is not identified
2. **Type safety disaster**: w_L defined as deterministic function but treated as random parameter
3. **No generative model**: Missing priors, joint distribution, and simulation framework
4. **Arbitrary thresholds**: 90%, 60%, 30% cutoffs are post-hoc and unjustified

**Bottom Line**: The intuition behind w_L is good, but the formalism is fatally under-specified from statistical, causal, computational, and logical perspectives.

---

## Key Findings by Expert

### Andrew Gelman (Statistical Rigor)
- **Verdict**: "This is wishful thinking, not statistics. You can't estimate what you haven't identified."
- **Critical issue**: No identifiability proof - infinite solutions exist
- **Missing**: Complete generative model with priors, posterior checks, model comparison
- **Problem**: Arbitrary thresholds (90%, 60%, 30%) invite p-hacking

### Judea Pearl (Causality)
- **Verdict**: "You're using causal language without causal machinery."
- **Critical issue**: Claims like "φ realizes c" are causal but no DAG or identification strategy
- **Missing**: Clear statement of whether w_L is causal or descriptive
- **Problem**: No intervention defined - what does "changing w_L" mean?

### Gerald Gazdar (Computational Precision)
- **Verdict**: "The type theory is confused. Function vs. random variable - pick one."
- **Critical issue**: Type inconsistency - deterministic function vs. random parameter
- **Missing**: Algorithm specification, complexity analysis, computability proof
- **Problem**: Not clear if w_L can be efficiently computed from corpus data

### Formal Semanticist (Logical Clarity)
- **Verdict**: "The logical structure is murky. Intension vs. extension not clarified."
- **Critical issue**: Ambiguous quantifiers and modal operators
- **Missing**: Explicit specification of what w_L is a property of (language vs. analyst knowledge)
- **Problem**: Compositionality unclear - can w_L be built from simpler functions?

---

## Most Critical Problem: Identifiability

Your measurement model:
```
logit(p(d_i = 1 | η_c, L)) = α_i + β_i · w_L(c, φ) · η_c
```

**Problem**: Multiply w_L by 2 and divide η_c by 2 → identical likelihood. **Infinite solutions exist.**

**Fixes** (choose one):
1. **Constraint**: ∑_φ w_L(c,φ) = 1 (makes w_L a probability distribution)
2. **Anchor**: Fix w_L = 1.0 for one canonical form per comparandum
3. **Multiple measurements**: Independent diagnostics that give separate equations

**Without this**: No statistical inference is possible. Any "estimates" are meaningless.

---

## Immediate Action Items

### Must Fix (Before Submission):

1. **Resolve identifiability** - Add constraint or anchor
2. **Clarify types** - Decide: deterministic function OR random variable
3. **Justify thresholds** - Derive from data or acknowledge as provisional
4. **Complete generative model** - Specify all priors and joint distribution
5. **State causal status** - Is w_L causal or descriptive? Be explicit.

### Should Fix (For Credibility):

1. **Provide pseudocode** for computing w_L from corpus data
2. **Add identifiability proof** or simulation study
3. **Clarify quantifiers** - Explicit ∀ and ∃ statements
4. **Define modal status** - Is w_L necessary, possible, or contingent?

---

## Questions for You

1. **Is w_L a probability distribution?** If so, why not constrain it to sum to 1?

2. **Can you write the complete joint distribution** p(d, w_L, η_c, α_i, β_i) with all priors?

3. **Have you tested identifiability via simulation?** Can you recover true w_L?

4. **Where did 90%, 60%, 30% come from?** Data-driven, theoretical, or arbitrary?

5. **Is w_L causal or descriptive?** If causal, where's the DAG?

---

## Next Steps

**Option 1**: Address these issues in current draft (requires substantial revision)

**Option 2**: Acknowledge these as limitations and frame w_L as "provisional specification" for future empirical work

**Option 3**: Simplify formalism - remove estimation language, treat w_L as deterministic analyst-assigned score (acknowledges subjectivity but avoids statistical overreach)

---

## Agent Confidence

**High confidence** in identifiability and type safety criticisms - these are mathematically provable issues.

**Medium confidence** in causal interpretation - depends on your intended meaning of "realizes".

**High confidence** in computational/logical issues - these follow from formal definitions.

---

*Review completed by FormalismReviewAgent embodying Gelman, Pearl, Gazdar, and formal semanticist expertise.*
