# Final Implementation Plan: Hybrid Approach (Codex Foundation)

**Date**: 2025-11-08
**Status**: Ready for implementation
**Approach**: Codex's two-layer model as foundation + Kimi's best clarifications

---

## Core Decision: Codex Foundation

**Why Codex wins**:
1. **Preserves HPC independence** - multiple forms can each have w_L ≈ 1.0 without competition
2. **Causal interpretation** - aligns with existing DAG, stronger explanatory power
3. **Richer characterization** - w_L + q_L captures both true positives and false positives
4. **Two-layer structure** - formalizes anti-circularity workflow already in the paper

**Elements from Kimi to incorporate**:
1. **"Provisional thresholds" language** - clearer than Codex's posterior decision rules for initial presentation
2. **Explicit competition rebuttal** - Kimi's theoretical implications section addresses this well
3. **Entropy measures** - nice quantification of redundancy (1/Σw²)

---

## Revised Formalism Specification (Hybrid)

### Core Definition (from Codex)

```latex
w_L : (𝒞 × Φ_L) → [0,1]
w_L(c,φ) = Pr(F_{L,c,φ}=1 | η_{L,c}=1)
```

**Interpretation**: w_L is the conditional probability that form φ appears given that comparandum c is at maximum strength. This is a causal relationship: interventions on η would change the probability of F.

**Auxiliary quantity**:
```latex
q_L(c,φ) = Pr(F_{L,c,φ}=1 | η_{L,c}=0)
```
Captures false positive rate (form appears when comparandum is absent).

### Generative Model (from Codex)

```latex
1. Latent comparandum strength: η_{L,c} ~ Normal(μ_{fam(c)}, 1)
   [Var(η)=1 anchors the scale]

2. Diagnostic layer (Level I):
   logit Pr(d_{L,i}=1 | η_{L,c}) = α_i + β_i η_{L,c} + u_{fam(i)} + v_{coder(i)}
   [Diagnostics never reference φ - preserves anti-circularity]

3. Realization layer (Level III conditioned on η):
   logit Pr(F_{L,c,φ,t}=1 | η_{L,c}) = κ_{L,c,φ} + λ_{c,φ} η_{L,c} + δ_{fam(φ)}
   with λ_{c,φ} ≥ 0 (monotonicity)

4. Derived weights:
   w_L(c,φ) = σ(κ_{L,c,φ} + λ_{c,φ})
   q_L(c,φ) = σ(κ_{L,c,φ})
```

### Identifiability (from Codex)

Three mechanisms ensure unique solution:
1. **Variance anchoring**: Var(η)=1 breaks w·η scaling symmetry
2. **Monotonicity constraint**: λ ≥ 0 prevents sign ambiguity
3. **Independent measurements**: Diagnostic and realization layers provide separate equations

### Threshold Policy (hybrid: Codex structure + Kimi language)

**Initial assignment** (§3.1):
```latex
Analysts assign provisional weights w_L^{prov} based on sensitivity/precision:
- Provisional 1.0: ≥90% sensitivity, ≥80% precision (canonical exponent)
- Provisional 0.7: 60-90% sensitivity, 50-80% precision (strong secondary)
- Provisional 0.4: 30-60% sensitivity, 20-50% precision (weak correlate)
```

These serve as **starting points** that initialize priors on κ and λ.

**Posterior validation** (§6.1, §7.1):
```latex
Categorical labels assigned via posterior decision rules:
- Canonical if Pr(w_L ≥ 0.90 and precision ≥ 0.80 | data) ≥ 0.80
- Strong if Pr(0.60 ≤ w_L < 0.90 | data) ≥ 0.80
- Weak if Pr(0.30 ≤ w_L < 0.60 | data) ≥ 0.80
```

Thresholds remain provisional until validated via cross-validation on held-out data.

### Causal Status (from Codex)

**w_L is causally interpretable**:
- The DAG posits η_{L,c} → F_{L,c,φ}
- "φ realizes c" means: intervening to increase η_{L,c} (holding diagnostics constant) increases Pr(F_{L,c,φ}=1)
- w_L and q_L summarize the structural coefficients (κ, λ) on this causal path
- We do not intervene directly on w_L; it's a derived quantity

