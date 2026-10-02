/*=============================================================
  07_REPORT.SAS
  Purpose: ODS HTML/PDF, PROC REPORT, macro, and exports
=============================================================*/

%include "&project_root./programs/00_setup.sas";

%macro make_report(report_year=2024);

    ods html path="&output_dir./reports" (url=none)
             file="sales_report_&report_year..html"
             style=HTMLBlue;

    title "Sales Performance Report - &report_year";

    proc report data=demo.sales_detail nowd;
        where year(order_date)=&report_year;
        column region segment net_sales quantity;
        define region / group "Region";
        define segment / group "Segment";
        define net_sales / analysis sum "Net Sales" format=dollar14.2;
        define quantity / analysis sum "Units";
    run;

    title "Top Customers - &report_year";

    proc report data=demo.customer_summary(obs=20) nowd;
        column customer_name segment region total_sales order_count avg_order_value;
        define customer_name / display "Customer";
        define segment / display "Segment";
        define region / display "Region";
        define total_sales / analysis "Total Sales" format=dollar14.2;
        define order_count / analysis "Orders";
        define avg_order_value / analysis "Avg Order" format=dollar12.2;
    run;

    ods html close;

%mend;

%make_report(report_year=2024);

/* Export examples */
proc export data=demo.customer_summary
    outfile="&output_dir./exports/customer_summary.csv"
    dbms=csv
    replace;
run;

proc export data=demo.monthly_sales
    outfile="&output_dir./exports/monthly_sales.csv"
    dbms=csv
    replace;
run;

/* Optional PDF report */
ods pdf file="&output_dir./reports/sales_report.pdf";
title "SAS Demo PDF Report";

proc print data=demo.customer_summary(obs=25);
    var customer_name segment region total_sales order_count avg_order_value;
    format total_sales avg_order_value dollar14.2;
run;

ods pdf close;
