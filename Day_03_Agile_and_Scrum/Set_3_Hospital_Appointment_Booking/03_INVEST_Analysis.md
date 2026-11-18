# Set 3 – INVEST Analysis

## INVEST review of all 14 stories

| Story ID | Result | Explanation |
|---|---|---|
| HOSP-01 | Pass | Department listing is a small, independent discovery capability. |
| HOSP-02 | Pass | Doctor listing within a selected department is a clear customer outcome. |
| HOSP-03 | Pass | Availability display can be tested against a defined schedule. |
| HOSP-04 | Pass | Booking one available slot is bounded and has a measurable result. |
| HOSP-05 | Pass | Confirmation display is independently demonstrable after booking. |
| HOSP-06 | Pass | Upcoming appointment list is a focused patient-facing view. |
| HOSP-07 | Pass | Rescheduling one eligible appointment is distinct from cancellation. |
| HOSP-08 | Pass | Cancellation has clear eligibility rules and a visible result. |
| HOSP-09 | Pass | A reminder is a discrete notification outcome with a defined trigger. |
| HOSP-10 | Pass | Displaying appointment date and time is small and testable. |
| HOSP-11 | Pass | A doctor's own schedule view is a focused role-based capability. |
| HOSP-12 | Pass | Marking a slot unavailable has a clear effect on patient booking. |
| HOSP-13 | Pass | Adding available slots is a separate staff-facing outcome. |
| HOSP-14 | Pass | A daily appointment count is a small, measurable view. |

All stories pass the refined INVEST review. Some stories depend on schedule information or an existing appointment, but they remain independently estimable backlog items when those assumptions and sequencing constraints are recorded.

## Refinement of stories that could be too broad
A broad initial story such as **“As a patient, I want to manage appointments so that I can control my visits”** is not sufficiently independent or testable. It has been replaced with three specific outcomes:
- **HOSP-06:** View upcoming appointments.
- **HOSP-07:** Reschedule an eligible appointment.
- **HOSP-08:** Cancel an eligible appointment.

A broad initial story such as **“As a hospital, I want to manage doctor schedules”** has also been refined:
- **HOSP-11:** Doctor views upcoming appointments.
- **HOSP-12:** Authorised staff marks a slot unavailable.
- **HOSP-13:** Authorised staff adds available slots.
- **HOSP-14:** Doctor views a daily appointment count.

These are vertical slices because each produces a usable view or action for a real user. They are not divided into technical layers.

## INVEST checklist interpretation
- **Independent:** Each story has a defined outcome and can be planned as a separate backlog item.
- **Negotiable:** The team can discuss screen design, reminder channel and schedule rules without changing the user benefit.
- **Valuable:** Every story supports patient convenience or hospital scheduling.
- **Estimable:** Scope and assumptions are clear enough for relative sizing.
- **Small:** Stories focus on one action or information outcome.
- **Testable:** The team can verify the displayed information, booking result or schedule change.