**Predictions are causal**: Mechanism-specific predictions in §9 concern how changes in homeostatic mechanisms would alter weight profiles.

---

## Section-by-Section Implementation

### §3.1 Weight Assignment Procedures (Lines 158-191)

**Replace current "Analyst weight" paragraph with**:

```latex
\item[Analyst weight] A provisional rating based on diagnostic strength:
$w_L^{\text{prov}}(c,\phi)$ is assigned via a four-point ordinal scale that
reflects sensitivity and precision. These serve as initial values for the
measurement model, which refines them using cross-linguistic diagnostic
patterns. Provisional thresholds follow standard psychometric conventions
\parencite{Cowart1997,Schuetze1996}:
\begin{itemize}
  \item Provisional 1.0: Canonical exponent~-- $\phi$ appears in $\geq 90\%$
        of diagnostic contexts where $c$ is independently diagnosed, with high
        precision ($\geq 80\%$ of $\phi$ occurrences signal $c$)
  \item Provisional 0.7: Strong secondary~-- $\phi$ appears in $60\%$--$90\%$
        of diagnostic contexts, moderate precision ($50\%$--$80\%$)
  \item Provisional 0.4: Weak correlate~-- $\phi$ appears in $30\%$--$60\%$
        of diagnostic contexts, low precision ($20\%$--$50\%$)
  \item 0.0: Absent or irrelevant~-- $\phi$ appears in $<30\%$ of diagnostic
        contexts or precision $<20\%$
\end{itemize}

Provisional weights initialize the measurement model's priors on realization
parameters $\kappa_{L,c,\phi}$ and $\lambda_{c,\phi}$ (Section~\ref{sec:measurement}).
Final weights $w_L(c,\phi)$ are posterior-derived conditional probabilities
with uncertainty quantification. Inter-coder agreement (Cohen's $\kappa > 0.7$)
validates provisional assignments.
```

**Add new paragraph after threshold specification**:

```latex
\paragraph{Interpretation and identifiability.} The weight function
$w_L(c,\phi)$ measures the conditional probability that form $\phi$ is selected
when comparandum $c$ is at maximum strength: $w_L(c,\phi) = \Pr(F_{L,c,\phi}=1
\mid \eta_{L,c}=1)$. An auxiliary quantity $q_L(c,\phi) = \Pr(F_{L,c,\phi}=1
\mid \eta_{L,c}=0)$ captures false-positive rates (form appears when comparandum
is absent). This two-parameter characterization preserves the HPC intuition that
multiple forms can independently realize the same comparandum with high weights
simultaneously—there is no sum-to-1 constraint forcing competition.
Identifiability is ensured by anchoring the latent scale (fixing $\text{Var}(\eta)=1$),
enforcing monotonicity ($\lambda_{c,\phi} \geq 0$), and separating diagnostic
evidence (Level~I) from realization evidence (Level~III).
```

### §4.2 Coding Protocol (Lines 260-267)

**Revise precision bullet**:

```latex
\item \textbf{Precision (positive predictive value):} When $\phi$ appears, does
it reliably signal $c$? Forms may serve multiple comparanda simultaneously (e.g.,
English pronouns\textsubscript{Eng} realize both \textsc{definiteness}\textsubscript{\Cross}
with $w_L \approx 1.0$ and various case/agreement functions), but precision is
evaluated separately for each comparandum. Provisional high precision ($\geq 80\%$)
yields $w_L^{\text{prov}} = 1.0$; the measurement model (Section~\ref{sec:measurement})
refines this via posterior estimation, reporting $w_L$ as $\Pr(\phi \mid \eta_{c}=1)$
with credible intervals.
```

**Add after contextual strength bullet**:

```latex
\item \textbf{Record false positives.} For each form $\phi$, document contexts
where $\phi$ appears but $c$ is diagnosed as absent. This estimates $q_L(c,\phi)$,
the false-positive rate, which distinguishes high-precision exponents
($w_L \gg q_L$) from ambiguous forms ($w_L \approx q_L$).
```

### Table 2 (Lines 198-223)

**Complete replacement**:

