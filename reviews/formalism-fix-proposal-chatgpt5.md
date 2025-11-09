## 1. Executive Decision
```
Recommendation: Option 3 (multiple-measurement model with an anchored latent scale)
Rationale: The three-level ontology already separates behavioural diagnostics (Level I) from morphosyntactic realizations (Level III). By first identifying η_c from diagnostics alone and then linking forms via a second measurement layer, we (i) keep the anti-circular workflow intact, (ii) let multiple exponents reinforce the same comparandum (HPC redundancy), and (iii) fix the scale ambiguity that caused the identifiability crisis.
```

## 2. Revised Formalism Specification
```
w_L : (𝒞 × Φ_L) → [0,1], w_L(c,φ) = Pr(F_{L,c,φ}=1 | η_{L,c}=1)
```
- **Domain/codomain.** 𝒞 is the inventory of Level‑II comparanda; Φ_L is the set of Level‑III forms in language L. The codomain is the unit interval because weights are conditional probabilities.
- **Auxiliary quantity.** q_L(c,φ) = Pr(F_{L,c,φ}=1 | η_{L,c}=0) captures false positives; both are reported in tables.

### Generative constraints
1. **Latent comparandum strength.** η_{L,c} ∼ Normal(μ_{fam(c)}, 1). Fixing Var(η)=1 anchors the latent scale and breaks the w·η symmetry.
2. **Diagnostic layer (Level I evidence only).**
   ```
   logit Pr(d_{L,i}=1 | η_{L,c}) = α_i + β_i η_{L,c} + u_{fam(i)} + v_{coder(i)}
   ```
   Diagnostics never reference φ, preserving anti-circularity.
3. **Realization layer (forms conditioned on η).**
   ```
   logit Pr(F_{L,c,φ,t}=1 | η_{L,c}) = κ_{L,c,φ} + λ_{c,φ} η_{L,c} + δ_{fam(φ)}
   λ_{c,φ} ≥ 0
   ```
   Tokens t can be corpus attestations, elicited sentences, or experimental trials. The non-negativity constraint enforces monotonicity: stronger comparanda cannot lower form probability.
4. **Weight as derived random variable.**
   ```
   w_L(c,φ) = σ(κ_{L,c,φ} + λ_{c,φ})  q_L(c,φ) = σ(κ_{L,c,φ})
   ```
   σ is the logistic function. Because κ and λ are estimated with priors (e.g., κ ∼ Normal(0,1.5), λ ∼ HalfNormal(0,1)), w_L inherits a posterior distribution; the matrix stores E[w_L] ± 80% CI.

### Estimation workflow
1. Fit the diagnostic layer to obtain the posterior p(η_{L,c} | d). This is identical to Stage 1 in Fig. 2 but now explicitly fixes the variance to 1.
2. Condition on draws of η_{L,c} while fitting the realization layer, yielding joint samples of κ, λ, and thus w_L and q_L.
3. Report analyst priors as weakly-informative hyperparameters; analyst-coded weights can still initialize κ, λ (as pseudo-observations) but no longer appear as fixed numbers in the likelihood.

### Identifiability argument
- Fixing Var(η)=1 and restricting λ ≥ 0 removes the continuous scaling symmetry (k·w, η/k). Any alternative scaling would violate either the variance constraint or the monotonicity constraint; therefore the posterior is proper.
- Separate diagnostic and realization equations provide two conditionally independent evidence sources, satisfying the “multiple measurement” criterion from the review.
- Because w_L is defined as a deterministic function of (κ, λ), its type is unambiguous: it is a derived random variable with a well-defined posterior, not an analyst-chosen constant.

### Threshold policy
- Retain the interpretive labels (canonical / strong secondary / weak correlate) but tie them to posterior decision rules:
  - Canonical if Pr(w_L ≥ 0.90 and precision ≥ 0.80 | data) ≥ 0.80
  - Strong secondary if Pr(0.60 ≤ w_L < 0.90 | data) ≥ 0.80
  - Weak correlate if Pr(0.30 ≤ w_L < 0.60 | data) ≥ 0.80
