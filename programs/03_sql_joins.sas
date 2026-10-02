/*=============================================================
  03_SQL_JOINS.SAS
  Purpose: PROC SQL, joins, calculated columns, GROUP BY,
           HAVING, CASE expressions, subqueries
=============================================================*/

%include "&project_root./programs/00_setup.sas";

proc sql;
    create table demo.sales_detail as
    select
        s.order_id,
        s.order_date,
        s.customer_id,
        c.customer_name,
        c.segment,
        c.region,
        c.city,
        s.product_id,
        p.product_name,
        p.category,
        p.unit_price,
        s.quantity,
        s.discount,
        (s.quantity * p.unit_price) as gross_sales format=dollar12.2,
        (s.quantity * p.unit_price * (1-s.discount)) as net_sales format=dollar12.2,
        calculated gross_sales - calculated net_sales as discount_value
            format=dollar12.2
    from demo.sales as s
    left join demo.customers as c
        on s.customer_id = c.customer_id
    left join demo.products as p
        on s.product_id = p.product_id
    ;

    create table demo.customer_summary as
    select
        customer_id,
        customer_name,
        segment,
        region,
        sum(net_sales) as total_sales format=dollar14.2,
        count(distinct order_id) as order_count,
        calculated total_sales / calculated order_count as avg_order_value
            format=dollar12.2
    from demo.sales_detail
    group by customer_id, customer_name, segment, region
    having calculated total_sales > 1000
    order by calculated total_sales desc
    ;
quit;

/* CASE expression */
proc sql;
    create table demo.sales_detail_enriched as
    select *,
        case
            when net_sales >= 1000 then "Large"
            when net_sales >= 500 then "Medium"
            else "Small"
        end as order_size length=6
    from demo.sales_detail;
quit;
