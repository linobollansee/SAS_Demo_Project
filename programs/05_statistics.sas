/*=============================================================
  05_STATISTICS.SAS
  Purpose: Correlation, t-test, ANOVA, and regression examples
=============================================================*/

%include "&project_root./programs/00_setup.sas";

title "Correlation Analysis";
proc corr data=demo.sales_detail pearson spearman;
    var quantity discount gross_sales net_sales;
run;

title "Two-Sample T-Test: Net Sales by Order Size";
proc ttest data=demo.sales_detail;
    class order_size;
    var net_sales;
run;

/* ANOVA using a customer-level summary */
title "ANOVA: Customer Sales by Segment";
proc glm data=demo.customer_summary;
    class segment;
    model total_sales = segment;
    means segment / tukey;
run;
quit;

/* Regression */
title "Regression: Net Sales";
proc reg data=demo.sales_detail;
    model net_sales = quantity discount unit_price;
    output out=demo.regression_output
        p=predicted r=residual;
run;
quit;
