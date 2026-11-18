# Set 2 – Task 5: Sprint Review Agenda and Demonstration Script

> Stories and acceptance criteria are illustrative (no criteria were supplied).

## Sprint Review agenda (60 minutes)

| Time | Item | Lead |
|---|---|---|
| 0:00–0:05 | Welcome, Sprint Goal and what was committed (24 pts) | Product Owner |
| 0:05–0:10 | Impact of the payment-sandbox impediment (IMP-01) | Scrum Master |
| 0:10–0:40 | Live demo, story by story, against acceptance criteria | Developers |
| 0:40–0:45 | Status of the Sprint Goal and stories accepted/not accepted | Product Owner |
| 0:45–0:55 | Stakeholder feedback; backlog and release outlook | All |
| 0:55–1:00 | Next steps and next Sprint Planning date | Scrum Master |

## Demonstration script

### AIR-201 – Check-in via PNR (5 pts)
**Acceptance criteria:** AC1 valid PNR + last name opens the booking; AC2 invalid combination shows an error and no data is exposed; AC3 PNR lookup responds within 3 s.

| Step | Action | Expected result | AC |
|---|---|---|---|
| 1 | Enter PNR `ABC123` and last name `Kumar` | Booking and passenger list shown | AC1 |
| 2 | Enter a wrong last name | "We couldn't find this booking" message | AC2 |
| 3 | Show response time in network panel | < 3 s | AC3 |

### AIR-207 – Check-in window validation (3 pts)
**AC:** AC1 check-in is allowed from 48 h to 1 h before departure; AC2 outside the window the user sees the opening/closing time.

| Step | Action | Expected | AC |
|---|---|---|---|
| 1 | Open a flight departing in 24 h | Check-in allowed | AC1 |
| 2 | Open a flight departing in 72 h | Message "Check-in opens on …" | AC2 |

### AIR-202 – Seat selection (8 pts)
**AC:** AC1 seat map shows available/occupied seats; AC2 selected seat is held for the passenger; AC3 occupied seat cannot be chosen.

| Step | Action | Expected | AC |
|---|---|---|---|
| 1 | Open seat map | Colour-coded availability | AC1 |
| 2 | Select 14C | Seat shown as selected and reserved | AC2 |
| 3 | Click an occupied seat | Click is blocked with a tooltip | AC3 |

### AIR-203 – Seat upgrade with payment (8 pts)
**AC:** AC1 upgrade fee displayed before payment; AC2 successful payment confirms upgrade and updates the boarding pass; AC3 declined payment keeps the original seat and shows a retry option.

| Step | Action | Expected | AC |
|---|---|---|---|
| 1 | Choose an upgrade seat | Fee shown (e.g. ₹1,500) | AC1 |
| 2 | Pay with test card (success) | Confirmation; new seat on pass | AC2 |
| 3 | Pay with test card (decline) | Original seat kept; retry offered | AC3 |

**Demo condition for AIR-203:** Because of IMP-01, the demo must state clearly how it was verified.
- If it passed in the **real sandbox**, demo live and mark Done.
- If it was only tested against the **stub**, demo it as "work in progress" and **do not count the 8 points**. The story returns to the backlog with a task "verify in real sandbox".

## Review outcome record

| Story | Accepted by PO? | Points counted |
|---|---|---|
| AIR-201 | Yes / No (record at review) | 5 or 0 |
| AIR-202 | Yes / No | 8 or 0 |
| AIR-203 | Depends on the condition above | 8 or 0 |
| AIR-207 | Yes / No | 3 or 0 |

The outcome is recorded during the review, so no results are pre-filled here.
