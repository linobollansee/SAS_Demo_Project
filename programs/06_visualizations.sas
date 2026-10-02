/*=============================================================
  06_VISUALIZATIONS.SAS
  Purpose: ODS Graphics, SGPLOT, SGPANEL
=============================================================*/

%include "&project_root./programs/00_setup.sas";

ods graphics on;

ods html path="&output_dir./charts" (url=none)
         file="charts.html"
         style=HTMLBlue;

title "Sales by Region";
proc sgplot data=demo.sales_detail;
    vbar region / response=net_sales stat=sum datalabel;
    yaxis label="Net Sales";
    xaxis label="Region";
run;

title "Net Sales Distribution";
proc sgplot data=demo.sales_detail;
    histogram net_sales;
    density net_sales / type=normal;
    xaxis label="Net Sales";
run;

title "Quantity vs Net Sales";
proc sgplot data=demo.sales_detail;
    scatter x=quantity y=net_sales / group=category transparency=.25;
    reg x=quantity y=net_sales;
run;

title "Monthly Sales Trend";
proc sql;
    create table demo.monthly_sales as
    select
        intnx('month', order_date, 0, 'beginning') as month format=monyy7.,
        sum(net_sales) as total_sales format=dollar14.2
    from demo.sales_detail
    group by calculated month
    order by calculated month;
quit;

proc sgplot data=demo.monthly_sales;
    series x=month y=total_sales / markers;
    xaxis label="Month";
    yaxis label="Net Sales";
run;

title "Sales by Region and Segment";
proc sgpanel data=demo.sales_detail;
    panelby region / columns=2;
    vbar segment / response=net_sales stat=sum;
run;

ods html close;
ods graphics off;
