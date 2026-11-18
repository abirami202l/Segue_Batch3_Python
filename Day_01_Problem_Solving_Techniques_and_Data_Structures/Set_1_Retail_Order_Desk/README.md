
# Set 1 – Retail Order Desk

## Task 1: Linear Search and Binary Search

Linear Search checks each order one by one.

Binary Search repeatedly divides a sorted list into two halves.

Time Complexity:
- Linear Search: O(n)
- Binary Search: O(log n)

Space Complexity:
- Linear Search: O(1)
- Binary Search: O(1)

Binary Search is faster for large sorted datasets.

## Task 2: Sorting Algorithms

Algorithms:
1. Bubble Sort – O(n²)
2. Merge Sort – O(n log n)
3. Python Built-in Sort – O(n log n) worst case

Orders are sorted by amount in descending order.

Bubble Sort performs repeated adjacent comparisons.
Merge Sort divides the list and merges sorted halves.

First three Bubble Sort passes:
- Pass 1: Largest amount moves to the beginning.
- Pass 2: Second-largest amount moves into position.
- Pass 3: Third-largest amount moves into position.

## Task 3: Duplicate Detection

A Python Set is used to identify duplicate orders.

Duplicate condition:
- Same customer ID.
- Same amount.
- Same creation minute.

Time Complexity: O(n) average.
Space Complexity: O(n).

## Task 4: Stack and Queue

Stack:
- Follows LIFO.
- Used for undoing order edits.
- Push: O(1)
- Pop: O(1)

Queue:
- Follows FIFO.
- Used for warehouse dispatch.
- Enqueue: O(1) with deque.
- Dequeue: O(1) with deque.

## Task 5: Refund Calculation

Greedy Algorithm:
Selects the largest possible denomination first.

Dynamic Programming:
Finds the minimum number of denominations.

Example:
Denominations = [1, 3, 4]
Refund Amount = 6

Greedy:
4 + 1 + 1 = 3 coins

Dynamic Programming:
3 + 3 = 2 coins

Therefore, greedy does not always produce an optimal result.

DP Time Complexity: O(amount × number of coins).
DP Space Complexity: O(amount).
