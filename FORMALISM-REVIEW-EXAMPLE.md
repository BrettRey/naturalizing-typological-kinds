# Example Formalism Review: Weight Function w_L

**Section**: 3.1 (Decision procedures for weight assignment)  
**Formalism**: Weight function w_L : C × Forms_L → [0,1]  
**Overall Assessment**: Problematic - needs significant clarification

---

## Strengths

- The distinction between observational and analyst weights is conceptually sound
- The four-point ordinal scale provides practical guidance for coders
- The suggestion to treat w_L as an estimated parameter is methodologically sophisticated

## Concerns (in order of severity)

### 1. Critical: Identifiability Crisis

**Gelman says**: "How can we possibly estimate w_L from data? This is a fundamental identifiability problem."

You've defined w_L(c,φ) as "how strongly form φ realizes c in language L." But this is a theoretical quantity, not an observable. In your measurement model (Section 7), you propose:

```
logit(π_i) = α_i + β_i · w_L(c,φ) · η_c
```

This is circular: w_L appears as a parameter in the model, but it's also what you're trying to measure. You have one equation with two unknowns (w_L and η_c). Without additional constraints, this is **not identifiable**.

**Pearl adds**: "Is w_L a causal parameter or a descriptive statistic? If it's causal, where's your identification strategy?"

If w_L represents a causal effect of comparandum c on form φ, you need:
- An intervention: "What if we change c?"
- An identification strategy: Randomization, natural experiment, or strong assumptions
- A causal graph showing confounders

You haven't provided any of these.

### 2. Major: Type Safety Issues

**Gazdar says**: "What's the type of w_L? You've written it as a function to [0,1], but you treat it as both a deterministic mapping and a random parameter."

You define:
```
w_L : C × Forms_L → [0,1]  (deterministic function)
```

But then suggest:
```
w_L as a parameter to be estimated  (random variable)
```

These are **different types**. A function is a deterministic mapping. A parameter is a random variable with a distribution. You can't have it both ways without clarification.

**Semanticist adds**: "Is w_L intensional or extensional? Are we measuring a property of the language or our knowledge about the language?"

If w_L is a property of the language (extensional), it should be deterministic. If it's about our uncertainty (intensional), it should be a random variable. The paper waffles on this.

### 3. Major: No Generative Model

**Gelman insists**: "Where's the generative model? How would you simulate data from this?"

A proper statistical model needs:
1. **Data generating process**: How do we get from parameters to observations?
2. **Likelihood**: p(data | parameters)
3. **Prior**: p(parameters)
4. **Posterior**: p(parameters | data) ∝ p(data | parameters) p(parameters)

You've written:
```
d_i ~ Bernoulli(π_i)
logit(π_i) = α_i + β_i · w_L(c,φ) · η_c
```

But what's the **joint distribution**?
- Are the d_i independent given η_c and w_L?
- What's p(w_L | η_c)?
- What's p(η_c)?

Without a complete generative model, you can't:
- Do posterior inference
- Check model fit
- Compare models
- Simulate data

### 4. Moderate: Arbitrary Thresholds

**Gelman notes**: "Your thresholds (0.3, 0.6, 0.8) are completely arbitrary. Where do they come from?"

You write:
- w_L = 1.0 if φ appears in ≥90% of contexts
- w_L = 0.7 if φ appears in 60%-90% of contexts
- etc.

These cutoffs are **post-hoc** and **unjustified**. Why 90% and not 85%? Why 60% and not 65%?

This is **p-hacking** waiting to happen. Researchers will choose thresholds that make their categories look naturalized.

**Recommendation**: Either:
- Derive thresholds from data (e.g., via mixture modeling)
- Treat them as hyperparameters with priors
- Use continuous weights without discretization

### 5. Minor: Notation Inconsistency

**Gazdar points out**: "You use w_L(c,φ) > 0 and w_L(c,φ) > ε interchangeably."

You define support: `w_L(c,φ) > 0 ⇒ φ ∈ f_L(c)`