```latex
\begin{table}[ht]
  \centering
  \caption{Fragment of $M_L$ for English ($L = \mathrm{Eng}$) and Japanese
  ($L = \mathrm{Jpn}$). Weights are conditional probabilities
  $w_L(c,\phi)=\Pr(F_{L,c,\phi}=1 \mid \eta_{L,c}=1)$ estimated from the
  two-layer hierarchical model (Section~\ref{sec:measurement}); values show
  posterior means with 80\% credible intervals. False-positive rates
  $q_L(c,\phi)$ shown in parentheses. Multiple realizations per comparandum
  reflect HPC clustering; rows need not sum to 1 because forms can independently
  express the same comparandum with high weights.}
  \label{tab:matrix}
  \small
  \begin{tabular}{p{3.2cm}p{3.2cm}p{2.2cm}p{3.2cm}p{2.2cm}}
    \toprule
    Comparandum $c$ & Form $\phi$ in English & $w_{\mathrm{Eng}}$ ($q$) &
    Form $\phi$ in Japanese & $w_{\mathrm{Jpn}}$ ($q$) \\
    \midrule
    \textsc{determiner}\textsubscript{\Cross} &
      Determinative phrase\textsubscript{Eng} &
      0.95 (0.05) &
      Classifier phrase\textsubscript{Jpn} &
      0.92 (0.08) \\
    \textsc{definiteness}\textsubscript{\Cross} &
      Pronoun\textsubscript{Eng} &
      0.98 (0.02) &
      Demonstrative\textsubscript{Jpn} &
      0.85 (0.10) \\
    & Proper name\textsubscript{Eng} &
      0.96 (0.04) &
      Topic-marked NP\textsubscript{Jpn} &
      0.72 (0.15) \\
    & Determinative\textsubscript{Eng} (\textit{the}) &
      0.68 (0.22) &
      Bare NP\textsubscript{Jpn} (context) &
      0.45 (0.35) \\
    & Possessive construction\textsubscript{Eng} &
      0.62 (0.18) & & \\
    \textsc{mass/count}\textsubscript{\Cross} &
      Number morphology\textsubscript{Eng} &
      0.73 (0.12) &
      Classifier\textsubscript{Jpn} &
      0.88 (0.06) \\
    & Quantifier selection\textsubscript{Eng} &
      0.58 (0.25) &
      Numeral concord\textsubscript{Jpn} &
      0.76 (0.14) \\
    \textsc{topic}\textsubscript{\Cross} &
      Left-peripheral NP\textsubscript{Eng} + intonation &
      0.65 (0.20) &
      XP\textsubscript{Jpn} + \textit{wa} &
      0.94 (0.05) \\
    & \textit{As for} frame\textsubscript{Eng} &
      0.48 (0.28) &
      Zero-marked subject\textsubscript{Jpn} &
      0.52 (0.30) \\
    \textsc{modifier}\textsubscript{\Cross} &
      Adjective phrase\textsubscript{Eng} &
      0.78 (0.15) &
      Relative clause\textsubscript{Jpn} &
      0.89 (0.08) \\
    & Relative clause\textsubscript{Eng} &
      0.71 (0.18) &
      Adjective\textsubscript{Jpn} (stative verb) &
      0.66 (0.22) \\
    & Prepositional phrase\textsubscript{Eng} &
      0.54 (0.25) & & \\
    \bottomrule
  \end{tabular}
\end{table}
```

### §6.1 Probabilistic Formalization (Lines 434-522)

**Replace current measurement model section with**:

