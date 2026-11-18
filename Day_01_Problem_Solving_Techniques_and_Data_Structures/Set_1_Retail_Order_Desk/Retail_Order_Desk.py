import csv
import time
import random
from collections import deque


orders = [
    {
        "orderId": i,
        "customerId": random.randint(1, 1000),
        "amount": random.randint(100, 10000),
        "createdAt": "2026-11-18 10:30"
    }
    for i in range(1, 50001)
]


def linear_search(data, order_id):
    for order in data:
        if order["orderId"] == order_id:
            return order
    return None


def binary_search(data, order_id):
    low = 0
    high = len(data) - 1

    while low <= high:
        mid = (low + high) // 2

        if data[mid]["orderId"] == order_id:
            return data[mid]
        elif data[mid]["orderId"] < order_id:
            low = mid + 1
        else:
            high = mid - 1

    return None


target = 45000

start = time.perf_counter()
print("Linear Search:", linear_search(orders, target))
print("Linear Search Time:", time.perf_counter() - start)

start = time.perf_counter()
print("Binary Search:", binary_search(orders, target))
print("Binary Search Time:", time.perf_counter() - start)


def bubble_sort(data):
    arr = data.copy()
    n = len(arr)

    for i in range(n):
        for j in range(n - i - 1):
            if arr[j]["amount"] < arr[j + 1]["amount"]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]

    return arr


def merge_sort(data):
    if len(data) <= 1:
        return data

    mid = len(data) // 2

    left = merge_sort(data[:mid])
    right = merge_sort(data[mid:])

    result = []
    i = 0
    j = 0

    while i < len(left) and j < len(right):
        if left[i]["amount"] >= right[j]["amount"]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1

    result.extend(left[i:])
    result.extend(right[j:])

    return result


sample = orders[:10000]

start = time.perf_counter()
bubble_result = bubble_sort(sample)
print("Bubble Sort Time:", time.perf_counter() - start)

start = time.perf_counter()
merge_result = merge_sort(sample)
print("Merge Sort Time:", time.perf_counter() - start)

start = time.perf_counter()
builtin_result = sorted(
    sample,
    key=lambda x: x["amount"],
    reverse=True
)
print("Built-in Sort Time:", time.perf_counter() - start)

print("Top 3 Orders:", builtin_result[:3])


def detect_duplicates(data):
    seen = set()
    duplicates = []

    for order in data:
        minute = order["createdAt"][:16]

        key = (
            order["customerId"],
            order["amount"],
            minute
        )

        if key in seen:
            duplicates.append(order)
        else:
            seen.add(key)

    return duplicates


print("Duplicate Orders:", detect_duplicates(orders))


class Stack:
    def __init__(self):
        self.items = []

    def push(self, item):
        self.items.append(item)

    def pop(self):
        if not self.items:
            return None
        return self.items.pop()

    def peek(self):
        return self.items[-1] if self.items else None

    def display(self):
        print("Stack:", self.items)


class Queue:
    def __init__(self):
        self.items = []

    def enqueue(self, item):
        self.items.append(item)

    def dequeue(self):
        if not self.items:
            return None
        return self.items.pop(0)

    def display(self):
        print("Queue:", self.items)


undo_stack = Stack()

undo_stack.push("Order 101 edited")
undo_stack.push("Order 102 edited")

print("Undo:", undo_stack.pop())

dispatch_queue = Queue()

dispatch_queue.enqueue("Order 101")
dispatch_queue.enqueue("Order 102")
dispatch_queue.enqueue("Order 103")

print("Dispatch:", dispatch_queue.dequeue())

builtin_stack = []
builtin_stack.append("Edit 1")
builtin_stack.append("Edit 2")

print("Built-in Stack:", builtin_stack.pop())

builtin_queue = deque()
builtin_queue.append("Order 101")
builtin_queue.append("Order 102")

print("Built-in Queue:", builtin_queue.popleft())


def greedy_change(amount, coins):
    coins = sorted(coins, reverse=True)
    result = []

    for coin in coins:
        while amount >= coin:
            amount -= coin
            result.append(coin)

    if amount != 0:
        return None

    return result


def dp_change(amount, coins):
    dp = [float("inf")] * (amount + 1)
    dp[0] = 0

    for i in range(1, amount + 1):
        for coin in coins:
            if coin <= i:
                dp[i] = min(dp[i], dp[i - coin] + 1)

    if dp[amount] == float("inf"):
        return None

    result = []
    current = amount

    while current > 0:
        for coin in coins:
            if coin <= current and dp[current] == dp[current - coin] + 1:
                result.append(coin)
                current -= coin
                break

    return result


denominations = [1, 3, 4]
refund = 6

print("Greedy Result:", greedy_change(refund, denominations))
print("DP Result:", dp_change(refund, denominations))