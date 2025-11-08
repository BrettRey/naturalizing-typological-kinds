"""
Auditable Specification of Typological Framework
=================================================

This module formalizes the theoretical machinery from "Naturalizing Typological Kinds:
Comparanda, Mechanisms, and Measurement" by Brett Reynolds.

The framework implements:
1. Three-level ontology (cross-linguistic pressures, cross-linguistic syntax, language-internal)
2. Comparanda-realization mappings with weight functions
3. Syntax-semantics hygiene protocol
4. Naturalized comparative concepts with homeostatic mechanisms
5. Measurement models and failure mode diagnostics

Author: Brett Reynolds
License: CC BY 4.0
"""

from dataclasses import dataclass, field
from typing import Dict, List, Set, Optional, Tuple, Callable
from enum import Enum
import abc


# =============================================================================
# Three-Level Ontology
# =============================================================================

class OntologicalLevel(Enum):
    """Three-tier ontology for comparative typology."""
    LEVEL_I = "cross_linguistic_pressures"    # Semantic targets, discourse roles
    LEVEL_II = "cross_linguistic_syntax"      # Functions and categories (comparative concepts)
    LEVEL_III = "language_internal"           # Language-specific realizations


@dataclass
class ComparandumType(Enum):
    """Types of cross-linguistic comparanda."""
    SEMANTIC_TARGET = "semantic_target"       # e.g., definiteness, specificity, mass/count
    DISCOURSE_ROLE = "discourse_role"         # e.g., topic, focus, vocative
    FUNCTION = "function"                     # e.g., subject, head, predicate
    CATEGORY = "category"                     # e.g., V, VP, clause, noun


@dataclass
class Comparandum:
    """
    A cross-linguistic comparative concept.

    Comparanda are analyst-constructed categories that allow comparison without
    assuming the categories exist in individual grammars.
    """
    name: str
    level: OntologicalLevel
    type: ComparandumType
    diagnostics: List[str] = field(default_factory=list)

    def __repr__(self):
        return f"{self.name}×"  # × subscript for cross-linguistic


@dataclass
class LanguageSpecificRealization:
    """
    A language-internal realization of a comparandum.

    These are the actual categories, functions, targets, or roles that exist
    in a particular language's grammar.
    """
    language_code: str
    name: str
    comparandum: Comparandum
    properties: Set[str] = field(default_factory=set)

    def __repr__(self):
        return f"{self.name}_{{{self.language_code}}}"


# =============================================================================
# Weight Functions and Reliability Scores
# =============================================================================

@dataclass
class WeightFunction:
    """
    Maps language-specific realizations to cross-linguistic comparanda with weights.

    Weights are on an ordinal scale (0 = absent, 1 = weak, 2 = moderate, 3 = strong).
    """
    source: str = "observational"  # "observational" or "analyst"

    def assign_weight(self,
                     realization: LanguageSpecificRealization,
                     property_name: str) -> int:
        """
        Assign weight for how strongly a property appears in a realization.

        Args:
            realization: Language-specific realization
            property_name: Property to evaluate

        Returns:
            Ordinal weight: 0 (absent), 1 (weak), 2 (moderate), 3 (strong)
        """
        if property_name not in realization.properties:
            return 0

        # In real implementation, this would use empirical diagnostics
        # For now, treat presence as moderate strength
        return 2


@dataclass
class ReliabilityScore:
    """
    Measures reliability of comparandum-realization mappings.

    Higher scores indicate more consistent cross-linguistic patterns.
    """
    comparandum: Comparandum
    consistency_score: float  # 0.0 to 1.0
    coverage_score: float     # Proportion of languages with realization

    def overall_reliability(self) -> float:
        """Combined reliability metric."""
        return (self.consistency_score + self.coverage_score) / 2


# =============================================================================
# Syntax-Semantics Hygiene Protocol
# =============================================================================

class HygieneDiagnostic(abc.ABC):
    """Abstract base for hygiene diagnostics testing semantic targets independently."""

    @abc.abstractmethod
    def test(self, expression: str, context: Dict) -> bool:
        """
        Test whether expression shows target property in context.

        Must be independent of morphosyntactic exponents.
        """
        pass


@dataclass
class DefinitenessHygiene(HygieneDiagnostic):
    """
    Tests definiteness independently of articles or determiners.

    Uses behavioral diagnostics: uniqueness presuppositions, anaphoric licensing,
    specificity in discourse.
    """

    def test(self, expression: str, context: Dict) -> bool:
        """Test definiteness through interpretation, not form."""
        # In real implementation: check discourse referent uniqueness,
        # anaphoric accessibility, common ground management
        return context.get('uniqueness_presupposition', False)


@dataclass
class SpecificityHygiene(HygieneDiagnostic):
    """Tests specificity independently of case marking or word order."""

    def test(self, expression: str, context: Dict) -> bool:
        """Test specificity through scope and referent identification."""
        # In real implementation: check scope-taking, partitivity,
        # speaker identifiability
        return context.get('speaker_identifiable', False)


