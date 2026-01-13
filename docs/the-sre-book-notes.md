# Introduction of the SRE book notes

## Balancing SRE Responsibilities

Cap operational work at 50%; allocate remaining time to development and engineering efforts.

## Pursuing Maximum Change without Violating Sevice Level Objective

100% is the wrong reliability target because no user can tell the difference between a system being 100% available and 99.999% available.

What is the right reliability target for the system? Consider these:

- What level of availability will make user happy?
- What can users do if they're unhappy with availability?
- How does users' usage change at different availability levels?

The error budget (1 - availability target) helps balance innovation and stability. 

Teams can use this budget to take calculated risks and launch new features quickly, without compromising agreed reliability standards.

## Monitoring best practice

Monitoring should automatically track system health and availability. 

Alerts must be actionable—humans should only be notified when intervention is required. If a person needs to interpret an alert before deciding what to do, the system is flawed. Instead, software should handle interpretation and only escalate when human action is necessary.

Types of Monitoring output:

- Alerts – Immediate human action is required.
- Tickets – Human action is needed, but not urgently.
- Logs – No action is needed; information is recorded for diagnostics or future analysis.

## Emergency response 

Reliability = MTTF (mean time to failure) + MTTR (mean time to repair)

A system is more reliable when it fails less often (high MTTF), and it gets fixed quickly (low MTTR).

- MTTR is key to reliability.
- Less human intervention = faster recovery.
- Playbooks improve MTTR ~3x vs improvising.

So,
- Record best practices ahead of time to reduce response time and improve outcomes.
- Training tools like “Wheel of Misfortune” help prepare engineers.

## Change Management

Roughly 70% outages come from live system changes. Best practices are:

- Implementing changes gradually (to small percentage of users first)
- Fast and accurate problem detection
- Rolling back changes safely when problem arise

## Capacity Planning
Key steps:

- Forecast organic demand beyond hardware lead times.
- Include inorganic demand (e.g. marketing spikes, launches).
- Run regular load tests to link raw resources (servers, disks) to actual service capacity.

## Provisioning

- Combines change management and capacity planning.
- Should be done quickly and only when needed, since capacity is costly.
- Must be done correctly, or the added capacity may fail when needed.
- Involves:

    - Spinning up new instances or locations
    - Updating configs, load balancers, and networking
    - Validating performance and correctness

- Riskier than load shifting which is why often done multiple times per hour must be treated with caution.

## Efficienty and Performance

- Efficiency = demand + capacity + software performance

- SREs:
  - Forecast demand
  - Provision capacity
  - Optimize software

Performance impacts capacity: As load increases, systems slow down—eventually failing to serve.
Improving performance boosts capacity and lowers cost.


