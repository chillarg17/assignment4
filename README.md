# assignment4
In my Week 4 assessment, i worked with a three-table "Bookmart" database (authors, books, sales) to practice a full range of SQL querying concepts:

Joins: INNER, LEFT, RIGHT, and FULL OUTER (via UNION) joins to connect authors with their books and sales, including a SELF JOIN to map authors to their mentors

Set operations: CROSS JOIN to generate combinations, UNION to merge and deduplicate result sets, and anti-joins (LEFT JOIN + IS NULL) to find unsold books

Subqueries: scalar, IN, ANY/ALL, and correlated subqueries to filter books by price relative to averages and genre benchmarks
EXISTS / NOT EXISTS: to check for authors meeting or missing certain publishing conditions

Window functions: ROW_NUMBER, RANK, LAG, and running totals (SUM OVER) to rank books within genres and analyze sales trends over time

CTEs: single and multi-CTE queries to break complex logic into readable steps, culminating in a comprehensive query combining CTEs, window functions, and joins to find each genre's top-selling book, its author, and total genre revenue

Overall, the assessment moved from basic join mechanics through progressively more advanced techniques, ending with a synthesis query that tied all the concepts together.
