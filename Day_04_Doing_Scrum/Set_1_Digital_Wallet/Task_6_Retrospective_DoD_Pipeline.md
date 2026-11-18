# Set 1 – Task 6: Retrospective and Definition of Done → Build Pipeline

## Part A – Retrospective

### What went well
- The Day 4 refund-to-wallet change was absorbed with a scope-neutral swap and the Sprint Goal stayed intact.
- Contract-first API design (WAL-101-1) meant frontend and backend worked in parallel.
- Impediments (test data, error copy) were raised at stand-up and logged the same day.
- All 23 points met the Definition of Done.

### What to improve
- Work finished late: 13 of 23 points were completed on Days 9–10 (see burndown).
- The 8-point story WAL-104 was too large and sat "In Progress" for ~6 days.
- The test environment had no seed data, which blocked QA for about a day.
- Code reviews waited up to 1 day for a reviewer.

### Action items

| # | Action | Owner | Due | Success measure |
|---|---|---|---|---|
| 1 | Split any story > 5 points during refinement and cap stories at 3 working days | Product Owner + Developers | Before next Sprint Planning | No story > 5 pts in next sprint; at least 50 % of points done by Day 6 |
| 2 | Add an automated seed-data script to the test environment | Karthik (Backend) with DevOps | End of Sprint 2, Day 3 | QA can run all negative tests from Day 1 |

## Part B – Definition of Done mapped to the build pipeline (half-page)

**Definition of Done (team agreement):** code builds, unit tests pass with ≥ 80 % coverage on changed code, peer review approved by at least one developer, QA acceptance criteria verified, no open Sev-1/Sev-2 defects, merged to `main`, deployed to the test environment.

| Pipeline stage | What the pipeline does | DoD criteria it enforces | Jira link |
|---|---|---|---|
| **1. Build** | On every push: compile/bundle (Node.js, React), run ESLint and dependency check | Code builds; no lint errors | Branch named `WAL-xxx-…` links to the Jira issue |
| **2. Test** | Run unit tests with coverage report; run integration tests on the test environment | ≥ 80 % coverage on changed code; tests pass; acceptance criteria verified by QA | QA moves the ticket after green run |
| **3. Review** | Pull request requires ≥ 1 approving reviewer and all checks green | Peer review done; no unresolved comments | Ticket moves to **In Review** when PR opens |
| **4. Merge** | Merge to `main` only if build, test and review gates pass; auto-deploy to test environment | Merged and deployed; DoD complete | Ticket moves to **Done** on merge + deploy |

**Flow:** commit → build → test → review → merge → deploy. A failure at any stage stops the line and the story stays out of **Done**. This stops "almost done" work from being counted, which supports a trustworthy burndown and velocity.
