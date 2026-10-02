/*=============================================================
  00_SETUP.SAS
  Purpose: Central configuration and reusable macro variables
=============================================================*/

options nodate nonumber;
options mprint mlogic symbolgen;

%let project_root = %sysget(PWD);

/* If PWD is unavailable in your SAS environment, replace the
   following path with the full path to SAS_Demo_Project. */
%let data_dir   = &project_root./data;
%let output_dir = &project_root./output;

libname demo "&output_dir";

/* Reusable date format */
proc format;
    value salesfmt
        low - <1000 = 'Low'
        1000 - <5000 = 'Medium'
        5000 - high = 'High';
run;

%put NOTE: Project root = &project_root;
%put NOTE: Data directory = &data_dir;
%put NOTE: Output directory = &output_dir;
