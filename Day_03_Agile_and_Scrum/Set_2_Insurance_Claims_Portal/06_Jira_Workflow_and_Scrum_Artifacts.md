# Set 2 – Jira Workflow and Scrum Artifacts

## 1. Jira project and board setup
1. Select **Projects → Create project** in Jira.
2. Choose the **Scrum** template and name the project *Insurance Claims Portal* with key **INS**.
3. Open the project's Scrum board and confirm that Backlog and Active Sprint views are available.
4. Configure issue types **Epic**, **Story**, **Task** and **Bug** as required.
5. Add the Scrum Team and assign appropriate permissions. The Product Owner orders the backlog; Developers update the status of their work.
6. Configure the board columns to match the workflow below.

## 2. Workflow states

| State | Meaning | Typical transition |
|---|---|---|
| To Do | The story is selected or ready but work has not started. | To Do → In Progress |
| In Progress | Developers are actively implementing or testing the story. | In Progress → In Review |
| In Review | The work is being reviewed and checked against acceptance criteria. | In Review → Done, or back to In Progress |
| Done | The story meets the Definition of Done and its acceptance criteria. | Terminal state for the completed work |

A Jira administrator may need to configure the workflow and map each status to a board column. The team should not move a story to Done merely because coding has finished.

## 3. Epic and story issue details
Create four Epic issues:
- **INS-E1 – Claim Registration:** Register a claim and confirm its submission.
- **INS-E2 – Document Upload:** Show required evidence and support document submission.
- **INS-E3 – Claim Tracking:** Display progress and customer actions.
- **INS-E4 – Settlement Notifications:** Inform customers about status, decisions and payment.

For each of the 14 Story issues, enter:
- **Issue type:** Story
- **Summary:** Short verb-led title, such as “Start a new claim”
- **Description:** Full “As a… I want… so that…” statement
- **Epic Link / Parent:** The correct epic listed above
- **Priority:** Set according to the Product Owner's agreed order
- **Story Points:** The agreed Planning Poker value
- **Acceptance criteria:** Given/When/Then conditions in the description or dedicated field
- **Assignee:** Leave unassigned until the team plans the work, unless the team has an agreed practice
- **Labels:** Optional tags such as `claims`, `documents` or `notifications`

The assignment IDs INS-01 to INS-14 are reference identifiers. Jira creates its own issue keys when issues are saved.

## 4. Definition of Done
A story is Done when:
- [ ] All acceptance criteria pass.
- [ ] The change is integrated into the shared application build.
- [ ] Code has been reviewed.
- [ ] Relevant functional and regression tests pass.
- [ ] Access control ensures customers can only view their own claim information.
- [ ] Uploaded documents are handled according to the agreed privacy and security rules.
- [ ] No known critical defect remains open for the story.
- [ ] Customer-facing messages are clear and accurate.
- [ ] The increment is usable and does not break previously completed functionality.
- [ ] The Product Owner or agreed acceptance process confirms the story.

## 5. One-page note: Scrum roles, events and artifacts

### Scrum roles (accountabilities)
- **Product Owner:** Maximises product value, communicates the Product Goal and orders the Product Backlog. For this portal, the Product Owner balances policyholder needs, claims operations and compliance priorities.
- **Scrum Master:** Helps everyone understand and apply Scrum, coaches the team and helps remove impediments. The Scrum Master does not assign individual tasks.
- **Developers:** Build a usable Increment each Sprint and are accountable for creating the Sprint plan and adapting it daily. Developers may include design, development, testing and security skills.

### Scrum events
- **Sprint:** A fixed-length event of one month or less in which the team works toward a Sprint Goal and creates an Increment.
- **Sprint Planning:** The team discusses why the Sprint is valuable, what can be Done and how the work will be completed.
- **Daily Scrum:** A 15-minute event for Developers to inspect progress toward the Sprint Goal and adapt the plan.
- **Sprint Review:** The Scrum Team and stakeholders inspect the Increment and discuss changes in the environment and future backlog priorities.
- **Sprint Retrospective:** The Scrum Team identifies improvements to quality and effectiveness for the next Sprint.

### Scrum artifacts and commitments
- **Product Backlog – Product Goal:** An ordered, evolving list of work needed to improve the portal. The Product Goal describes the product's future objective.
- **Sprint Backlog – Sprint Goal:** The selected Product Backlog items, the plan for delivering them and the Sprint Goal. It is updated by Developers as they learn.
- **Increment – Definition of Done:** The usable, integrated result of completed work. The Definition of Done is the shared quality standard that an Increment must meet.

*This is a proposed configuration and learning note. No live Jira project has been created.*
