# Day 1 – Problem Solving Techniques and Data Structures – I

## Overall Summary

This practical covers three business scenarios: Retail Order Desk, Retail Banking Transaction Review, and Hospital Appointment Desk.

The main concepts include searching, sorting, hashing, stacks, queues, greedy algorithms, dynamic programming, and divide-and-conquer techniques.

---

# Set 1 – Retail Order Desk

### Business Scenario
An online retailer processes approximately 50,000 orders daily. The system needs fast order searching, sorting orders by amount, detecting duplicate orders, managing order edits and dispatch, and calculating minimum refund denominations.

### Tasks and Solutions

**1. Linear Search and Binary Search**
- Linear Search checks each order one by one.
- Binary Search searches a sorted list by repeatedly dividing it into halves.
- Binary Search is faster for large sorted datasets.

**2. Sorting Algorithms**
- Bubble Sort: Sorts orders by amount in descending order.
- Merge Sort: Divides and merges sorted portions.
- Python Built-in Sort: Used for performance comparison.

**3. Duplicate Order Detection**
- Uses a Hash Set.
- Detects orders with the same customer ID, amount, and creation minute.
- Provides efficient duplicate detection.

**4. Stack and Queue**
- Stack follows LIFO (Last In, First Out).
- Used for undoing the last order edit.
- Queue follows FIFO (First In, First Out).
- Used for warehouse dispatch.

**5. Refund Calculation**
- Greedy Algorithm selects the largest denomination first.
- Dynamic Programming finds the minimum number of denominations.
- Example: Denominations [1, 3, 4], amount 6.
- Greedy result: 4 + 1 + 1 = 3 coins.
- DP result: 3 + 3 = 2 coins.

### Complexity Analysis

| Algorithm | Time Complexity |
|---|---|
| Linear Search | O(n) |
| Binary Search | O(log n) |
| Bubble Sort | O(n²) |
| Merge Sort | O(n log n) |
| Duplicate Detection | O(n) average |
| Stack Push/Pop | O(1) |
| Queue with List | O(n) dequeue |
| Greedy Change | O(k log k + A) |
| Dynamic Programming | O(A × k) |

---

# Set 2 – Retail Banking Transaction Review

### Business Scenario
A retail bank reviews daily card transactions. The system requires quick transaction searches, sorted customer statements, duplicate transaction detection, transaction review management, and minimum/maximum transaction calculations.

### Tasks and Solutions

**1. Binary Search and Linear Search**
- Searches a sorted list of 100,000 transaction IDs.
- Counts comparisons for best, average, and worst cases.
- Binary Search requires O(log n) time in average and worst cases.
- Linear Search requires O(n) time in the worst case.

**2. Insertion Sort and Merge Sort**
- Insertion Sort arranges transactions by posting date.
- Merge Sort sorts transactions efficiently.
- Both implementations are stable.
- Stability preserves the original order of transactions with equal timestamps.

**3. Duplicate Transaction Detection**
- Uses a Hash Table (Dictionary).
- Detects transactions with the same account, amount, and merchant within 60 seconds.
- Provides efficient lookup.

**4. Queue and Stack**
- Queue models the manual-review backlog.
- Stack models reversing the last adjustment.
- Queue follows FIFO.
- Stack follows LIFO.

**5. Divide and Conquer**
- Divides transaction amounts into smaller sections.
- Finds the minimum and maximum in each section.
- Combines the results.
- Compares the result with a brute-force scan.

### Complexity Analysis

| Algorithm | Time Complexity |
|---|---|
| Linear Search | O(n) |
| Binary Search | O(log n) |
| Insertion Sort | O(n²) |
| Merge Sort | O(n log n) |
| Duplicate Detection | O(n) average |
| Stack Push/Pop | O(1) |
| Queue with List | O(n) dequeue |
| Divide and Conquer Min/Max | O(n) |
| Brute Force Min/Max | O(n) |

---

# Set 3 – Hospital Appointment Desk

### Business Scenario
A multi-speciality hospital manages patient appointments. The system requires quick patient searches, appointment sorting by urgency, duplicate booking prevention, walk-in token management, and appointment scheduling.

### Tasks and Solutions

**1. Linear Search and Binary Search**
- Searches 20,000 patient records using patient ID.
- Performs 1,000 lookups.
- Measures and compares execution time.
- Binary Search is more efficient for sorted records.

**2. Selection Sort and Quick Sort**
- Selection Sort arranges appointments by urgency and arrival time.
- Quick Sort uses a pivot to divide and sort appointments.
- Compares swaps and execution time.

**3. Double-Booking Detection**
- Uses a Hash Set.
- Checks whether the same patient has already booked the same time slot.
- Provides faster lookup than repeatedly scanning a list.

**4. Queue and Stack**
- Queue manages walk-in patient tokens.
- Stack maintains recently viewed patient history.
- Queue follows FIFO.
- Stack follows LIFO.

**5. Dynamic Programming**
- Finds the maximum number of non-overlapping appointments a doctor can attend during a shift.
- Compares Dynamic Programming with a Greedy Algorithm.
- Uses previous compatible appointments to calculate the maximum appointment count.

### Complexity Analysis

| Algorithm | Time Complexity |
|---|---|
| Linear Search | O(n) |
| Binary Search | O(log n) |
| Selection Sort | O(n²) |
| Quick Sort | O(n log n) average |
| Double-Booking Detection | O(n) average |
| Stack Push/Pop | O(1) |
| Queue with List | O(n) dequeue |
| Appointment DP | O(n²) |

---

# Overall Conclusion

This practical demonstrates how different algorithms and data structures solve real-world business problems.

The three scenarios show the importance of choosing the correct algorithm based on data size, performance requirements, and application needs.

### Key Learnings

1. Searching algorithms help retrieve records efficiently.
2. Sorting algorithms organize data for better processing.
3. Hash Tables and Sets provide efficient duplicate detection.
4. Stacks are useful for undo operations and history management.
5. Queues are useful for managing tasks in arrival order.
6. Greedy Algorithms provide quick solutions but may not always be optimal.
7. Dynamic Programming solves optimization problems by storing previous results.
8. Divide-and-Conquer techniques break complex problems into smaller subproblems.

**Final Result:** All three sets demonstrate the practical application of problem-solving techniques and data structures in retail, banking, and healthcare systems.