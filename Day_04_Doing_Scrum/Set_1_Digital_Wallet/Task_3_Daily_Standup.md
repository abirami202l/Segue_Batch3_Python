# Set 1 – Task 3: Daily Stand-up (Day 3) and Impediment Log

> Team member names and details are fictional/illustrative. Format: Yesterday / Today / Impediment.

## Day 3 stand-up

### Priya (Backend)
- **Yesterday:** Finished the ledger migration (WAL-101-2) and completed UPI provider integration up to the callback handler (WAL-101-3).
- **Today:** Finish callback handling, write unit tests (WAL-101-6) and raise the PR so WAL-101 can be Done today.
- **Impediment:** None.

### Arjun (Frontend)
- **Yesterday:** Built the top-up screen layout (WAL-101-4) against the agreed API contract.
- **Today:** Add validation and error messages (WAL-101-5), then start the transfer flow UI (WAL-104-4).
- **Impediment:** The final error-message copy for failed payments is not confirmed. I am using placeholder text.

### Meena (QA)
- **Yesterday:** Wrote test cases for top-up and P2P from the acceptance criteria.
- **Today:** Run integration tests on WAL-101 once Priya's PR is merged to the test environment.
- **Impediment:** The test environment has no seeded wallet accounts with balances, so negative/limit tests are blocked.

## Impediment log

| ID | Raised (Day) | Description | Impact | Owner | Escalation | Status / expected resolution |
|---|---|---|---|---|---|---|
| IMP-01 | Day 3 | Error-message copy for failed UPI payments not confirmed | Low: placeholder text can ship, but UX acceptance at risk | Product Owner | PO → UX writer | Open; resolve by Day 4 |
| IMP-02 | Day 3 | Test environment lacks seeded wallet accounts | Medium: blocks QA of WAL-101/104 negative tests (≈ 1 day idle) | Scrum Master (coordinate with DevOps) | SM → DevOps lead → Engineering Manager | Open; seed script requested, expected Day 4 morning |

**Scrum Master follow-up:** SM contacts DevOps right after the stand-up for IMP-02, and asks the PO to reply on IMP-01 by end of day. Both are reviewed at Day 4 stand-up.
