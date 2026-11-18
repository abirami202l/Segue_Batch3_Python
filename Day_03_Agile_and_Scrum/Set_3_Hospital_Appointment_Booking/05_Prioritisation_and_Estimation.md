# Set 3 – Prioritisation and Estimation

## 1. Business value versus effort
The Product Owner considers patient benefit, operational impact and the effort required. The categories below are qualitative planning aids, not financial calculations.

| Business value | Effort | Suggested order |
|---|---|---|
| High value, low effort | Quick wins | Implement early where dependencies permit. |
| High value, high effort | Major investments | Plan early and split/refine where needed. |
| Low value, low effort | Fill-in work | Consider when capacity is available. |
| Low value, high effort | Lowest priority | Defer unless new evidence changes the value. |

## 2. Prioritised backlog and Planning Poker estimates

| Story ID | Epic | User story | Business priority | Business value | Effort (points) |
|---|---|---|---|---|---:|
| HOSP-01 | Booking | As a patient, I want to view the list of available departments so that I can choose the type of care I need. | Must | High | 5 |
| HOSP-02 | Booking | As a patient, I want to view doctors in a selected department so that I can choose a suitable doctor. | Must | High | 3 |
| HOSP-03 | Booking | As a patient, I want to view a doctor's available appointment slots so that I can select a convenient time. | Must | High | 5 |
| HOSP-04 | Booking | As a patient, I want to book an available appointment slot so that I can reserve a consultation. | Must | High | 8 |
| HOSP-05 | Booking | As a patient, I want to view my booking confirmation so that I can check the appointment details. | Must | High | 2 |
| HOSP-06 | Rescheduling and Cancellation | As a patient, I want to view my upcoming appointments so that I can identify a booking I need to change. | Must | High | 3 |
| HOSP-07 | Rescheduling and Cancellation | As a patient, I want to reschedule an eligible appointment to an available slot so that I can attend at a more suitable time. | Should | Medium | 5 |
| HOSP-08 | Rescheduling and Cancellation | As a patient, I want to cancel an eligible appointment so that the slot can be made available to another patient. | Must | High | 3 |
| HOSP-09 | Reminders | As a patient, I want to receive an appointment reminder before my visit so that I do not forget the scheduled consultation. | Should | Medium | 5 |
| HOSP-10 | Reminders | As a patient, I want to view the date and time in my reminder so that I can prepare for the correct appointment. | Should | Medium | 2 |
| HOSP-11 | Doctor Schedule Management | As a doctor, I want to view my upcoming appointment schedule so that I can prepare for my consultations. | Should | Medium | 5 |
| HOSP-12 | Doctor Schedule Management | As authorised hospital staff, I want to mark a time slot unavailable so that patients cannot book a time when the doctor is not available. | Must | High | 5 |
| HOSP-13 | Doctor Schedule Management | As authorised hospital staff, I want to add available appointment slots so that patients can book newly opened consultation times. | Could | Low | 3 |
| HOSP-14 | Doctor Schedule Management | As a doctor, I want to view the number of appointments scheduled for a day so that I can understand my daily workload. | Could | Low | 2 |

The story point values use the Fibonacci-like scale **1, 2, 3, 5, 8, 13**. The backlog is ordered first around the core patient booking journey, followed by appointment management and schedule/reminder enhancements. Business priority is not identical to effort: a high-value story can still require more points.

## 3. Planning Poker example
For **HOSP-04 – Book an available appointment slot**, suppose the first estimates are 5, 8, 8 and 13. The Developer choosing 13 is concerned about preventing two patients from booking the same slot. The Developer choosing 5 believes the hospital's scheduling service already provides a reliable reservation check. After discussion, the team confirms that the story must re-check availability at confirmation and prevent duplicate booking, but does not include payment or complex waitlists. The team agrees **8 points**.

The agreed estimates in the backlog are:
- HOSP-01 5
- HOSP-02 3
- HOSP-03 5
- HOSP-04 8
- HOSP-05 2
- HOSP-06 3
- HOSP-07 5
- HOSP-08 3
- HOSP-09 5
- HOSP-10 2
- HOSP-11 5
- HOSP-12 5
- HOSP-13 3
- HOSP-14 2

**Total backlog estimate = 56 story points.**

## 4. Story points versus hours

| Story points | Hours |
|---|---|
| Relative measure of effort, complexity and uncertainty. | Measure of elapsed or labour time. |
| Estimated collaboratively by comparing stories. | Often estimated by considering specific tasks and availability. |
| Not directly convertible into a fixed number of hours. | Can vary by person, interruptions and working conditions. |
| Useful for forecasting based on the team's past completed points. | Useful for scheduling and operational time tracking when needed. |

For example, an 8-point story does not mean eight hours. Two stories with the same points may take different amounts of calendar time. The team should use its actual Sprint history to understand its capacity rather than applying a universal points-to-hours conversion.
