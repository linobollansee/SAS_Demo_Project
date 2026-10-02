/*=============================================================
  04_ANALYSIS.SAS
  Purpose: Descriptive analysis and core SAS procedures
=============================================================*/

%include "&project_root./programs/00_setup.sas";

title "SAS Demo - Data Overview";

proc means data=demo.sales_detail n mean median min max std sum;
    var quantity gross_sales net_sales discount_value;
run;

proc means data=demo.sales_detail nway;
    class region category;
    var net_sales;
    output out=demo.region_category_summary
        sum=total_sales
        mean=avg_sales
        n=orders;
run;

proc freq data=demo.sales_detail;
    tables region segment category order_size / missing;
    tables region*segment / chisq;
run;

proc univariate data=demo.sales_detail normal;
    var net_sales;
    histogram net_sales / normal;
    inset mean median std skewness kurtosis / position=ne;
run;

proc sort data=demo.sales_detail out=demo.sales_sorted;
    by region descending net_sales;
run;

proc print data=demo.sales_sorted(obs=20);
    var order_id customer_name region product_name net_sales;
    format net_sales dollar12.2;
run;

/* TRANSPOSE demonstration */
proc sort data=demo.region_category_summary;
    by region;
run;

proc transpose data=demo.region_category_summary
    out=demo.sales_transposed prefix=sales_;
    by region;
    id category;
    var total_sales;
run;