@dataclass
class HygieneProtocol:
    """
    Syntax-semantics hygiene protocol for testing targets independently.

    Ensures semantic targets are diagnosed separately from their morphosyntactic
    exponents to avoid conflating form with function.
    """
    diagnostics: Dict[str, HygieneDiagnostic] = field(default_factory=dict)

    def register_diagnostic(self, target_name: str, diagnostic: HygieneDiagnostic):
        """Register a diagnostic for a semantic target."""
        self.diagnostics[target_name] = diagnostic

    def test_target(self, target_name: str, expression: str, context: Dict) -> bool:
        """Test whether expression instantiates target in context."""
        if target_name not in self.diagnostics:
            raise ValueError(f"No diagnostic registered for {target_name}")
        return self.diagnostics[target_name].test(expression, context)


# =============================================================================
# Naturalized Comparative Concepts
# =============================================================================

class MechanismType(Enum):
    """Types of homeostatic mechanisms."""
    COGNITIVE = "cognitive"           # Cognitive-interactional pressures
    DISCOURSE = "discourse"           # Discourse management requirements
    DIACHRONIC = "diachronic"        # Historical development pathways
    COMMUNITY = "community"          # Community-internal transmission


@dataclass
class HomeostaticMechanism:
    """
    A mechanism that maintains property clusters in comparative concepts.

    Naturalized comparative concepts persist because mechanisms maintain
    their clustered properties, not because they have essential features.
    """
    name: str
    type: MechanismType
    maintains_properties: Set[str] = field(default_factory=set)

    def applies_to(self, comparandum: Comparandum) -> bool:
        """Check if mechanism applies to this comparandum."""
        # In real implementation: check specific applicability conditions
        return True


@dataclass
class FailureMode(Enum):
    """Ways a comparative concept can fail naturalization."""
    TOO_THIN = "too_thin"             # Too few properties to be stable
    TOO_FAT = "too_fat"               # Too many uncorrelated properties
    NEGATIVE = "negative"             # Defined only by absence
    INDETERMINATE = "indeterminate"   # No clear boundaries


@dataclass
class NaturalizationCriteria:
    """
    Criteria for promoting comparative concepts to naturalized status.

    A comparative concept earns naturalization when:
    1. It shows consistent cross-linguistic stability
    2. Identifiable homeostatic mechanisms maintain its property cluster
    3. It avoids failure modes
    """
    min_consistency_threshold: float = 0.7
    min_mechanism_count: int = 2
    excluded_failure_modes: Set[FailureMode] = field(default_factory=set)

    def evaluate(self,
                comparandum: Comparandum,
                reliability: ReliabilityScore,
                mechanisms: List[HomeostaticMechanism],
                failure_modes: Set[FailureMode]) -> Tuple[bool, str]:
        """
        Evaluate whether comparandum meets naturalization criteria.

        Returns:
            (passes, reason) tuple
        """
        # Check reliability threshold
        if reliability.consistency_score < self.min_consistency_threshold:
            return False, f"Consistency {reliability.consistency_score} below threshold"

        # Check mechanism count
        active_mechanisms = [m for m in mechanisms if m.applies_to(comparandum)]
        if len(active_mechanisms) < self.min_mechanism_count:
            return False, f"Only {len(active_mechanisms)} mechanisms (need {self.min_mechanism_count})"

        # Check for excluded failure modes
        present_failures = failure_modes & self.excluded_failure_modes
        if present_failures:
            return False, f"Failure modes present: {present_failures}"

        return True, "Passes naturalization criteria"


@dataclass
class NaturalizedComparandum:
    """
    A comparative concept promoted to naturalized status.

    Treated (defeasibly) as a natural kind with explicit mechanisms
    maintaining its property cluster.
    """
    comparandum: Comparandum
    mechanisms: List[HomeostaticMechanism]
    reliability: ReliabilityScore
    property_cluster: Set[str] = field(default_factory=set)

    def regeneration_pathways(self) -> List[str]:
        """
        Predict pathways by which property cluster can regenerate.

        Even if some properties are lost, mechanisms should regenerate cluster.
        """
        pathways = []
        for mechanism in self.mechanisms:
            if mechanism.type == MechanismType.DIACHRONIC:
                pathways.append(f"Diachronic: {mechanism.name}")
            elif mechanism.type == MechanismType.DISCOURSE:
                pathways.append(f"Discourse: {mechanism.name}")
        return pathways


# =============================================================================
# Measurement Models
# =============================================================================

@dataclass
class LatentVariable:
    """
    Latent variable representing underlying typological construct.

    Used when comparative concept cannot be directly observed but can be
    inferred from multiple observable indicators.
    """
    name: str
    indicators: List[str] = field(default_factory=list)

    def estimate(self, observations: Dict[str, float]) -> float:
        """
        Estimate latent variable value from observable indicators.

        In real implementation: use factor analysis, IRT, or SEM.
        """
        relevant_obs = [observations.get(ind, 0.0) for ind in self.indicators]
        if not relevant_obs:
            return 0.0
        return sum(relevant_obs) / len(relevant_obs)


