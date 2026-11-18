
# Set 2 – Retail Banking Transaction Review

## Task 1: Binary Search and Linear Search

A sorted list of 100,000 transaction IDs is used.

Binary Search:
- Best case: O(1)
- Average case: O(log n)
- Worst case: O(log n)

Linear Search:
- Best case: O(1)
- Average case: O(n)
- Worst case: O(n)

Space Complexity: O(1) for both iterative algorithms.

Binary Search requires sorted data.

## Task 2: Insertion Sort and Merge Sort

Insertion Sort:
- Best: O(n)
- Average: O(n²)
- Worst: O(n²)
- Space: O(1)

Merge Sort:
- Best: O(n log n)
- Average: O(n log n)
- Worst: O(n log n)
- Space: O(n)

Both algorithms are stable in the implementations provided.

Stability means equal timestamps retain their original relative order.

This is important for financial statements because transactions
with identical timestamps should maintain their original sequence.

## Task 3: Duplicate Transaction Detection

A Dictionary (Hash Table) is used.

Duplicate conditions:
- Same account.
- Same amount.
- Same merchant.
- Posted within 60 seconds.

Average Time Complexity: O(n).
Space Complexity: O(n).

## Task 4: Queue and Stack

Queue:
- FIFO (First In, First Out).
- Used for manual transaction review.

Stack:
- LIFO (Last In, First Out).
- Used to reverse the last adjustment.

Array-based Queue:
- Enqueue: O(1)
- Dequeue: O(n)

Stack:
- Push: O(1)
- Pop: O(1)

Python deque improves queue performance:
- Enqueue: O(1)
- Dequeue: O(1)

## Task 5: Divide and Conquer

The transaction amounts are divided into smaller sections.

Each section calculates:
- Minimum amount.
- Maximum amount.

The results are combined.

Divide and Conquer:
- Time: O(n)
- Auxiliary Space: O(log n) recursion stack.

Brute Force:
- Time: O(n)
- Space: O(1).

Both methods produce the same minimum and maximum values.
Divide and conquer can reduce the number of comparisons compared
with a separate minimum scan and maximum scan.