- Report these as categorical summaries in prose; tables keep continuous w_L values plus uncertainty.
- Note explicitly that thresholds remain provisional until calibrated on held-out coding rounds; reference planned cross-validation study.

### Causal status
- The DAG already posits η_{L,c} → F_{L,c,φ}. Under this proposal, “φ realizes c” is interpreted as a probabilistic causal claim: intervening on η_{L,c} (holding diagnostics constant) would change the likelihood that φ is selected. We do not intervene directly on w_L; it summarizes the structural coefficients that mediate that causal path.

## 3. Section-by-Section Changes
```
§3.1 Decision procedures:
- Replace the paragraph that mixes analyst vs. estimated weights with a definition of w_L as a conditional probability derived from the realization layer.
- Clarify that analyst weights now serve as priors on κ,λ (append formula for translating the four-point scale into Normal means).
- Add the posterior decision rules for the canonical/secondary/weak labels and note that continuous w_L values (with CIs) populate M_L.

§4.2 Coding protocol:
- Insert a two-stage workflow: (i) diagnose η_{L,c} using behavioural tests only; (ii) collect form-token counts conditioned on those diagnoses for the realization layer.
- Require coders to log both positive (F=1) and negative (F=0) tokens so that q_L is estimable.

Table 2 (lines 198–223):
- Replace illustrative numbers with posterior means of w_L and q_L plus ±0.1 credible intervals.
- Add a footnote: “Weights are conditional probabilities w_L(c,φ)=Pr(φ | c) estimated from the hierarchical model; rows need not sum to 1.”
- Include a column with the categorical label (canonical / strong / weak) computed from the posterior rule.

§6.1 Probabilistic formalization:
- Swap the single structural equation for the two-layer system shown above; provide the full joint distribution and priors.
- Explicitly state η_{L,c} ∼ Normal(μ_family,1) and λ_{c,φ} ≥ 0.
- Describe w_L and q_L as posterior-derived summaries; remove language implying analyst-determined weights inside the likelihood.

§7.1 Measurement derivation:
- Emphasize that identifiability follows from (i) variance anchoring, (ii) monotonic λ constraints, and (iii) independent diagnostic/form evidence.
- Update the narrative around Fig. 2 to mention that Stage 2 now conditions on the η samples from Stage 1.

§9 Predictions & §10 Objections:
- Recompute prediction checks using posterior draws of w_L; document that naturalization claims require high posterior mass above canonical thresholds in at least two unrelated families.
- Acknowledge that anti-circularity is preserved because diagnostics remain φ-free; add a brief rebuttal to potential objections about the probabilistic causal reading.
```

## 4. Theoretical Implications
- **Naturalization tests.** Because w_L is now a probability with uncertainty, the “high weights across diverse families” criterion becomes: ∀ families G, Pr(w_{G} ≥ 0.9 | data) > τ. This strengthens falsifiability: failure in any held-out family immediately lowers posterior support.
- **Anti-circularity.** Separating diagnostic and realization layers formalizes Rule B; Level I evidence flows into η before any reference to morphosyntax, so no circular definitions survive.
- **HPC integrity.** Multiple forms can each achieve high w_L because no simplex constraint forces trade-offs; the homeostatic intuition of redundant cues is preserved while still quantifying their reliability.
- **Downstream sections.** Predictions (§9) now draw from posterior predictive simulations that include uncertainty in both η and w; Objections (§10) can cite the identifiability proof sketch and simulation plan (fit-to-recover study using synthetic data). The measurement section (§7.1) gains a clear causal story aligned with the existing DAG, deflecting the Pearl critique.
- **Type safety.** w_L is explicitly a derived random variable (posterior samples stored in M_L), removing the deterministic/random ambiguity and enabling consistent use across the paper.
