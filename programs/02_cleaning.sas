/*=============================================================
  02_CLEANING.SAS
  Purpose: DATA step, IF/THEN, functions, arrays, missing values,
           date handling, formats, KEEP/DROP/RENAME
=============================================================*/

%include "&project_root./programs/00_setup.sas";

data demo.customers;
    set demo.customers_raw;

    /* Character cleanup */
    customer_name = strip(propcase(customer_name));
    segment = strip(propcase(segment));
    region = strip(propcase(region));
    city = strip(propcase(city));

    /* Derived variables */
    age_group = "Unknown";
    if age < 30 then age_group = "18-29";
    else if age < 45 then age_group = "30-44";
    else if age < 60 then age_group = "45-59";
    else age_group = "60+";

    signup_year = year(signup_date);
    signup_month = month(signup_date);

    format signup_date date9.;
    keep customer_id customer_name segment region city signup_date age age_group
         signup_year signup_month;
run;

data demo.products;
    set demo.products_raw;

    product_name = strip(propcase(product_name));
    category = strip(propcase(category));

    length price_band $10;
    if unit_price < 100 then price_band = "Budget";
    else if unit_price < 500 then price_band = "Standard";
    else price_band = "Premium";

    format unit_price dollar10.2;
    keep product_id product_name category unit_price price_band;
run;

data demo.sales;
    set demo.sales_raw;

    /* Missing discount is treated as zero */
    if missing(discount) then discount = 0;

    /* Array example */
    array checks[2] quantity discount;
    do i = 1 to dim(checks);
        if missing(checks[i]) then checks[i] = 0;
    end;

    net_units = quantity;
    discount_pct = discount * 100;
    order_year = year(order_date);
    order_month = month(order_date);
    order_quarter = qtr(order_date);

    format order_date date9. discount percent7.2;
    drop i;
run;
