# Digital Media Store — SQL Database & Data Analysis

A relational database implementation and SQL analysis project modeling a digital media store (based on the open-source Chinook dataset) using **SQLite**.

## Overview
This project covers the complete lifecycle of working with a relational database:
- **Schema Design & Population:** Setting up relational tables with primary and foreign key constraints (`ARTIST`, `ALBUM`, `TRACK`, `GENRE`, `MEDIATYPE`, `PLAYLIST`, `PLAYLISTTRACK`, `CUSTOMER`, `EMPLOYEE`, `INVOICE`, `INVOICELINE`).
- **Exploratory Data Analysis:** Writing SQL queries using `JOIN`, subqueries, `NOT EXISTS`, and aggregate functions (`COUNT`, `AVG`, `ROUND`, `CAST`) to extract insights on sales, catalog duration, and customer records.
- **Reporting with Views:** Creating reusable SQL `VIEW` objects to summarize artist discographies, storage requirements per media type, and album revenue.
- **Data Manipulation & Integrity:** Performing conditional updates, table alterations, derived table creation, and cascading deletions with foreign key enforcement (`PRAGMA foreign_keys = ON`).

## Repository Structure
```text
├── README.md
├── database/
│   └── 00_init_database.sql
└── queries/
    ├── 01_employee_table.sql
    ├── 02_exploratory_analysis.sql
    ├── 03_views_reporting.sql
    └── 04_data_manipulation.sql
```

## Key Analytical Questions Covered
1. Identifying customers with missing contact information (phone number or postal code).
2. Retrieving discographies, track durations, and genres for specific artists (`AC/DC`, `U2`, `Queen`, `Led Zeppelin`).
3. Calculating the proportion of tracks with known composer credits.
4. Counting track distribution across playlists and identifying prolific artists (>10 albums).
5. Finding artists featured across multiple specific playlists (`90’s Music` and `Heavy Metal Classic`).
6. Analyzing total storage size (MB) and total playback duration (hours) per media type using SQL Views.
7. Determining the highest-grossing album by total invoice line value.

## How to Run
1. Open **DB Browser for SQLite** (or use the `sqlite3` CLI).
2. Create a new database and execute `database/00_init_database.sql` to build the schema and load the initial dataset.
3. Run the scripts inside `queries/` sequentially (`01` through `04`). *Note: Execute `04_data_manipulation.sql` last, as it modifies and deletes records.*
