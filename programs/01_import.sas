/*=============================================================
  01_IMPORT.SAS
  Purpose: Import CSV files and demonstrate PROC IMPORT
=============================================================*/

%include "&project_root./programs/00_setup.sas";

proc import datafile="&data_dir./customers.csv"
    out=demo.customers_raw
    dbms=csv
    replace;
    guessingrows=max;
    getnames=yes;
run;

proc import datafile="&data_dir./products.csv"
    out=demo.products_raw
    dbms=csv
    replace;
    guessingrows=max;
    getnames=yes;
run;

proc import datafile="&data_dir./sales.csv"
    out=demo.sales_raw
    dbms=csv
    replace;
    guessingrows=max;
    getnames=yes;
run;

proc contents data=demo.customers_raw; run;
proc contents data=demo.products_raw; run;
proc contents data=demo.sales_raw; run;