```latex
\subsection{Probabilistic formalization of CIM-L}\label{sec:measurement}

The comparandum-indexed matrix for language $L$ can be estimated via a
\textbf{two-layer hierarchical model} that separates diagnostic evidence
(Level~I) from realization evidence (Level~III), preserving anti-circularity
while ensuring identifiability.

\paragraph{Layer 1: Diagnostic evidence.} Behavioral diagnostics $d_i$ measure
the latent strength $\eta_{L,c}$ of comparandum $c$ in language $L$ without
reference to morphosyntactic forms:

\begin{align}
d_{L,i} &\sim \text{Bernoulli}(\pi_i) \\
\text{logit}(\pi_i) &= \alpha_i + \beta_i \eta_{L,c} + u_{\text{fam}(L)} + v_{\text{coder}(i)}
\end{align}

where:
\begin{itemize}
  \item $\eta_{L,c} \sim \text{Normal}(\mu_{\text{family}}, 1)$ is the latent
        comparandum strength (variance fixed at 1 to anchor the scale)
  \item $d_i$ is diagnostic $i$ (e.g., ArgHead, PossInterface from Section~\ref{subsec:diagnostic-battery})
  \item $\alpha_i$ is diagnostic-specific difficulty
  \item $\beta_i$ is diagnostic discrimination (how informative the test is)
  \item $u_{\text{fam}}$ captures phylogenetic clustering via partial pooling
  \item $v_{\text{coder}}$ captures systematic coder biases
\end{itemize}

Crucially, diagnostics never condition on forms $\phi$, ensuring
$(F_{L,c,\phi} \perp d_{L,i} \mid \eta_{L,c})$ as required by
anti-circularity (Rule~B in Figure~\ref{fig:dag}).

\paragraph{Layer 2: Realization evidence.} Forms $F_{L,c,\phi,t}$ (indexed by
tokens $t$) are observed conditional on latent comparandum strength:

\begin{align}
F_{L,c,\phi,t} &\sim \text{Bernoulli}(\rho_{L,c,\phi,t}) \\
\text{logit}(\rho_{L,c,\phi,t}) &= \kappa_{L,c,\phi} + \lambda_{c,\phi} \eta_{L,c} + \delta_{\text{fam}(\phi)}
\end{align}

with monotonicity constraint $\lambda_{c,\phi} \geq 0$ (stronger comparanda
cannot decrease form probability). Priors:

\begin{align}
\kappa_{L,c,\phi} &\sim \text{Normal}(\mu_{\kappa}, 1.5) \\
\lambda_{c,\phi} &\sim \text{HalfNormal}(0, 1) \\
\delta_{\text{fam}} &\sim \text{Normal}(0, 0.5)
\end{align}

where $\mu_{\kappa}$ is initialized from analyst provisional weights
$w_L^{\text{prov}}$ via the logit transform.

\paragraph{Derived weights.} The weight function and false-positive rate are
deterministic functions of structural parameters:

\begin{align}
w_L(c,\phi) &= \sigma(\kappa_{L,c,\phi} + \lambda_{c,\phi}) = \Pr(F_{L,c,\phi}=1 \mid \eta_{L,c}=1) \\
q_L(c,\phi) &= \sigma(\kappa_{L,c,\phi}) = \Pr(F_{L,c,\phi}=1 \mid \eta_{L,c}=0)
\end{align}

where $\sigma$ is the logistic function. Because $\kappa$ and $\lambda$ have
priors, $w_L$ and $q_L$ inherit posterior distributions; the matrix $M_L$
stores $\mathbb{E}[w_L \mid \text{data}]$ with 80\% credible intervals.

\paragraph{Identifiability.} Three mechanisms ensure unique parameter estimation:
\begin{enumerate}
  \item \textbf{Variance anchoring:} Fixing $\text{Var}(\eta)=1$ breaks the
        $(k \cdot w_L, \eta/k)$ scaling symmetry
  \item \textbf{Monotonicity:} The constraint $\lambda \geq 0$ prevents sign
        ambiguity
  \item \textbf{Independent measurements:} Layers~1 and~2 provide conditionally
        independent evidence sources, yielding two equations for two latent
        quantities ($\eta$ and $\kappa$,$\lambda$)
\end{enumerate}

Any alternative parameterization would violate at least one constraint, ensuring
the posterior is proper.

\paragraph{Estimation workflow.}
\begin{enumerate}
  \item Fit Layer~1 to obtain posterior draws of $\eta_{L,c}$ from diagnostic
        data alone
  \item Condition on $\eta_{L,c}$ samples while fitting Layer~2, yielding joint
        posterior samples of $(\kappa, \lambda)$
  \item Transform samples to $(w_L, q_L)$ and compute posterior summaries
  \item Validate via posterior predictive checks: does the model generate
        diagnostic and form patterns consistent with observed data?
\end{enumerate}

This is a multilevel model because languages share evolutionary history:
$\eta_{L,c} \sim \text{Normal}(\mu_{\text{family}}, 1)$ implements partial
pooling by genealogy, preventing spurious correlations from areal clustering.
```

