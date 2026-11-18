# Set 1 – Task 2: Sprint Backlog – Story-to-Task Breakdown

> Hour estimates are the team's illustrative planning figures. Three stories broken down: **WAL-101, WAL-103, WAL-104**. Jira structure: Story → Sub-tasks (type *Sub-task*, original estimate in hours).

## WAL-101 – Add money via UPI (5 pts)

| Sub-task key | Task | Owner | Est. (h) |
|---|---|---|---|
| WAL-101-1 | Agree API contract for top-up endpoint | Priya (BE) | 4 |
| WAL-101-2 | Design wallet ledger table and migration | Priya (BE) | 6 |
| WAL-101-3 | Integrate UPI payment provider (backend) | Priya (BE) | 12 |
| WAL-101-4 | Build top-up screen (React) | Arjun (FE) | 8 |
| WAL-101-5 | Input validation and error handling | Arjun (FE) | 4 |
| WAL-101-6 | Unit tests | Priya (BE) | 6 |
| WAL-101-7 | Integration/regression test | Meena (QA) | 4 |
| WAL-101-8 | Code review and fixes | Team | 3 |
| | **Total** | | **47** |

## WAL-103 – Transaction history (5 pts)

| Sub-task key | Task | Owner | Est. (h) |
|---|---|---|---|
| WAL-103-1 | Paginated history API | Karthik (BE) | 8 |
| WAL-103-2 | History list UI with infinite scroll | Arjun (FE) | 8 |
| WAL-103-3 | Filters (date, type) | Arjun (FE) | 5 |
| WAL-103-4 | Unit and UI tests | Meena (QA) | 5 |
| WAL-103-5 | Code review and fixes | Team | 3 |
| | **Total** | | **29** |

## WAL-104 – P2P transfer (8 pts)

| Sub-task key | Task | Owner | Est. (h) |
|---|---|---|---|
| WAL-104-1 | Recipient lookup API | Karthik (BE) | 6 |
| WAL-104-2 | Atomic debit/credit transfer service | Priya (BE) | 14 |
| WAL-104-3 | Idempotency keys (avoid double debit) | Priya (BE) | 6 |
| WAL-104-4 | Transfer flow UI | Arjun (FE) | 10 |
| WAL-104-5 | Daily limit / fraud-rule check | Karthik (BE) | 5 |
| WAL-104-6 | Unit, integration and negative tests | Meena (QA) | 8 |
| WAL-104-7 | Code review and fixes | Team | 4 |
| | **Total** | | **53** |

## Summary

| Story | Points | Task hours |
|---|---|---|
| WAL-101 | 5 | 47 |
| WAL-103 | 5 | 29 |
| WAL-104 | 8 | 53 |
| **Total** | 18 | **129 h** |

Capacity check (assumption: 5 developers × 10 days × 6 focus-hours = 300 h). The 129 h leaves ~171 h for WAL-105, WAL-110, bug-fixing, ceremonies and buffer, so the plan is feasible.

## Sprint board record (Day 1)

| To Do | In Progress | In Review | Done |
|---|---|---|---|
| All sub-tasks above | – | – | – |

See `Screenshots/Set_1_Jira_Board.png` for the board snapshot.