But then use: `w_L(c,φ) > ε` where ε = 0.3

Is the threshold 0 or 0.3? Make up your mind.

---

## Specific Issues by Expert

### Gelman's Statistical Concerns

1. **No prior specified**: What is p(w_L)? p(η_c)?
2. **No posterior checks**: How do you know the model fits?
3. **No model comparison**: Why this model and not alternatives?
4. **No uncertainty quantification**: Where are the credible intervals?
5. **Identifiability**: Can we uniquely determine w_L from data?

**Fix**: Specify a proper hierarchical Bayesian model:
```
η_c ~ Normal(0, σ_η)
w_L ~ Beta(α, β)  # Or some other prior
logit(π_i) = α_i + β_i * w_L * η_c
d_i ~ Bernoulli(π_i)
```

Then check identifiability via simulation.

### Pearl's Causal Concerns

1. **Causal vs. descriptive**: Is w_L causal or associative?
2. **No DAG**: Where's the causal graph?
3. **No identification**: How do you identify causal effects?
4. **Confounders**: What else affects both c and φ?

**Fix**: If w_L is causal, draw the DAG and show it's identifiable. If it's descriptive, stop using causal language.

### Gazdar's Computational Concerns

1. **Type inconsistency**: Function vs. random variable
2. **Computability**: Can we compute w_L efficiently?
3. **Complexity**: What's the computational complexity?
4. **Implementation**: Where's the actual algorithm?

**Fix**: Decide if w_L is deterministic or random. If random, specify its distribution. Provide pseudocode for computation.

### Semanticist's Logical Concerns

1. **Intension/extension**: Is w_L about language or meta-language?
2. **Compositionality**: Can we build w_L from simpler functions?
3. **Quantifiers**: Are we quantifying over languages, comparanda, or forms?
4. **Modal status**: Is this necessary or contingent?

**Fix**: Clarify the modal and quantificational structure. Use explicit quantifiers: ∀L∈Languages, ∀c∈C, etc.

---

## Recommendations

### Immediate Fixes (Before Submission)

1. **Resolve identifiability**: Add constraint that ∑_φ w_L(c,φ) = 1 for each c, L (makes it identifiable as a probability distribution)

2. **Clarify types**: Decide if w_L is deterministic or random. If deterministic, remove estimation language. If random, specify its distribution.

3. **Justify thresholds**: Either derive from data or acknowledge they're provisional and need calibration

4. **Add generative model**: Specify the complete joint distribution p(d, w_L, η_c)

5. **Be explicit about causality**: State whether w_L is causal or descriptive

### Deeper Fixes (For Next Draft)

1. **Full Bayesian specification**: Priors on all parameters, hierarchical structure
2. **Identifiability proofs**: Show parameters are uniquely recoverable
3. **Causal DAG**: If w_L is causal, draw the graph and prove identification
4. **Computational analysis**: Complexity bounds, algorithm specification
5. **Simulation study**: Show you can recover w_L from simulated data

---

## Questions for Author

1. **Is w_L meant to be a probability distribution?** If so, constrain it to sum to 1.

2. **Can you write down the complete joint distribution** p(d, w_L, η_c, α_i, β_i)?

3. **Have you tested identifiability via simulation?** Can you recover true w_L from simulated data?

4. **Is w_L causal or descriptive?** If causal, where's the DAG?

5. **Where did the thresholds (90%, 60%, 30%) come from?** Are they data-driven or arbitrary?

6. **Can you provide pseudocode** for computing w_L from corpus data?

---

## Bottom Line

**Gelman**: "This formalism has potential, but it's currently under-specified from a statistical perspective. Fix the identifiability and add a proper generative model."

**Pearl**: "You're making causal claims without causal machinery. Either add the DAG or stop using causal language."

**Gazdar**: "The type theory is confused. Decide if w_L is deterministic or random, and be consistent."

**Semanticist**: "The logical structure is murky. Clarify quantifiers and modal status."

**Overall**: The intuition behind w_L is good, but the formalism needs significant clarification before it can support the claims you're making about naturalization.
