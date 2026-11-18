# Set 3 – Task 5: Retrospective – Start / Stop / Continue and SMART Actions

> Illustrative retrospective for the Set 3 sprint (velocity 25 of 30; scope change on Day 6; API-contract blocker). Timebox: 60 minutes. Format: Set the stage (5) → Gather data (20) → Generate insights (15) → Decide actions (15) → Close (5).

## Start / Stop / Continue

| Start | Stop | Continue |
|---|---|---|
| Agreeing API contracts with other teams **before** a story enters the sprint | Pulling mid-sprint requests straight into the sprint without a swap discussion | The swap rule: add new work only by removing equal-sized unstarted work |
| Splitting stories larger than 5 points | Letting a blocked story sit more than one day without escalation | Publishing the burndown daily |
| Adding a Definition of Ready item: "dependencies confirmed" | Starting new stories while others wait in review | Daily stand-ups with explicit blocker callouts |
| A shared mock-server (contract tests) for external APIs | Reporting "80 % done" instead of what is left | Pair-reviewing pull requests |

## SMART action items

| # | Action (Specific) | Measurable | Achievable / Relevant | Owner | Deadline |
|---|---|---|---|---|---|
| 1 | Add "API contract available and reviewed" to the Definition of Ready checklist and refuse any story that fails it at Sprint Planning | 100 % of stories in next sprint have the DoR checkbox ticked | Within team control; addresses the LRN-304 blocker | Scrum Master (with Product Owner) | Before next Sprint Planning (Day 1 of Sprint 13) |
| 2 | Set up a mock API server (e.g. WireMock/OpenAPI mocks) for the Progress and other external APIs so UI work can finish and be tested without live APIs | Mock available for all external APIs used by next sprint's stories; integration test suite runs against it in CI | Small setup effort (≈ 1 day); reduces blocked time | Sneha (Developer) | Sprint 13, Day 3 |
| 3 | Split every story > 5 points in refinement and limit WIP to 2 stories per developer | No story > 5 pts in sprint 13; no more than 2 In Progress per person on the board | Uses existing refinement meeting | Product Owner + Developers | Refinement session, 3 days before next planning |

Each action has an owner, a deadline and a measure, and is reviewed at the start of the next retrospective. Action 1 and 2 should be added to the Jira board as sprint tasks so they get time.
