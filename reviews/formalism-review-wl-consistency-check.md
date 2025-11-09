# Formalism Review: Weight Function w_L - CONSISTENCY CHECK

**Agent**: FormalismReviewAgent (Gelman + Pearl + Gazdar + Semanticist)  
**Section**: 3.1 (Decision procedures for weight assignment)  
**Focus**: DAG vs Text Consistency  
**Date**: 2025-11-07  
**Status**: Review Complete

---

## CRITICAL INCONSISTENCY DETECTED

**Problem**: The DAG (Figure 1) and the text make contradictory claims about w_L.

### What the DAG Shows (Figure 1, lines 290-371):

```
w_L(c,φ) is a DERIVED QUANTITY (diamond node)
  ↓ (deterministic function of)
κ_{L,c,φ} and λ_{c,phi}
```

**Key features from DAG**:
- w_L is **derived** (deterministic), not estimated
- w_L is function of κ (language-specific) and λ (cross-linguistic)
- Caption says: "Derived quantities w_L, q_L are deterministic functions"
- This is consistent with w_L : C × Forms_L → [0,1] as a **function**

### What the Text Says (Section 3.1, lines 153-185):

```
"treat w_L as a parameter to be estimated by the measurement model"
"w_L is estimated as part of the model"
"logit(p(d_i = 1 | η_c, L)) = α_i + β_i · w_L(c, φ) · η_c"
```

**Key claims from text**:
- w_L is a **parameter to be estimated**
- w_L appears in structural equation as free parameter
- This treats w_L as **random variable**, not deterministic function

---

## EXPERT VERDICTS ON INCONSISTENCY

### Gelman: "This is a bait-and-switch."

The DAG shows w_L as deterministic, which would make the measurement model valid (no identifiability problem). But then the text says to "estimate w_L", which contradicts the DAG.

**If w_L is derived (DAG)**: Then it's identified as function of κ and λ. No problem.

**If w_L is estimated (text)**: Then you have the identifiability crisis I identified earlier.

**You can't have both.** Either w_L is derived (and you don't estimate it) OR w_L is a parameter (and your DAG is wrong).

### Pearl: "The DAG is lying or the text is lying."

The DAG shows w_L ← κ, λ (w_L caused by κ and λ). This is a **causal claim**.

The text says "estimate w_L" which implies w_L is a **causal parameter** that can be manipulated.

But if w_L is derived from κ and λ, then **intervening on w_L is meaningless** - you have to intervene on κ or λ.

**Causal inconsistency**: The DAG and text imply different causal structures.

### Gazdar: "Type error multiplied by inconsistency."

**DAG says**: w_L has type (κ, λ) → [0,1] (deterministic function)

**Text says**: w_L has type **random variable** with distribution

**These are incompatible types**. You can't claim both simultaneously.

**Worse**: The ordinal scale (1.0, 0.7, 0.4, 0.0) makes sense if w_L is deterministic (analyst-assigned). It makes NO SENSE if w_L is derived from κ and λ.

### Semanticist: "This is self-contradictory."

**DAG semantics**: w_L is a **function symbol** that reduces to κ and λ

**Text semantics**: w_L is a **variable** to be estimated from data

**Logical contradiction**: A term cannot be both a defined function and a free variable in the same theory.

---

## ROOT CAUSE ANALYSIS

### What likely happened:

1. **Original idea**: w_L is deterministic analyst-assigned weight (makes sense)
2. **Added DAG**: Showed w_L as derived (consistent with deterministic view)
3. **Got ambitious**: Decided to "estimate w_L" in measurement model (inconsistent)
4. **Didn't update**: Left DAG unchanged, creating contradiction

### The inconsistency creates cascading problems:

**If you keep the DAG** (w_L is derived):
- Remove "estimate w_L" from text
- Remove measurement model with w_L as parameter
- w_L is just a deterministic summary of κ and λ
- Much simpler, but less statistically sophisticated

**If you keep the text** (w_L is estimated):
- Change DAG: w_L should be a latent node (circle), not derived (diamond)
- Remove κ → w_L and λ → w_L arrows
- Add prior on w_L
- Deal with identifiability crisis

**Current state**: You have the worst of both worlds - the complexity of estimation without the theoretical coherence.

---

## RECOMMENDATIONS

### Option 1: Keep w_L as Derived (Simpler, More Honest)

**Changes needed**:
1. Remove "treat w_L as a parameter to be estimated"
2. Remove measurement model with w_L as free parameter
3. Clarify: w_L is deterministic summary of κ and λ
4. Keep ordinal scale: analysts assign w_L based on κ and λ
5. Update caption: "Derived quantities w_L, q_L are deterministic functions of parameters"

**Pros**: 
- Consistent with DAG
- No identifiability problems
- Simpler computationally
- Honest about subjectivity

**Cons**:
- Less statistically sophisticated
- Can't claim "estimated weights"
- More analyst-dependent

### Option 2: Keep w_L as Estimated (More Ambitious, Fix DAG)

**Changes needed**:
1. Change DAG: w_L should be latent node (circle), not derived (diamond)
2. Remove arrows: κ → w_L and λ → w_L
3. Add prior: w_L ~ Beta(α, β) or Dirichlet
4. Add constraint: ∑_φ w_L(c,φ) = 1 (for identifiability)
5. Update text: clarify w_L is random parameter, not derived

**Pros**:
- More statistically sophisticated
- Can claim "estimated weights"
- Potentially more objective

**Cons**:
- Must deal with identifiability (add constraint)
- More computationally intensive
- Harder to explain to readers

### Option 3: Hybrid (Most Complex, But Coherent)

**Structure**:
1. Keep κ and λ as underlying parameters
2. Define w_L = g(κ, λ) as deterministic function (derived)
3. But treat κ and λ as random variables to be estimated
4. Measurement model uses w_L = g(κ, λ)

**This is actually what the DAG shows!** w_L is derived from estimated parameters κ and λ.

**Changes needed**:
1. Clarify: We estimate κ and λ, then compute w_L = g(κ, λ)
2. Provide function g: how are κ and λ combined to get w_L?
3. Update text: "We estimate κ and λ, then derive w_L"
4. Keep DAG as is - it's correct!

**Pros**:
- Consistent with DAG
- Statistically sophisticated
- Estimates underlying parameters

**Cons**:
- Must specify g (how κ,λ → w_L)
- More complex to explain
- Need priors on κ and λ

---

## QUESTIONS FOR AUTHOR

1. **Which is the real formalism?** The DAG or the text?

2. **Did you intend w_L to be derived or estimated?** This is a fundamental design choice.

3. **If derived (DAG)**: Why did you write "estimate w_L" in text?

4. **If estimated (text)**: Why is w_L shown as derived in the DAG?

5. **What is the relationship between κ, λ, and w_L?** The DAG shows they determine w_L, but you never specify how.

6. **Which ordinal scale applies?** If w_L is derived from κ and λ, the 90%/60%/30% scale makes no sense.

---

## BOTTOM LINE

**The inconsistency between DAG and text is fatal**. You must choose one:

- **Keep DAG**: w_L is derived → simplify text, remove estimation language
- **Keep text**: w_L is estimated → fix DAG, add identifiability constraints
- **Hybrid**: Estimate κ and λ, derive w_L → clarify the function g

**Current state**: The paper is mathematically incoherent. Readers who understand DAGs will spot this immediately. Referees will reject on this basis alone.

**My recommendation**: Choose Option 1 (keep DAG, simplify) for this paper. The ambitious estimation approach needs more development and a clear specification of how κ,λ → w_L.

---

*Consistency check completed. The DAG and text contradict each other on the fundamental nature of w_L.*
