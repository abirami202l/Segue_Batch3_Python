
import random
import time
from collections import deque
from datetime import datetime, timedelta

# TASK 1: BINARY SEARCH AND LINEAR SEARCH


transaction_ids = list(range(100001, 200001))

def linear_search(arr, target):
    comparisons = 0

    for item in arr:
        comparisons += 1
        if item == target:
            return comparisons

    return comparisons


def binary_search(arr, target):
    low = 0
    high = len(arr) - 1
    comparisons = 0

    while low <= high:
        mid = (low + high) // 2
        comparisons += 1

        if arr[mid] == target:
            return comparisons

        elif arr[mid] < target:
            low = mid + 1

        else:
            high = mid - 1

    return comparisons


print("Best Case Binary:",
      binary_search(transaction_ids, 150001))

print("Average Example Binary:",
      binary_search(transaction_ids, 175000))

print("Worst Case Binary:",
      binary_search(transaction_ids, 200000))

print("Linear Search:",
      linear_search(transaction_ids, 200000))


# TASK 2: INSERTION SORT AND MERGE SORT

transactions = [
    {"id": 1, "date": "2026-11-18 10:00:00", "amount": 500},
    {"id": 2, "date": "2026-11-18 09:00:00", "amount": 200},
    {"id": 3, "date": "2026-11-18 11:00:00", "amount": 800},
    {"id": 4, "date": "2026-11-18 09:00:00", "amount": 300},
    {"id": 5, "date": "2026-11-18 12:00:00", "amount": 100}
]

def insertion_sort(data):
    arr = data.copy()

    for i in range(1, len(arr)):
        key = arr[i]
        j = i - 1

        while j >= 0 and arr[j]["date"] > key["date"]:
            arr[j + 1] = arr[j]
            j -= 1

        arr[j + 1] = key

    return arr


def merge_sort(data):
    if len(data) <= 1:
        return data

    mid = len(data) // 2

    left = merge_sort(data[:mid])
    right = merge_sort(data[mid:])

    result = []
    i = j = 0

    while i < len(left) and j < len(right):
        if left[i]["date"] <= right[j]["date"]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1

    result.extend(left[i:])
    result.extend(right[j:])

    return result


print("Insertion Sort:")
print(insertion_sort(transactions))

print("Merge Sort:")
print(merge_sort(transactions))


# TASK 3: DUPLICATE TRANSACTION DETECTION

def detect_duplicate_transactions(data):
    seen = {}
    duplicates = []

    for transaction in data:
        timestamp = datetime.strptime(
            transaction["time"],
            "%Y-%m-%d %H:%M:%S"
        )

        key = (
            transaction["account"],
            transaction["amount"],
            transaction["merchant"]
        )

        if key in seen:
            previous_time = seen[key]

            difference = abs(
                (timestamp - previous_time).total_seconds()
            )

            if difference <= 60:
                duplicates.append(transaction)
            else:
                seen[key] = timestamp
        else:
            seen[key] = timestamp

    return duplicates


sample_transactions = [
    {
        "account": "A101",
        "amount": 500,
        "merchant": "ABC Store",
        "time": "2026-11-18 10:00:00"
    },
    {
        "account": "A101",
        "amount": 500,
        "merchant": "ABC Store",
        "time": "2026-11-18 10:00:40"
    },
    {
        "account": "A102",
        "amount": 300,
        "merchant": "XYZ Store",
        "time": "2026-11-18 11:00:00"
    }
]

print("Duplicate Transactions:")
print(detect_duplicate_transactions(sample_transactions))


# TASK 4: STACK AND QUEUE FROM SCRATCH


class Stack:
    def __init__(self):
        self.items = []

    def push(self, item):
        self.items.append(item)

    def pop(self):
        if len(self.items) == 0:
            return None
        return self.items.pop()

    def display(self):
        print(self.items)


class Queue:
    def __init__(self):
        self.items = []

    def enqueue(self, item):
        self.items.append(item)

    def dequeue(self):
        if len(self.items) == 0:
            return None
        return self.items.pop(0)

    def display(self):
        print(self.items)


# Manual review queue
review_queue = Queue()

review_queue.enqueue("Transaction 101")
review_queue.enqueue("Transaction 102")
review_queue.enqueue("Transaction 103")

print("Review Queue:")
review_queue.display()

print("Processed:",
      review_queue.dequeue())


# Reverse last adjustment using Stack
adjustment_stack = Stack()

adjustment_stack.push("Adjustment 100")
adjustment_stack.push("Adjustment 200")
adjustment_stack.push("Adjustment 300")

print("Reversed Adjustment:",
      adjustment_stack.pop())


# Built-in equivalents
builtin_queue = deque(["Transaction 101", "Transaction 102"])
print("Built-in Queue:", builtin_queue.popleft())

builtin_stack = ["Adjustment 100", "Adjustment 200"]
print("Built-in Stack:", builtin_stack.pop())

# TASK 5: DIVIDE AND CONQUER MINIMUM AND MAXIMUM


amounts = [
    random.randint(100, 10000)
    for _ in range(10000)
]

def find_min_max(arr, low, high):
    if low == high:
        return arr[low], arr[low]

    if high == low + 1:
        return min(arr[low], arr[high]), max(arr[low], arr[high])

    mid = (low + high) // 2

    left_min, left_max = find_min_max(arr, low, mid)
    right_min, right_max = find_min_max(arr, mid + 1, high)

    return min(left_min, right_min), max(left_max, right_max)


start = time.perf_counter()

minimum, maximum = find_min_max(
    amounts, 0, len(amounts) - 1
)

print("Divide and Conquer Minimum:", minimum)
print("Divide and Conquer Maximum:", maximum)
print("Divide and Conquer Time:",
      time.perf_counter() - start)


# Brute-force comparison
start = time.perf_counter()

brute_min = amounts[0]
brute_max = amounts[0]

for value in amounts:
    if value < brute_min:
        brute_min = value

    if value > brute_max:
        brute_max = value

print("Brute Force Minimum:", brute_min)
print("Brute Force Maximum:", brute_max)
print("Brute Force Time:",
      time.perf_counter() - start)
