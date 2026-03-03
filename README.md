# Malaria Within-Host ODE Model

## Model Description

This project implements a continuous-time ODE model describing within-host malaria parasite dynamics.

The system tracks:

- **A(t)** – Asexual parasite density  
- **G(t)** – Gametocyte density  

The model structure:

- Parasite replication rate: `r`
- Merozoite production: `m`
- Conversion fraction to gametocytes: `g`
- Immune-mediated clearance (after day 8): `k`
- Gametocyte clearance rate: `l`

Immunity is assumed to begin on day 8.

---

## Baseline Parameters

```r
para <- c(r=0.25, m=6, k=3, l=1.2)
init.y <- c(A=25, G=0)
g = 0.15

Observed Model Behaviour

Effect of Increasing Gametocyte Conversion (g)

Increasing g reduces peak A(t).

Higher g increases G(t) magnitude.

- Trade-off observed between asexual replication and transmission potential.

More parasites convert to gametocytes instead of remaining in the replicating asexual stage.

Increasing Immune Clearance (k)

Stronger decline in A(t) after day 8.

Lower overall parasite burden.

Secondary reduction in gametocyte production.

- Immune response suppresses parasite expansion.

Increasing Replication Rate (r)

Faster exponential growth phase.

Earlier and higher peak parasite density.

Increased downstream gametocyte production.

- Higher intrinsic growth leads to more severe infection dynamics.

Insights

The model captures the transition from exponential growth to immune-regulated decline.

Transmission potential (G) is highly sensitive to parameter g.

Immune timing critically alters infection duration.

Numerical Method

The system was solved using the deSolve package in R (LSODA solver).

Future Work

Parameter sensitivity analysis

Stability analysis of equilibria

Incorporation of drug treatment dynamics

Extension to host-to-vector transmission coupling