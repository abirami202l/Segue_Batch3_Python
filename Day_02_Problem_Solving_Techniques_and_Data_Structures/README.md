# Day 2 – Data Structures and Problem-Solving Techniques

## Overall Summary

This practical covers three real-world business scenarios:

1. E-Commerce Catalogue and Traffic Analysis
2. Insurance Claims Processing
3. Logistics Network and Delivery Windows

The main concepts used are Binary Search Trees, Hash Tables, Graphs, BFS, DFS, Sliding Window and Two Pointers.

---

# Set 1 – E-Commerce Catalogue and Traffic Analysis

## Business Scenario

An e-commerce platform needs faster category browsing, instant SKU lookups and infrastructure planning for peak traffic.

## Tasks and Solutions

### 1. Binary Search Tree

- Create a BST containing 15 product categories.
- Implement insertion and searching.
- Display inorder, preorder and postorder traversals.
- Inorder traversal displays categories in sorted order.

### 2. Hash Table with Chaining

- Implement a hash table using separate chaining.
- Demonstrate a collision between two SKU keys.
- Compare custom hash table lookup with Python's built-in Dictionary.
- Benchmark lookup using 100,000 SKUs.

### 3. Graph – Microservice Dependencies

- Represent microservice dependencies using a directed graph.
- Use BFS and DFS to traverse the graph.
- Use topological sorting to generate a valid deployment order.
- Detect circular dependencies using DFS.

Example dependency:

Cart → Pricing → Inventory → Payment → Shipping

### 4. Sliding Window

- Use requests-per-minute data for 24 hours.
- Find the busiest continuous 3-hour window.
- Calculate the total and average requests.

### 5. Two Pointers

- Use a sorted list of order values.
- Find all pairs whose sum equals the gift-card value.
- Avoid checking every possible pair.

## Complexity Analysis

| Task | Algorithm | Time Complexity |
|---|---|---|
| 1 | BST Search/Insert | O(log n) average, O(n) worst |
| 1 | BST Traversal | O(n) |
| 2 | Hash Table Lookup | O(1) average, O(n) worst |
| 2 | Built-in Dictionary Lookup | O(1) average |
| 3 | BFS | O(V + E) |
| 3 | DFS | O(V + E) |
| 3 | Topological Sort | O(V + E) |
| 4 | Sliding Window | O(n) |
| 5 | Two Pointers | O(n) |

---

# Set 2 – Insurance Claims Processing

## Business Scenario

An insurance company needs to route claims through approval stages, detect duplicate claim submissions and monitor claim increases after regional events.

## Tasks and Solutions

### 1. Binary Search Tree

- Create a BST containing claim IDs.
- Implement insertion and searching.
- Display inorder, preorder and postorder traversals.
- Inorder traversal provides claims in ascending sorted order.

### 2. Hashing for Duplicate Claims

- Use a Dictionary to identify duplicate claims.
- Normalize policy numbers by converting letters to uppercase and removing spaces.
- Compare policy number and incident date.
- Handle hash collisions through key equality checking.

### 3. Directed Graph – Claim Approval

Represent the claim approval process:

Registration → Assessment → Surveyor → Settlement

- Use BFS to find the shortest path between two stages.
- Use DFS to detect circular dependencies.

### 4. Sliding Window

- Use daily claim counts.
- Find the longest consecutive run of days where claims exceeded 100.
- Reset the current count whenever a day has 100 or fewer claims.

### 5. Two Pointers – Merge Sorted Lists

- Use two sorted claim lists from regional offices.
- Compare elements using two pointers.
- Merge both lists into one sorted list.
- No additional sorting is required.

## Complexity Analysis

| Task | Algorithm | Time Complexity |
|---|---|---|
| 1 | BST Search/Insert | O(log n) average, O(n) worst |
| 1 | Tree Traversal | O(n) |
| 2 | Hashing | O(n) average |
| 3 | BFS | O(V + E) |
| 3 | DFS Cycle Detection | O(V + E) |
| 4 | Sliding Window | O(n) |
| 5 | Two-Pointer Merge | O(n + m) |

---

# Set 3 – Logistics Network and Delivery Windows

## Business Scenario

A courier company wants to optimize hub-to-hub routing and delivery-window planning across a national logistics network.

## Tasks and Solutions

### 1. Binary Search Tree of Hub Codes

- Store hub codes in a BST.
- Implement insertion and searching.
- Calculate the height of the BST.
- Explain the effect of sorted input.
- Sorted insertion creates an unbalanced tree.

### 2. Hash Map for Parcel Tracking

- Store parcel tracking numbers using a Dictionary.
- Maintain the list of hubs where each parcel was scanned.
- Detect duplicate scans at the same hub.

### 3. Graph – Logistics Network

- Represent 10 hubs using an adjacency list.
- Use BFS to find the route with the fewest hops.
- Use DFS to identify all reachable hubs from the central depot.

### 4. Sliding Window

- Use hourly parcel counts.
- Find the continuous 4-hour window with the highest average.
- Calculate the total parcels and average parcels.

### 5. Two Pointers – Palindrome

- Check whether a delivery route is a palindrome.
- Ignore uppercase/lowercase differences and separators.
- Compare characters from both ends using two pointers.

Example:

H1-H2-H3-H2-H1

This route is a palindrome.

## Complexity Analysis

| Task | Algorithm | Time Complexity |
|---|---|---|
| 1 | BST Search/Insert | O(log n) average, O(n) worst |
| 1 | BST Height Calculation | O(n) |
| 2 | Hash Map Lookup | O(1) average |
| 2 | Duplicate Scan Detection | O(1) average per scan |
| 3 | BFS | O(V + E) |
| 3 | DFS | O(V + E) |
| 4 | Sliding Window | O(n) |
| 5 | Two Pointers | O(n) |

---

# Overall Decision Table

| Problem | Data Structure / Pattern | Reason |
|---|---|---|
| Category and claim searching | Binary Search Tree | Efficient searching and ordered data |
| SKU and parcel lookup | Hash Table / Dictionary | Fast average lookup |
| Duplicate detection | Hash Set / Hash Map | Efficient membership checking |
| Microservice dependencies | Directed Graph | Represents dependency relationships |
| Deployment ordering | Topological Sort | Produces a valid dependency order |
| Shortest route | BFS | Finds the fewest edges in an unweighted graph |
| Cycle detection | DFS | Identifies circular dependencies |
| Traffic and parcel analysis | Sliding Window | Efficient continuous-range calculations |
| Gift-card pairs | Two Pointers | Finds matching pairs in sorted data |
| Claim list merging | Two Pointers | Merges sorted lists without extra sorting |
| Route palindrome | Two Pointers | Compares both ends efficiently |
| Category and hub organization | BST | Maintains hierarchical data |

---

# Overall Conclusion

This practical demonstrates the application of fundamental data structures and algorithms in e-commerce, insurance and logistics systems.

### Key Learnings

1. Binary Search Trees organize data and support searching.
2. Hash Tables provide efficient data lookup and duplicate detection.
3. Graphs represent relationships and dependencies between different services or locations.
4. BFS finds shortest paths in unweighted graphs.
5. DFS helps detect cycles and explore connected nodes.
6. Sliding Window efficiently processes continuous data ranges.
7. Two Pointers solve searching, merging and palindrome problems efficiently.
8. Topological Sorting determines a valid order for dependent tasks.

**Final Result:** All three sets demonstrate how suitable data structures and algorithms improve searching, processing, dependency management, traffic analysis and route optimization in real-world applications.