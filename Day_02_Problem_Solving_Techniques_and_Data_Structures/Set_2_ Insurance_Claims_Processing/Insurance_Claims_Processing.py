
from collections import deque
import random


# TASK 1: BINARY SEARCH TREE

class Node:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None


class BST:
    def __init__(self):
        self.root = None

    def insert(self, root, value):
        if root is None:
            return Node(value)

        if value < root.value:
            root.left = self.insert(root.left, value)
        elif value > root.value:
            root.right = self.insert(root.right, value)

        return root

    def search(self, root, value):
        if root is None:
            return False

        if root.value == value:
            return True

        if value < root.value:
            return self.search(root.left, value)

        return self.search(root.right, value)

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


claims = [105, 103, 110, 101, 104, 108, 115, 102, 106, 112]

bst = BST()
root = None

for claim in claims:
    root = bst.insert(root, claim)

print("Inorder:")
bst.inorder(root)

print("\nPreorder:")
bst.preorder(root)

print("\nPostorder:")
bst.postorder(root)

print("\nSearch 108:", bst.search(root, 108))
print("Search 120:", bst.search(root, 120))


# TASK 2: HASHING FOR DUPLICATE CLAIMS

def normalize(policy, date):
    policy = "".join(policy.upper().split())
    date = date.strip()
    return policy, date


def detect_duplicates(data):
    seen = {}
    duplicates = []

    for claim in data:
        key = normalize(
            claim["policy"],
            claim["date"]
        )

        if key in seen:
            duplicates.append(claim)
        else:
            seen[key] = claim

    return duplicates


claims_data = [
    {"policy": "POL 101", "date": "2026-11-18"},
    {"policy": "pol101", "date": "2026-11-18"},
    {"policy": "POL 102", "date": "2026-11-17"},
    {"policy": "POL 103", "date": "2026-11-16"},
    {"policy": "pol 102", "date": "2026-11-17"}
]

print("\nDuplicate Claims:")
print(detect_duplicates(claims_data))


# TASK 3: DIRECTED GRAPH, BFS AND DFS

graph = {
    "registration": ["assessment"],
    "assessment": ["surveyor"],
    "surveyor": ["settlement"],
    "settlement": []
}


def bfs_shortest_path(graph, start, end):
    queue = deque([(start, [start])])
    visited = set()

    while queue:
        node, path = queue.popleft()

        if node == end:
            return path

        if node not in visited:
            visited.add(node)

            for neighbor in graph[node]:
                if neighbor not in visited:
                    queue.append((neighbor, path + [neighbor]))

    return None


def detect_cycle(graph):
    visited = set()
    active = set()

    def dfs(node):
        visited.add(node)
        active.add(node)

        for neighbor in graph[node]:
            if neighbor not in visited:
                if dfs(neighbor):
                    return True
            elif neighbor in active:
                return True

        active.remove(node)
        return False

    for node in graph:
        if node not in visited:
            if dfs(node):
                return True

    return False


print("\nShortest Path:")
print(bfs_shortest_path(
    graph,
    "registration",
    "settlement"
))

print("Cycle Detected:", detect_cycle(graph))

cyclic_graph = {
    "registration": ["assessment"],
    "assessment": ["surveyor"],
    "surveyor": ["registration"],
    "settlement": []
}

print("Cycle Test:", detect_cycle(cyclic_graph))


# TASK 4: SLIDING WINDOW

claims_per_day = [
    80, 120, 130, 150, 140, 90, 80,
    110, 120, 130, 140, 150, 160, 90,
    80, 70, 110, 120, 130, 140, 80
]


def longest_run(data, threshold=100):
    max_length = 0
    current_length = 0
    best_start = -1
    start = 0

    for i in range(len(data)):
        if data[i] > threshold:
            if current_length == 0:
                start = i

            current_length += 1

            if current_length > max_length:
                max_length = current_length
                best_start = start
        else:
            current_length = 0

    return max_length, best_start


length, start = longest_run(claims_per_day)

print("\nLongest Consecutive Run:", length)

if start != -1:
    print("Starting Day:", start + 1)
    print("Ending Day:", start + length)


# TASK 5: TWO POINTERS - MERGE SORTED LISTS

def merge_claims(list1, list2):
    i = 0
    j = 0
    result = []

    while i < len(list1) and j < len(list2):
        if list1[i] <= list2[j]:
            result.append(list1[i])
            i += 1
        else:
            result.append(list2[j])
            j += 1

    result.extend(list1[i:])
    result.extend(list2[j:])

    return result


regional1 = [101, 103, 105, 108, 110]
regional2 = [102, 104, 106, 107, 109, 111]

print("\nRegional Office 1:", regional1)
print("Regional Office 2:", regional2)

print("Merged Claims:")
print(merge_claims(regional1, regional2))


# EMPTY INPUT AND DUPLICATE TESTS

print("\nEmpty List Test:")
print(merge_claims([], []))

print("Empty BST Search:", bst.search(None, 100))

print("Empty Duplicate Test:", detect_duplicates([]))
