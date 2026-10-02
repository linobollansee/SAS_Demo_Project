/*=============================================================
  RUN_ALL.SAS
  Purpose: Run the complete project from one file
=============================================================*/

/* IMPORTANT:
   Set project_root to the full path of SAS_Demo_Project if your
   SAS installation does not provide the PWD environment variable. */

%let project_root = %sysget(PWD);

%include "&project_root./programs/01_import.sas";
%include "&project_root./programs/02_cleaning.sas";
%include "&project_root./programs/03_sql_joins.sas";
%include "&project_root./programs/04_analysis.sas";
%include "&project_root./programs/05_statistics.sas";
%include "&project_root./programs/06_visualizations.sas";
%include "&project_root./programs/07_report.sas";

%put NOTE: ==========================================;
%put NOTE: SAS DEMO PROJECT COMPLETED SUCCESSFULLY;
%put NOTE: Check the output directory for results.;
%put NOTE: ==========================================;