@dataclass
class MeasurementModel:
    """
    Measurement model for comparative concepts.

    Links observable morphosyntactic properties to latent typological constructs.
    """
    latent_variables: Dict[str, LatentVariable] = field(default_factory=dict)

    def add_latent_variable(self, var: LatentVariable):
        """Register a latent variable."""
        self.latent_variables[var.name] = var

    def estimate_all(self, observations: Dict[str, float]) -> Dict[str, float]:
        """Estimate all latent variables from observations."""
        return {
            name: var.estimate(observations)
            for name, var in self.latent_variables.items()
        }


# =============================================================================
# Framework Integration
# =============================================================================

class TypologicalFramework:
    """
    Main framework integrating all components.

    Provides unified interface for:
    - Defining comparanda and realizations
    - Testing hygiene protocols
    - Evaluating naturalization
    - Running measurement models
    """

    def __init__(self):
        self.comparanda: Dict[str, Comparandum] = {}
        self.realizations: Dict[str, List[LanguageSpecificRealization]] = {}
        self.hygiene_protocol = HygieneProtocol()
        self.naturalization_criteria = NaturalizationCriteria()
        self.measurement_model = MeasurementModel()

    def register_comparandum(self, comp: Comparandum):
        """Register a cross-linguistic comparandum."""
        self.comparanda[comp.name] = comp

    def register_realization(self, real: LanguageSpecificRealization):
        """Register a language-specific realization."""
        comp_name = real.comparandum.name
        if comp_name not in self.realizations:
            self.realizations[comp_name] = []
        self.realizations[comp_name].append(real)

    def compute_reliability(self, comparandum_name: str) -> ReliabilityScore:
        """Compute reliability score for a comparandum."""
        comp = self.comparanda[comparandum_name]
        realizations = self.realizations.get(comparandum_name, [])

        if not realizations:
            return ReliabilityScore(comp, 0.0, 0.0)

        # Simplified calculation
        # In real implementation: measure cross-linguistic consistency
        consistency = 0.8  # Placeholder
        coverage = len(realizations) / 100  # Assume sample of 100 languages

        return ReliabilityScore(comp, consistency, min(coverage, 1.0))

    def evaluate_naturalization(self,
                               comparandum_name: str,
                               mechanisms: List[HomeostaticMechanism],
                               failure_modes: Set[FailureMode] = None) -> Tuple[bool, str]:
        """Evaluate whether comparandum should be naturalized."""
        comp = self.comparanda[comparandum_name]
        reliability = self.compute_reliability(comparandum_name)

        if failure_modes is None:
            failure_modes = set()

        return self.naturalization_criteria.evaluate(
            comp, reliability, mechanisms, failure_modes
        )


# =============================================================================
# Example Usage
# =============================================================================

def example_definiteness_analysis():
    """Example: Analyzing definiteness as a naturalized comparative concept."""

    # Initialize framework
    framework = TypologicalFramework()

    # Define definiteness comparandum (Level I: semantic target)
    definiteness = Comparandum(
        name="definiteness",
        level=OntologicalLevel.LEVEL_I,
        type=ComparandumType.SEMANTIC_TARGET,
        diagnostics=["uniqueness_presupposition", "anaphoric_licensing"]
    )
    framework.register_comparandum(definiteness)

    # Register hygiene diagnostic
    framework.hygiene_protocol.register_diagnostic(
        "definiteness",
        DefinitenessHygiene()
    )

    # Define language-specific realizations
    english_article = LanguageSpecificRealization(
        language_code="eng",
        name="definite_article",
        comparandum=definiteness,
        properties={"uniqueness", "familiarity", "anaphoric"}
    )

    turkish_suffix = LanguageSpecificRealization(
        language_code="tur",
        name="accusative_definite",
        comparandum=definiteness,
        properties={"uniqueness", "specificity"}
    )

    framework.register_realization(english_article)
    framework.register_realization(turkish_suffix)

    # Define homeostatic mechanisms
    mechanisms = [
        HomeostaticMechanism(
            name="referent_tracking",
            type=MechanismType.DISCOURSE,
            maintains_properties={"uniqueness", "anaphoric"}
        ),
        HomeostaticMechanism(
            name="grammaticalization_pathway",
            type=MechanismType.DIACHRONIC,
            maintains_properties={"article_development"}
        )
    ]

    # Evaluate naturalization
    passes, reason = framework.evaluate_naturalization(
        "definiteness",
        mechanisms,
        failure_modes=set()
    )

    print(f"Definiteness naturalization: {passes}")
    print(f"Reason: {reason}")

    # Test hygiene protocol
    context = {'uniqueness_presupposition': True}
    is_definite = framework.hygiene_protocol.test_target(
        "definiteness",
        "the cat",
        context
    )
    print(f"'the cat' tests as definite: {is_definite}")


if __name__ == "__main__":
    example_definiteness_analysis()
