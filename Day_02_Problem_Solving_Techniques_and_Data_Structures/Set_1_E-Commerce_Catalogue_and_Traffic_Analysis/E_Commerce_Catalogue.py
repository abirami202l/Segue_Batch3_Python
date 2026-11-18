
import time
import random
from collections import deque

# TASK 1: BINARY SEARCH TREE

class Node:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None


class BST:
    def __init__(self):
        self.root = None

    def insert(self, value):
        self.root = self._insert(self.root, value)

    def _insert(self, root, value):
        if root is None:
            return Node(value)

        if value < root.value:
            root.left = self._insert(root.left, value)
        elif value > root.value:
            root.right = self._insert(root.right, value)

        return root

    def search(self, value):
        current = self.root

        while current:
            if current.value == value:
                return True
            elif value < current.value:
                current = current.left
            else:
                current = current.right

        return False

    def inorder(self, root):
        if root:
            self.inorder(root.left)
            print(root.value, end=" ")
            self.inorder(root.right)

    def preorder(self, root):
        if root:
            print(root.value, end=" ")
            self.preorder(root.left)
            self.preorder(root.right)

    def postorder(self, root):
        if root:
            self.postorder(root.left)
            self.postorder(root.right)
            print(root.value, end=" ")


categories = [
    "Electronics", "Fashion", "Books", "Furniture",
    "Mobiles", "Laptops", "Shoes", "Watches",
    "Home", "Kitchen", "Sports", "Toys",
    "Beauty", "Groceries", "Accessories"
]

tree = BST()

for category in categories:
    tree.insert(category)

print("Inorder Traversal:")
tree.inorder(tree.root)

print("\nPreorder Traversal:")
tree.preorder(tree.root)

print("\nPostorder Traversal:")
tree.postorder(tree.root)

print("\nSearch Electronics:", tree.search("Electronics"))
print("Search Pharmacy:", tree.search("Pharmacy"))


# TASK 2: HASH TABLE WITH CHAINING

class HashTable:
    def __init__(self, size=10):
        self.size = size
        self.table = [[] for _ in range(size)]

    def hash_function(self, key):
        return sum(ord(char) for char in key) % self.size

    def insert(self, key, value):
        index = self.hash_function(key)

        for item in self.table[index]:
            if item[0] == key:
                item[1] = value
                return

        self.table[index].append([key, value])

    def search(self, key):
        index = self.hash_function(key)

        for item in self.table[index]:
            if item[0] == key:
                return item[1]

        return None


hash_table = HashTable()

hash_table.insert("SKU101", "Mobile")
hash_table.insert("SKU110", "Laptop")
hash_table.insert("SKU120", "Keyboard")

print("\nCustom Hash Table:")
print("SKU101:", hash_table.search("SKU101"))

print("Collision demonstration:")
print("SKU101 Index:", hash_table.hash_function("SKU101"))
print("SKU110 Index:", hash_table.hash_function("SKU110"))

print("Hash Table:", hash_table.table)

sku_data = {
    f"SKU{i}": f"Product{i}"
    for i in range(100000)
}

custom_table = HashTable(size=200003)

for key, value in sku_data.items():
    custom_table.insert(key, value)

target = "SKU99999"

start = time.perf_counter()
custom_result = custom_table.search(target)
custom_time = time.perf_counter() - start

start = time.perf_counter()
builtin_result = sku_data.get(target)
builtin_time = time.perf_counter() - start

print("\nCustom Hash Table Result:", custom_result)
print("Custom Hash Table Time:", custom_time)

print("Built-in Dictionary Result:", builtin_result)
print("Built-in Dictionary Time:", builtin_time)


# TASK 3: GRAPH, BFS, DFS AND CYCLE DETECTION

graph = {
    "cart": ["pricing"],
    "pricing": ["inventory"],
    "inventory": ["payment"],
    "payment": ["shipping"],
    "shipping": []
}


def bfs(graph, start):
    visited = set()
    queue = deque([start])
    result = []

    while queue:
        node = queue.popleft()

        if node not in visited:
            visited.add(node)
            result.append(node)

            for neighbor in graph[node]:
                if neighbor not in visited:
                    queue.append(neighbor)

    return result


def dfs(graph, start, visited=None):
    if visited is None:
        visited = set()

    visited.add(start)
    print(start, end=" ")

    for neighbor in graph[start]:
        if neighbor not in visited:
            dfs(graph, neighbor, visited)


def topological_sort(graph):
    indegree = {node: 0 for node in graph}

    for node in graph:
        for neighbor in graph[node]:
            indegree[neighbor] += 1

    queue = deque(
        node for node in graph
        if indegree[node] == 0
    )

    result = []

    while queue:
        node = queue.popleft()
        result.append(node)

        for neighbor in graph[node]:
            indegree[neighbor] -= 1

            if indegree[neighbor] == 0:
                queue.append(neighbor)

    if len(result) != len(graph):
        return None

    return result


def detect_cycle(graph):
    visited = set()
    recursion_stack = set()

    def dfs_cycle(node):
        visited.add(node)
        recursion_stack.add(node)

        for neighbor in graph[node]:
            if neighbor not in visited:
                if dfs_cycle(neighbor):
                    return True
            elif neighbor in recursion_stack:
                return True

        recursion_stack.remove(node)
        return False

    for node in graph:
        if node not in visited:
            if dfs_cycle(node):
                return True

    return False


print("\n\nBFS Traversal:", bfs(graph, "cart"))

print("DFS Traversal:")
dfs(graph, "cart")

print("\nDeployment Order:", topological_sort(graph))
print("Circular Dependency:", detect_cycle(graph))

cyclic_graph = {
    "cart": ["pricing"],
    "pricing": ["inventory"],
    "inventory": ["cart"]
}

print("Cycle Test:", detect_cycle(cyclic_graph))


# TASK 4: SLIDING WINDOW

requests = [
    120, 150, 180, 200, 250, 300,
    280, 260, 240, 220, 210, 230,
    250, 270, 290, 310, 330, 350,
    300, 280, 260, 240, 200, 180
]


def busiest_window(data, window=3):
    current_sum = sum(data[:window])
    max_sum = current_sum
    start_index = 0

    for i in range(window, len(data)):
        current_sum += data[i] - data[i - window]

        if current_sum > max_sum:
            max_sum = current_sum
            start_index = i - window + 1

    return start_index, max_sum


start, total = busiest_window(requests)

print("\nBusiest 3-Hour Window:")
print("Starting Hour:", start)
print("Ending Hour:", start + 2)
print("Total Requests:", total)
print("Average Requests:", total / 3)


# TASK 5: TWO POINTERS

def find_pairs(arr, target):
    left = 0
    right = len(arr) - 1
    result = []

    while left < right:
        total = arr[left] + arr[right]

        if total == target:
            result.append((arr[left], arr[right]))

            left_value = arr[left]
            right_value = arr[right]

            while left < right and arr[left] == left_value:
                left += 1

            while left < right and arr[right] == right_value:
                right -= 1

        elif total < target:
            left += 1

        else:
            right -= 1

    return result


order_values = [
    100, 200, 300, 400, 500,
    600, 700, 800, 900, 1000
]

gift_card = 1000

print("\nGift Card Value:", gift_card)
print("Matching Pairs:", find_pairs(order_values, gift_card))
