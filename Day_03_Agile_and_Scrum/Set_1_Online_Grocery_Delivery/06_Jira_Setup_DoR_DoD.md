# Set 1 – Jira Setup, Definition of Ready and Definition of Done

## 1. Create the Jira project and Scrum board
1. In Jira, choose **Projects → Create project**.
2. Select the **Scrum** project template and choose a project name such as *Online Grocery Delivery* with key **GROC**.
3. Create or open the Scrum board associated with the project. Confirm that the backlog and active Sprint views are available.
4. Configure issue types so that **Epic** and **Story** are available. Keep the standard Task and Bug types if the team needs them.
5. Set the workflow columns to reflect the team's actual process, for example **To Do → In Progress → In Review → Done**.
6. Add team members with suitable project permissions. The Product Owner should be able to order the backlog; Developers should be able to update their work.

## 2. Enter epics
Create three Epic issues:
- **Epic name:** Browse and Search; **Epic key:** GROC-E1; **Summary:** Enable customers to discover grocery products.
- **Epic name:** Cart and Checkout; **Epic key:** GROC-E2; **Summary:** Enable customers to prepare and complete grocery orders.
- **Epic name:** Delivery Tracking; **Epic key:** GROC-E3; **Summary:** Enable customers to confirm and follow their orders.

In Jira, enter the epic name/summary and a description of the outcome. Add acceptance notes or business context in the description where useful.

## 3. Enter stories
For each story, create an issue with:
- **Issue type:** Story
- **Summary:** A short action-oriented title, such as “View grocery categories”
- **Description:** Paste the complete “As a… I want… so that…” statement
- **Epic Link / Parent:** Select the correct epic
- **Priority:** Map Must Have to Highest/High, Should Have to Medium, and Could Have to Low (agree one mapping with the team)
- **Story points:** Enter the agreed estimate in the Story Points field
- **Acceptance criteria:** Add the Given/When/Then conditions to the description or the team's dedicated acceptance-criteria field
- **Labels/components:** Add a component only if the team uses one consistently

Create the 12 story issues using IDs GROC-01 to GROC-12 in the summary or a custom reference field if the Jira project supports it. Jira will generate its own issue keys; do not assume it will automatically generate the exact IDs listed in this assignment.

## 4. Definition of Ready (DoR)
A story is ready to be considered for Sprint Planning when:
- [ ] The user story identifies a user, functionality and benefit.
- [ ] The correct epic and business outcome are recorded.
- [ ] Acceptance criteria are specific and testable.
- [ ] Dependencies and external assumptions are identified.
- [ ] The story is small enough to complete within a Sprint.
- [ ] The team understands the story and can estimate it.
- [ ] Required product, pricing or delivery rules are available.
- [ ] The Product Owner has ordered the story in the backlog.

## 5. Definition of Done (DoD)
A story is Done only when:
- [ ] All agreed acceptance criteria pass.
- [ ] The implementation is integrated into the shared product branch/build.
- [ ] Code has been reviewed by another team member.
- [ ] Relevant automated and manual tests pass.
- [ ] No known critical or high-severity defect remains open for the story.
- [ ] User-facing text and validation messages are checked.
- [ ] The increment works with the existing application without breaking completed features.
- [ ] The Product Owner or agreed acceptance process confirms the result.

## 6. Backlog and Sprint use
The Product Owner orders the backlog before Sprint Planning. During Sprint Planning, the Scrum Team selects ready stories that support a Sprint Goal and fit the team's capacity. Developers update issue status during the Sprint and inspect progress in the Daily Scrum. The team reviews the Done Increment with stakeholders at the Sprint Review and improves its working practices at the Sprint Retrospective.

*This document describes a proposed Jira configuration. It does not claim that a Jira project has been created.*
