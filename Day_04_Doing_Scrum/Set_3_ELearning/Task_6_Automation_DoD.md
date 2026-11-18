# Set 3 – Task 6: How Automation Supports the Definition of Done

**Definition of Done (DoD)** is the team's shared checklist that decides when a story is truly finished. Without automation, each item depends on people remembering to check it, which is slow and error-prone. Automation turns the DoD into a repeatable gate.

| Automation | What it checks | DoD item it supports | Benefit |
|---|---|---|---|
| **Unit tests** (e.g. Jest/JUnit, run on every commit) | Small pieces of code work as intended; coverage threshold (e.g. ≥ 80 %) | "Code is tested and passes" | Catches defects within minutes; safe to refactor; protects earlier features |
| **Linting** (e.g. ESLint, Checkstyle) | Code style, common bugs, unused code | "Code meets team coding standard" | Consistent, readable code; fewer review comments about style so reviewers focus on logic |
| **CI/CD pipeline** (build → test → lint → security scan → deploy to test) | Runs all checks automatically; blocks the merge if any step fails | "Builds, integrated and deployed to test environment; no open critical defects" | Fast feedback; no "works on my machine"; story cannot be marked Done unless the pipeline is green |

## How it fits together
1. A developer pushes code; the pipeline builds it.
2. Linting and unit tests run automatically; if they fail, the change cannot be merged.
3. After peer review and a green build, the code merges and deploys to the test environment.
4. QA verifies acceptance criteria, and only then is the story moved to **Done**.

## Why this matters for Scrum
- **Quality is built in**, not left to the end of the sprint.
- **Velocity is more trustworthy** because only stories that pass the gates are counted, which avoids "80 % done" stories (see Task 4).
- **Faster feedback** and less rework help the team deliver a potentially releasable increment every sprint, even when scope changes mid-sprint.
- **Transparency:** the pipeline status is visible to everyone, so "Done" means the same thing for all.

*Limit:* automation does not replace human review or exploratory testing; it covers what can be checked mechanically, so the DoD still includes peer review and acceptance by the Product Owner.