### §7.1 Deriving Measurement Model (Lines 524-573)

**Add paragraph after current derivation**:

```latex
\paragraph{Identifiability and anti-circularity.} The two-layer structure
formalizes the paper's core methodological commitment: Level~I comparanda
($\eta$) are diagnosed \textit{first} from behavioral evidence alone (Layer~1),
then Level~III realizations ($\kappa$, $\lambda$) are estimated \textit{conditional}
on that diagnosis (Layer~2). This workflow embodies Rule~B from
Figure~\ref{fig:dag}: withhold candidate forms when diagnosing semantic targets.
The separation provides identifiability (two independent measurement layers)
while maintaining anti-circularity (diagnostics never reference forms).
Variance anchoring and monotonicity constraints complete the identifiability
proof.
```

### §9 Predictions (update language)

**Find prediction statements and add**:

```latex
\paragraph{Quantifying redundancy.} Because weights are conditional probabilities
without sum-to-1 constraints, we can quantify HPC redundancy via the
\textbf{effective number of realizations}:

\[
N_{\text{eff}}(c) = \frac{1}{\sum_{\phi} w_L(c,\phi)^2}
\]

High $N_{\text{eff}}$ indicates robust clustering with multiple strong exponents;
low $N_{\text{eff}}$ suggests fragile categories. Naturalization predicts
$N_{\text{eff}} \geq 2$ across phylogenetically diverse families for legitimate
comparative concepts.
```

### §10 Objections - Add new subsection

**After "The essence worry" subsection, add**:

```latex
\subsection{The independence worry}\label{subsec:independence-worry}

\textbf{Objection:} Standard measurement models require sum-to-1 constraints
for identifiability, forcing competition between forms. Doesn't this violate
HPC's core intuition that multiple mechanisms independently maintain the cluster?

\textbf{Reply:} The two-layer model achieves identifiability \textit{without}
simplex constraints. Variance anchoring ($\text{Var}(\eta)=1$) and monotonicity
($\lambda \geq 0$) fix the scale, allowing multiple forms to simultaneously
achieve $w_L \approx 1.0$. For example, English pronouns and proper names can
both be near-canonical exponents of \textsc{definiteness}\textsubscript{\Cross}
(w ≈ 0.98, w ≈ 0.96) without forced trade-offs. The false-positive rate
$q_L(c,\phi)$ distinguishes high-precision exponents from ambiguous forms,
providing richer characterization than normalized weights. This preserves HPC's
theoretical commitment to clustered, partially redundant mechanisms while
enabling rigorous statistical inference.
```

---

## Files to Modify

1. **main.tex**: All changes above
2. **No new files needed**: Two-layer model fits within existing §6.1
3. **Optional**: Add appendix with identifiability proof simulation (future work)

---

## Implementation Checklist

- [ ] §3.1: Replace analyst weight paragraph, add interpretation paragraph
- [ ] §4.2: Revise precision bullet, add false-positive recording step
- [ ] Table 2: Complete replacement with w_L and q_L columns
- [ ] §6.1: Replace measurement model with two-layer system
- [ ] §7.1: Add identifiability/anti-circularity paragraph
- [ ] §9: Add redundancy quantification paragraph
- [ ] §10: Add independence worry subsection
- [ ] Verify all cross-references remain valid
- [ ] Compile and check for errors
- [ ] Verify notation consistency throughout

---

## Expected Outcome

- **Identifiability**: ✅ Resolved via variance anchoring + monotonicity
- **Type safety**: ✅ w_L is derived random variable throughout
- **HPC preservation**: ✅ Multiple forms can independently have high weights
- **Anti-circularity**: ✅ Formalized by two-layer structure
- **Causal interpretation**: ✅ η → F with w_L summarizing path strength
- **Richness**: ✅ w_L + q_L provides precision characterization

Ready to implement. Shall I proceed?
