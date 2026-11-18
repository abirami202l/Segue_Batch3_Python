
from collections import deque


# TASK 1: BST OF HUB CODES

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

    def height(self, root):
        if root is None:
            return -1

        return 1 + max(
            self.height(root.left),
            self.height(root.right)
        )

    def inorder(self, root):
        if root:
            self.inorder(root.left)
            print(root.value, end=" ")
            self.inorder(root.right)


hubs = [
    "H50", "H30", "H70", "H20", "H40",
    "H60", "H80", "H10", "H35", "H90"
]

bst = BST()
root = None

for hub in hubs:
    root = bst.insert(root, hub)

print("Hub Codes:")
bst.inorder(root)

print("\nSearch H40:", bst.search(root, "H40"))
print("Search H100:", bst.search(root, "H100"))

print("Tree Height:", bst.height(root))


sorted_hubs = ["H10", "H20", "H30", "H40", "H50"]

sorted_root = None

for hub in sorted_hubs:
    sorted_root = bst.insert(sorted_root, hub)

print("Sorted Input Tree Height:", bst.height(sorted_root))


# TASK 2: HASH MAP FOR PARCEL TRACKING

parcels = {
    "P101": ["H1", "H2"],
    "P102": ["H1"],
    "P103": ["H3"],
    "P104": ["H2"]
}


def scan_parcel(tracking_number, hub):
    if tracking_number not in parcels:
        parcels[tracking_number] = []

    if hub in parcels[tracking_number]:
        return "Duplicate Scan Detected"

    parcels[tracking_number].append(hub)
    return "Scan Recorded Successfully"


print("\nParcel Scan:")
print(scan_parcel("P101", "H1"))
print(scan_parcel("P101", "H3"))
print(scan_parcel("P105", "H2"))

print("Parcel Records:")
print(parcels)


# TASK 3: GRAPH WITH 10 HUBS

graph = {
    "H1": ["H2", "H3"],
    "H2": ["H4", "H5"],
    "H3": ["H6"],
    "H4": ["H7"],
    "H5": ["H7", "H8"],
    "H6": ["H8"],
    "H7": ["H9"],
    "H8": ["H9"],
    "H9": ["H10"],
    "H10": []
}


def bfs_shortest_route(graph, start, destination):
    queue = deque([(start, [start])])
    visited = set()

    while queue:
        node, path = queue.popleft()

        if node == destination:
            return path

        if node not in visited:
            visited.add(node)

            for neighbor in graph[node]:
                if neighbor not in visited:
                    queue.append(
                        (neighbor, path + [neighbor])
                    )

    return None


def dfs(graph, start, visited=None):
    if visited is None:
        visited = set()

    visited.add(start)

    for neighbor in graph[start]:
        if neighbor not in visited:
            dfs(graph, neighbor, visited)

    return visited


print("\nShortest Route H1 to H10:")
print(bfs_shortest_route(graph, "H1", "H10"))

print("Reachable Hubs from H1:")
print(sorted(dfs(graph, "H1")))


# TASK 4: SLIDING WINDOW

parcel_counts = [
    100, 120, 150, 180,
    200, 220, 190, 170,
    160, 140, 130, 120
]


def highest_average_window(data, window=4):
    if len(data) < window:
        return None

    current_sum = sum(data[:window])
    max_sum = current_sum
    start_index = 0

    for i in range(window, len(data)):
        current_sum += data[i] - data[i - window]

        if current_sum > max_sum:
            max_sum = current_sum
            start_index = i - window + 1

    average = max_sum / window

    return start_index, max_sum, average


result = highest_average_window(parcel_counts)

print("\nHighest Average 4-Hour Window:")
print("Starting Hour:", result[0])
print("Ending Hour:", result[0] + 3)
print("Total Parcels:", result[1])
print("Average Parcels:", result[2])


# TASK 5: TWO POINTERS - PALINDROME

def is_palindrome(route):
    cleaned = "".join(
        char.lower()
        for char in route
        if char.isalnum()
    )

    left = 0
    right = len(cleaned) - 1

    while left < right:
        if cleaned[left] != cleaned[right]:
            return False

        left += 1
        right -= 1

    return True


route1 = "H1-H2-H3-H2-H1"
route2 = "H1-H2-H3-H4"

print("\nRoute 1:", route1)
print("Is Palindrome:", is_palindrome(route1))

print("Route 2:", route2)
print("Is Palindrome:", is_palindrome(route2))

print("Empty Route:", is_palindrome(""))
