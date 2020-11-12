%macro one (a = , b = );
proc import 
datafile= "/folders/myfolders/ppp/new/&a"
out= Work.&b
dbms=csv replace;
guessingrows= max;
run;
%mend one;

%one (a = dm.csv, b = DM);
%one (a = _ie_.csv, b = IE );
%one (a = co.csv, b = CO );
%one (a = END_OF_TREAT.csv, b = EoT );
%one (a = end_of_study.csv, b = EoS );

data C01;
retain Subject ICTYPE ICDT ICROTDT ICCONDT ICOBTAIN;
set work.CO;
keep Subject ICTYPE ICDT ICROTDT ICCONDT ICOBTAIN;
rename Subject = Patient_ID;
rename ICTYPE  = Consent_or_Assent;
rename ICDT = Date_Obtained;
rename ICROTDT = Protocol_Version_Date;
rename ICCONDT = Consent_Assent_Version_Date;
rename ICOBTAIN = Obtained_From;
run;

data DM1;
retain Subject BRTHDT AGE SEX CBPYN ETHNIC RACE01;
set work.DM;
keep Subject BRTHDT AGE SEX CBPYN ETHNIC RACE01;
rename Subject = Patient_ID;
rename BRTHDT  = Date_of_Birth;
rename AGE = Age;
rename SEX = Sex;
rename CBPYN = Subj_of_Childbearing_Potential;
rename ETHNIC = Ethnicity;
rename RACE01 = Race;
run;

data EOT1;
retain Subject DS1DT DS1TERM DSCOVID DSCOVIDSP SUBJ_DEACTIV BLNCE_DEACTIV_REASON;
set work.EoT;
keep Subject DS1DT DS1TERM DSCOVID DSCOVIDSP SUBJ_DEACTIV BLNCE_DEACTIV_REASON;
rename Subject = Patient_ID;
rename DS1DT  = Date_of_Compl_Discont;
rename DS1TERM = Subject_Status;
rename DSCOVID = Discontinuation_due_Covid_19;
rename DSCOVIDSP = If_related_to_Covid_19_Specify;
rename SUBJ_DEACTIV = Drug_dispensation_check;
rename BLNCE_DEACTIV_REASON = Provide_reason_no_drug_disp_chk;
run;

data EOS1;
retain Subject DSDT DSTERM DSCOVID DSCOVIDSP;
set work.EOS;
keep Subject DSDT DSTERM DSCOVID DSCOVIDSP;
rename Subject = Patient_ID;
rename DSDT = Date_of_Complet_Discont;
rename DSTERM = Subject_Status;
rename DSCOVID = Discontinuation_due_Covid_19;
rename DSCOVIDSP = If_related_to_Covid_19_Specify;

run;

PROC TRANSPOSE DATA=DM1 OUT=Demog name= Variables prefix=Patient_Info;
    BY patient_ID;
            VAR Date_of_Birth Age Sex Subj_of_Childbearing_Potential Ethnicity Race;
           
RUN;


PROC TRANSPOSE DATA=EOT1 OUT=EOT2 name= Variables prefix=Patient_Info;
    BY patient_ID;
            VAR Date_of_Compl_Discont Subject_Status Discontinuation_due_Covid_19 If_related_to_Covid_19_Specify Drug_dispensation_check Provide_reason_no_drug_disp_chk;
           
RUN;

PROC TRANSPOSE DATA=EOS1 OUT=EOS2 name= Variables prefix=Patient_Info;
    BY patient_ID;
           VAR Date_of_Complet_Discont Subject_Status Discontinuation_due_Covid_19 If_related_to_Covid_19_Specify;

RUN;

Title;

ods rtf file = "/folders/myfolders/ppp/new/ppp.rtf" startpage=No;


proc report  data = work.c01;
where Patient_ID = "US-999-001";
compute before _page_; 
 line @3 'Table 1.0: Informed Consent - Patient Profile'; 
 endcomp;
 quit;
 

proc report  data = work.demog;
where Patient_ID = "US-999-001";
columns Patient_ID Variables Patient_Info1;
compute before _page_; 
 line @3 'Table 2.0: Demographics - Patient Profile'; 
 endcomp;
 quit;
 

 proc report  data = work.IE;
where Patient_ID = "US-999-001";
compute before _page_; 
 line @3 'Table 3.0: Inclusion and Exclusion Criteria - Patient Profile'; 
 endcomp;
 


 proc report  data = work.EOT2;
where Patient_ID = "US-999-001";
compute before _page_; 
 line @3 'Table 4.0: End of Treatment Dispositon- Patient Profile'; 
 endcomp;
 


 proc report  data = work.EOS2;
where Patient_ID = "US-999-001";
compute before _page_; 
 line @3 'Table 5.0: End of Study Disposition- Patient Profile'; 
 endcomp;
 
quit;

Ods pdf close;