# Set 3 – Task 1: Sprint Plan and Sprint Goal (Velocity 30)

> **Data note:** The assignment's "supplied backlog" was not included. Backlog LRN-301 to LRN-309 is **illustrative**. Velocity of 30 points is from the assignment.

## Product backlog (priority order)

| Rank | Key | Story | Points |
|---|---|---|---|
| 1 | LRN-301 | As a learner, I search the course catalogue | 5 |
| 2 | LRN-302 | As a learner, I watch lessons and resume where I stopped | 8 |
| 3 | LRN-303 | As a learner, I submit a quiz and see my score | 5 |
| 4 | LRN-304 | As a learner, I see my course progress dashboard | 5 |
| 5 | LRN-309 | As a learner, I get a notification when my quiz is graded | 5 |
| 6 | LRN-307 | As a learner, I rate a course | 2 |
| 7 | LRN-308 | As a learner, I reset my password | 3 |
| 8 | LRN-306 | As a learner, I post in a discussion forum | 8 |
| 9 | LRN-305 | As an instructor, I upload course videos | 8 |

## Sprint selection (capacity 30)

| Key | Story | Points | Running total |
|---|---|---|---|
| LRN-301 | Catalogue search | 5 | 5 |
| LRN-302 | Video playback with resume | 8 | 13 |
| LRN-303 | Quiz submission and scoring | 5 | 18 |
| LRN-304 | Progress dashboard | 5 | 23 |
| LRN-309 | Quiz-graded notification | 5 | 28 |
| LRN-307 | Course rating | 2 | **30** |

5 + 8 + 5 + 5 + 5 + 2 = **30 points** = velocity. Not selected: LRN-308 (3), LRN-306 (8), LRN-305 (8): lower priority and would exceed capacity.

## Sprint Goal

> **By Day 10, a learner can find a course, watch its lessons with resume, take a quiz and see their progress, with all flows passing automated tests.**

LRN-309 (notification) and LRN-307 (rating) support the experience but are **not** needed for the goal, so they are the first candidates to trade off if scope changes (used in Task 2).

## Jira setup
- Sprint: *LRN Sprint 12* (10 days), 6 stories, 30 points.
- Each story has acceptance criteria and sub-tasks (design, build, unit test, QA, review).
- See `Screenshots/Set_3_Jira_Board.png`.
