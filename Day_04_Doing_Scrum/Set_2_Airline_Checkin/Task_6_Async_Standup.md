# Set 2 – Task 6: Written Asynchronous Stand-up (Two Time Zones)

> Team and content are fictional/illustrative. Based on Sprint Day 5.

## Setup

| Item | Agreement |
|---|---|
| Team | 3 in India (IST, UTC+5:30): Kavya, Rohan, Divya. 3 in the UK (GMT, UTC+0): Tom, Sara, James (Scrum Master) |
| Channel | Slack thread `#airline-standup`, one thread per day |
| Format | Yesterday / Today / Blockers / Need help from |
| Posting window | Each person posts within the first 30 minutes of their working day |
| Overlap | 14:30–15:30 IST = 09:00–10:00 GMT: optional 15-minute call only if blockers need discussion |
| Rule | Blockers use the 🚧 emoji and tag the person who can help; the Scrum Master replies within 2 hours |

## Day 5 thread

**Kavya (IST, 09:40 IST)**
- Yesterday: Built payment request/response models for AIR-203.
- Today: Implement payment call against the contract; write stub for decline/timeout cases.
- 🚧 Blocker: Payment sandbox returns 503 (IMP-01). Vendor ticket raised. @James

**Rohan (IST, 09:45 IST)**
- Yesterday: Seat map component for AIR-202 (rendering of 3-3 layout).
- Today: Seat selection and reservation call.
- Blockers: None. Need help from: @Tom to confirm seat-hold timeout (10 min?).

**Divya (IST, 09:52 IST)**
- Yesterday: Wrote test cases for AIR-201 and AIR-207.
- Today: Execute AIR-207 tests once PR is merged.
- Blockers: None.

**Tom (GMT, 09:05 GMT)**
- Yesterday: Reviewed AIR-201 PR. Seat-inventory API in progress.
- Today: Finish seat-inventory endpoint; answer Rohan on hold timeout (yes, 10 min).
- Blockers: None.

**Sara (GMT, 09:10 GMT)**
- Yesterday: Completed AIR-207 validation logic.
- Today: Fix review comments; open PR for AIR-207.
- Blockers: None.

**James – Scrum Master (GMT, 09:20 GMT)**
- Yesterday: Chased the vendor on sandbox status.
- Today: Escalation to vendor account manager if no response by 14:00 GMT; inform PO of risk to Sprint Goal; update impediment log.
- Notes: Kavya continues on stub; 15-minute overlap call at 09:30 GMT to agree the stub contract.

## Comparison: async vs live stand-up

| Aspect | Written asynchronous | Live (15-minute call) |
|---|---|---|
| Time-zone fit | Works for everyone; no one joins at an awkward hour | Needs a shared hour; one site gets early/late slot |
| Record | Permanent, searchable history | Needs separate notes |
| Interruptions | Low: read when convenient | Everyone stops at the same time |
| Speed of blocker resolution | Delayed by up to a time-zone gap (up to ~5.5 h) if no one is online | Immediate discussion and decision |
| Collaboration and team bond | Weaker; easy to miss tone | Stronger; spontaneous pairing and quick questions |
| Accountability | Visible who posted and who did not | Visible, but depends on attendance |
| Risk | Posts can be skimmed or become status reports | Can turn into long problem-solving; late joiners |

**Recommendation:** use async as the default, with the short overlap call only when a blocker is raised, as in today's AIR-203 case. This keeps the benefits of both.
