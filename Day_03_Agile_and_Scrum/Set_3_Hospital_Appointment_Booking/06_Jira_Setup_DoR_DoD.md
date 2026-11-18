# Set 3 – Jira Setup, Definition of Ready and Definition of Done

## 1. Jira project and Scrum board
1. Select **Projects → Create project**.
2. Choose the **Scrum** template and create a project named *Hospital Appointment Booking* with key **HOSP**.
3. Open the Scrum board and check that the Backlog and Active Sprint views are available.
4. Ensure **Epic**, **Story**, **Task** and **Bug** issue types are available.
5. Add the Product Owner, Scrum Master and Developers to the project with suitable permissions.
6. Configure board columns to match the team's workflow, for example **To Do → In Progress → In Review → Done**.

## 2. Create epics
Create these four Epic issues and describe the intended outcome:
- **HOSP-E1 – Booking:** Patients find doctors and reserve appointment slots.
- **HOSP-E2 – Rescheduling and Cancellation:** Patients manage existing appointments.
- **HOSP-E3 – Reminders:** Patients receive useful pre-visit information.
- **HOSP-E4 – Doctor Schedule Management:** Doctors and authorised staff view and maintain availability.

## 3. Create story issues and enter fields
For each of HOSP-01 to HOSP-14, create a **Story** issue and enter:
- **Summary:** Short action-oriented title, such as “Book an available appointment slot”.
- **Description:** Complete user story in the “As a… I want… so that…” format.
- **Epic Link / Parent:** Select the matching epic.
- **Priority:** Use the agreed business priority (High, Medium or Low) and keep it consistent with the backlog.
- **Story Points:** Enter the Planning Poker estimate.
- **Acceptance criteria:** Add the Given/When/Then scenarios to the description or acceptance-criteria field.
- **Assignee:** Normally leave open for Developers to organise during Sprint Planning unless the team has agreed otherwise.
- **Labels/components:** Use only if they help the team filter work, for example `booking`, `reminders` or `schedule`.

Jira creates its own issue keys. Keep HOSP-01 to HOSP-14 as assignment reference IDs in the summary or a custom field if required; do not assume Jira will generate those exact keys.

## 4. Definition of Ready (DoR)
A story can be selected for a Sprint when:
- [ ] The story names a clear user, action and benefit.
- [ ] It is linked to the correct epic and product outcome.
- [ ] Acceptance criteria are specific, observable and testable.
- [ ] Appointment, cancellation or schedule rules relevant to the story are explained.
- [ ] Dependencies and assumptions are visible.
- [ ] The story is small enough to complete within one Sprint.
- [ ] The Developers understand the story and can estimate it.
- [ ] Required stakeholder questions have been answered.
- [ ] The Product Owner has ordered the story in the Product Backlog.

## 5. Definition of Done (DoD)
A story is Done only when:
- [ ] All acceptance criteria pass.
- [ ] The implementation is integrated into the shared application build.
- [ ] Code has been reviewed.
- [ ] Relevant functional and regression tests pass.
- [ ] Booking logic prevents duplicate reservations for the same slot.
- [ ] Patient information is shown only to authorised users.
- [ ] Reminder content contains the correct appointment date and time.
- [ ] No known critical defect remains open for the story.
- [ ] User-facing messages are understandable and accessible.
- [ ] The increment works with completed features and is demonstrated as usable.

## 6. Backlog publication and Sprint use
The Product Owner creates and orders the epics and stories in the Jira backlog. Developers refine the stories, add estimates and discuss dependencies. During Sprint Planning, the team selects ready items that support the Sprint Goal. Developers move issues across the workflow as work progresses. At the Sprint Review, stakeholders inspect the Increment and provide feedback; the Sprint Retrospective is used to identify improvements.

*This is an instructional Jira setup. It does not state that a live Jira project has been created.*
