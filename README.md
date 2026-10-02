# SAS Demo Project

A self-contained SAS learning/demo project designed to showcase a broad range of common SAS programming features using synthetic sales data.

## What this project demonstrates

### SAS programming
- DATA steps
- `SET`
- `MERGE` concepts
- `IF/THEN/ELSE`
- `DO` loops
- Arrays
- SAS functions
- Character manipulation
- Date functions
- Missing-value handling
- `KEEP`, `DROP`, `RENAME`
- User-defined formats
- Macro variables
- Macros
- Logging/options

### Data work
- CSV import
- Data cleaning
- Derived variables
- Sorting
- Filtering
- Aggregation
- Transpose

### PROC SQL
- SELECT
- Calculated columns
- `CASE`
- `GROUP BY`
- `HAVING`
- Subquery-style analysis
- Inner/left joins

### Analysis
- `PROC CONTENTS`
- `PROC PRINT`
- `PROC MEANS`
- `PROC SUMMARY`-style aggregation
- `PROC FREQ`
- `PROC UNIVARIATE`
- Correlation
- T-test
- ANOVA/GLM
- Regression

### Visualization and reporting
- `PROC SGPLOT`
- `PROC SGPANEL`
- ODS Graphics
- ODS HTML
- ODS PDF
- `PROC REPORT`

### Export
- CSV export
- HTML report
- PDF report

## Data

The project contains three synthetic datasets:

- `data/customers.csv` — 100 customers
- `data/products.csv` — 10 products
- `data/sales.csv` — 3,000 sales orders

No real or personal data is used.

## What to install

You need a working SAS programming environment. Choose **one** of these common options:

### Option 1 — SAS Studio / SAS Viya

If your university, employer, or organization provides SAS Studio, this is usually the easiest option.

You do **not** need to install Python, R, or a database for this project.

Upload/extract the `SAS_Demo_Project` folder into the SAS Studio environment, then open the `.sas` files.

### Option 2 — SAS 9.4

A licensed SAS 9.4 installation with Base SAS and the standard procedures used by this project is sufficient.

Open the `.sas` files in your SAS programming environment.

### Option 3 — SAS University Edition

SAS University Edition was historically used for learning, but it has been retired. For a new setup, use a currently supported SAS environment such as SAS Studio through an institution or SAS Viya-based offering.

## Requirements

The project expects these standard SAS capabilities:

- DATA step
- Base SAS procedures
- PROC SQL
- ODS
- SAS/STAT procedures such as `PROC TTEST`, `PROC GLM`, and `PROC REG`

If your SAS installation does not license SAS/STAT, the import, cleaning, SQL, reporting, and visualization portions can still be used, but `05_statistics.sas` may not run completely.

## Project structure

```text
SAS_Demo_Project/
├── README.md
├── data/
│   ├── customers.csv
│   ├── products.csv
│   └── sales.csv
├── programs/
│   ├── 00_setup.sas
│   ├── 01_import.sas
│   ├── 02_cleaning.sas
│   ├── 03_sql_joins.sas
│   ├── 04_analysis.sas
│   ├── 05_statistics.sas
│   ├── 06_visualizations.sas
│   ├── 07_report.sas
│   └── run_all.sas
└── output/
    ├── charts/
    ├── reports/
    └── exports/
```

## How to run the project

### Easiest method

1. Download/extract this project.
2. Open your SAS environment.
3. Upload the complete `SAS_Demo_Project` folder if you are using SAS Studio.
4. Open `programs/run_all.sas`.
5. Run it.
6. Open the `output/` directory and inspect the generated reports, charts, and exports.

## Important: project path

The project uses:

```sas
%let project_root = %sysget(PWD);
```

This attempts to obtain the current working directory automatically.

If your SAS environment does not expose `PWD`, change the line in `programs/run_all.sas` to the actual project path.

For example:

```sas
%let project_root = /home/myuser/SAS_Demo_Project;
```

On Windows SAS 9.4, it might look like:

```sas
%let project_root = C:\Users\myuser\Documents\SAS_Demo_Project;
```

SAS path syntax depends on your environment, so use the path format expected by your installation.

## Recommended learning order

If you're learning SAS, don't start with `run_all.sas`. Run the programs individually:

### 1. `01_import.sas`

Learn how CSV files become SAS datasets.

### 2. `02_cleaning.sas`

Study DATA-step programming, variables, conditions, functions, arrays, and dates.

### 3. `03_sql_joins.sas`

Learn how SAS SQL can combine datasets and calculate business metrics.

### 4. `04_analysis.sas`

Explore descriptive statistics and common analytical procedures.

### 5. `05_statistics.sas`

Look at correlation, t-tests, ANOVA, and regression.

### 6. `06_visualizations.sas`

Learn how to produce charts with ODS Graphics.

### 7. `07_report.sas`

Learn macros, PROC REPORT, ODS HTML/PDF, and exports.

### 8. `run_all.sas`

Once you understand the individual programs, use this to execute the complete pipeline.

## What gets generated

After a successful run, check:

```text
output/
├── charts/
│   └── charts.html
├── reports/
│   ├── sales_report_2024.html
│   └── sales_report.pdf
└── exports/
    ├── customer_summary.csv
    └── monthly_sales.csv
```

SAS datasets are also stored in the `output` location through the `DEMO` library.

## Troubleshooting

### ERROR: Physical file does not exist

Your `project_root` is probably incorrect.

Check:

```sas
%put &=project_root;
%put &=data_dir;
```

Then verify that the CSV files exist under the displayed data directory.

### ERROR: Libref DEMO is not assigned

Run `00_setup.sas` first, or make sure the project path is correct.

### ERROR: Procedure not found / procedure not licensed

Some statistical procedures require SAS/STAT. Run the other programs first and check which procedure generated the error.

### The HTML/PDF output is empty

Check the SAS log for errors and make sure the preceding programs successfully created the required datasets.

## Suggested exercises

Once the project works, modify it:

1. Add a new product.
2. Add a new customer segment.
3. Change the sales date range.
4. Create a monthly revenue dashboard.
5. Find the top 10 customers.
6. Find the top 5 products by revenue.
7. Add profit and cost variables.
8. Create a retention analysis.
9. Add a macro that accepts a year and generates a report.
10. Add your own chart with `PROC SGPLOT`.
11. Create a parameterized SQL report.
12. Add validation checks that stop the pipeline when required data is missing.

## Notes

This is a demonstration/learning project. The datasets are synthetic and the analytical results are not intended to represent a real business.

The project deliberately uses multiple SAS features so that you can explore how they fit together in a realistic end-to-end workflow.
