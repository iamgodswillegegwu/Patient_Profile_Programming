*/ a start macro for importing of several data listings*/

%macro one (a = , b = );
proc import 
datafile= "/folders/myfolders/ppp/new/&a"
out= Work.&b
dbms=csv replace;
guessingrows= max;
run;
%mend one;

*/ end macro for importing of several data listings*/

*/ begin importing and asign unique output name in the work library*/

%one (a = dm.csv, b = DM);
%one (a = _ie_.csv, b = IE );
%one (a = co.csv, b = CO );
%one (a = END_OF_TREAT.csv, b = EoT );
%one (a = end_of_study.csv, b = EoS );
%one (a = VISIT_DATE.csv, b = VSDAT );
%one (a = AE.csv, b = AE );
%one (a = AEinfusion.csv, b = AEiRA );
%one (a = CM_.csv, b = CM );
%one (a = CP.csv, b = CP );
%one (a = MH_.csv, b = MH );
%one (a = GOUT_H.csv, b = GOUT );
%one (a = SUBSTANCE_USE.csv, b = SUBSTANCE );
%one (a = VITA.csv, b = VITASIGN );

*/ end importing and asign unique output name in the work library*/
*/ reading and renaming of needed filed OIDs into a more organized listing in the work library*/
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

data VSDAT1;
retain Subject SVSTDT_RAW SVND;
set work.VSDAT;
keep Subject SVSTDT_RAW SVND;
rename Subject = Patient_ID;
rename SVSTDT_RAW = Visit_Date;
rename SVND = Visit_Not_Done;
run;

data AE1;
retain Subject AEYN AETERM AEANPHLX AEISR AEGFNUM AEGTFLR AESTDT_RAW AESTTM AEONGO AEENTM AEENDT_RAW AEOUT;
set work.AE;
keep Subject AEYN AETERM AEANPHLX AEISR AEGFNUM AEGTFLR AESTDT_RAW AESTTM AEONGO AEENTM AEENDT_RAW AEOUT;
rename Subject = Patient_ID;
rename AEYN = Any_Adverse_Event;
rename AETERM = Adverse_Event;
rename AEANPHLX = Incidence_of_Anaphylaxis;
rename AEISR = Infusion_reaction;
rename AEGFNUM = Number_of_joints_affected;
rename AEGTFLR = Gout_flare;
rename AESTDT_RAW = Start_Date;
rename AESTTM = Start_Time;
rename AEONGO = Ongoing;
rename AEENTM = End_Time;
rename AEENDT_RAW = End_Date;
rename AEOUT = Outcome;
run;

data AETaken;
retain Subject AETERM AESTDT_RAW AEENDT_RAW AEACN AEACN2 AEACN1 AEOTNO AEOTHCM AEOTHCP AEOTHSP AEREL AEREL3 AEGRADE AESER;
set work.AE;
keep Subject AETERM AESTDT_RAW AEENDT_RAW AEACN AEACN2 AEACN1 AEOTNO AEOTHCM AEOTHCP AEOTHSP AEREL AEREL3 AEGRADE AESER;
rename Subject = Patient_ID;
rename AETERM = Adverse_Event;
rename AESTDT_RAW = Start_Date;
rename AEENDT_RAW = End_Date;
rename AEACN = Action_Taken_with_Pegloticase;
rename AEACN2 = Action_Taken_during_Infusion;
rename AEACN1 = Action_Taken_with_MTX;
rename AEOTNO = Other_Action_taken;
rename AEOTHCM = Concomitant_Medication;
rename AEOTHCP = Concomitant_Procedure;
rename AEOTHSP = If_Other_Specify;
rename AEREL = Relationship_to_Pegloticase;
rename AEREL3 = Relationship_to_OL_MTX;
rename AEGRADE = Rheumatology_CTC_Criteria;
rename AESER = Is_it_Serious;
run;


data SAE;
retain Subject AETERM AESAEDT_RAW AEAWARDT AESTDT_RAW AEENDT_RAW AESCONG AESDISAB AESDTH AESHOSP AESLIFE AESMIE AEPREG AEPREGWK;
set work.AE;
keep Subject AETERM AESAEDT_RAW AEAWARDT AESTDT_RAW AEENDT_RAW AESCONG AESDISAB AESDTH AESHOSP AESLIFE AESMIE AEPREG AEPREGWK;
rename Subject = Patient_ID;
rename AETERM = AE_Preferred_Term;
rename AESAEDT_RAW = Date_AE_became_serious;
rename AEAWARDT = SAE_date_first_awareness_by_site;
rename AESTDT_RAW = Start_Date;
rename AEENDT_RAW = End_Date;
rename AESCONG = Congenital_Anomaly_Birth_Defect;
rename AESDISAB = Pers_Sign_DisabilityIncapacity;
rename AESDTH = Results_in_Death;
rename AESHOSP = Requires_Prolonged_Hospital;
rename AESLIFE = Life_Threatening;
rename AESMIE = Other_Medically_Important_Event;
rename AEPREG = Is_the_Subject_Pregnant;
rename AEPREGWK = If_Pregnant_Indicat_Weeks;
run;


data  _AEIRA_;
retain Subject AENUM AESAS AESSSTDT_RAW AESSSTTM AESSSTUN AESSENDT_RAW AESSENTM AESSENUN;
set work.AEIRA;
keep Subject AENUM AESAS AESSSTDT_RAW AESSSTTM AESSSTUN AESSENDT_RAW AESSENTM AESSENUN;
rename Subject = Patient_ID;
rename AENUM = Adverse_Event_Number;
rename AESAS = Signs_and_Symptoms;
rename AESSSTDT_RAW = Start_Date;
rename AESSSTTM = Start_Time;
rename AESSSTUN = Start_Time_Unknown;
rename AESSENDT_RAW = End_Date;
rename AESSENTM = End_time;
rename AESSENUN = End_time_Unknown;
run;


data  CM1;
retain Subject CMYN CMTERM CMINDC CMSTDT CMENDT CMONGO CMDOSE CMDOSU CMFREQ CMROUTE;
set work.CM;
keep Subject CMYN CMTERM CMINDC CMSTDT CMENDT CMONGO CMDOSE CMDOSU CMFREQ CMROUTE;
rename Subject = Patient_ID;
rename CMYN = Any_medicatn_Prior_During_Study;
rename CMTERM = Medication_Therapy;
rename CMINDC = Indication;
rename CMSTDT = Start_Date;
rename CMENDT = End_Date;
rename CMONGO = Ongoing;
rename CMDOSE = Dose;
rename CMDOSU = Dose_Units;
rename CMFREQ = Frequency;
rename CMROUTE = Route;
run;


data  CP1;
retain Subject CPYN CPSTDT CPTERM CPINDC;
set work.CP;
keep Subject CPYN CPSTDT CPTERM CPINDC;
rename Subject = Patient_ID;
rename CPYN = Any_con_procedure_performed;
rename CPSTDT = Date_of_Procedure;
rename CPTERM = Procedure_Name;
rename CPINDC = Indication;
run;


data  MH1;
retain Subject MHYN MHTERM MHSTDT_RAW MHENDT_RAW MHONGO MHCTC;
set work.MH;
keep Subject MHYN MHTERM MHSTDT_RAW MHENDT_RAW MHONGO MHCTC;
rename Subject = Patient_ID;
rename MHYN = Any_Medical_Surgical_History;
rename MHTERM = Medical_Surgical_Condition;
rename MHSTDT_RAW = Start_Date;
rename MHENDT_RAW = End_Date;
rename MHONGO = Ongoing;
rename MHCTC = CTC_Grade;
run;

data  GOUT1;
retain Subject SYMPDAT DIAGDAT UACRYN NUMFLARE PATFLARE GFSEV GFHCGS TOPHIYN OVRNHOSP GFHSURG KIDSTNYN NUMEPISD KFAFFCT;
set work.GOUT;
keep Subject SYMPDAT DIAGDAT UACRYN NUMFLARE PATFLARE GFSEV GFHCGS TOPHIYN OVRNHOSP GFHSURG KIDSTNYN NUMEPISD KFAFFCT;
rename Subject = Patient_ID;
rename SYMPDAT = Date_of_First_Gout_Attack;
rename DIAGDAT = Date_of_First_Diagnosis;
rename UACRYN = Presence_of_uric_acid_crystals;
rename NUMFLARE = Num_of_Flare_in_Joints_12_Months;
rename PATFLARE = Pattern_of_flares;
rename GFSEV = Typical_severity_of_acute_flares;
rename GFHCGS = Chron_Gout_synovitis_arthropathy;
rename TOPHIYN = Prior_or_current_Tophi;
rename OVRNHOSP = Hospital_Overnight_for_Gout;
rename GFHSURG = Hist_ofSurgery_ex_arthrocentesis;
rename KIDSTNYN = History_of_Kidney_Stones;
rename NUMEPISD = Episodes_of_renal_colic;
rename KFAFFCT = Kidney_Function_Impactd_by_Gout;   
run;


data  URATE1;
retain Subject IATALLO IATFEBU IATURA IATUOTH;
set work.GOUT;
keep Subject IATALLO IATFEBU IATURA IATUOTH;
rename Subject = Patient_ID;
rename IATALLO = Allopurinol_history;
rename IATFEBU = Febuxostat_history;
rename IATURA = Other_urate_lowering_therapy;
rename IATUOTH = Specify; 
run;


data  SUBSTANCE1;
retain Subject SUYN SUSMINCF SUSMENDT SUSMTYPE1 SUSMTYPE2 SUSMTYPE3 SUSMTYPE5 SUSMTYPE6 SUSMTYPE7 SUSMYEAR SUSMNUM1 SUSMNUM2 SUSMNUM3 SUSMNUM4;
set work.SUBSTANCE;
keep Subject SUYN SUSMINCF SUSMENDT SUSMTYPE1 SUSMTYPE2 SUSMTYPE3 SUSMTYPE5 SUSMTYPE6 SUSMTYPE7 SUSMYEAR SUSMNUM1 SUSMNUM2 SUSMNUM3 SUSMNUM4;
rename Subject = Patient_ID;
rename SUYN = Was_Substance_history_obtained;
rename SUSMINCF = Subject_Ever_Used_Tobacco;
rename SUSMENDT = If_Former_Quit_Date;
rename SUSMTYPE1 = Cigarettes;
rename SUSMTYPE2 = Cigars;
rename SUSMTYPE3 = Chewed;
rename SUSMTYPE5 = Pipe;
rename SUSMTYPE6 = Other;
rename SUSMTYPE7 = If_Other_Specify;
rename SUSMYEAR = Years_Using_Tobacco; 
rename SUSMNUM1 = Num_Packs_of_Cigarettes_per_week;
rename SUSMNUM2 = Number_of_Cigars_per_week;
rename SUSMNUM3 = Number_ChewPouches_Tins_per_week;
rename SUSMNUM4 = Number_of_Pipe_bowls_per_week;
run;


data  ALCO1;
retain Subject SUALNCF SUALENDT SUALTYPE1 SUALTYPE2 SUALTYPE3 SUALTYPE4 SUALTYPE5 SUALBEER SUALWINE SUALSPIR SUOTTYPE SUOTCF SUOTEND SUOTYEAR;
set work.SUBSTANCE;
keep Subject SUALNCF SUALENDT SUALTYPE1 SUALTYPE2 SUALTYPE3 SUALTYPE4 SUALTYPE5 SUALBEER SUALWINE SUALSPIR;
rename Subject = Patient_ID;
rename SUALNCF = Subject_Ever_Used_Alcohol;
rename SUALENDT = If_Former_Quit_Date;
rename SUALTYPE1 = Beer;
rename SUALTYPE2 = Wine;
rename SUALTYPE3 = Spirits;
rename SUALTYPE4 = Other;
rename SUALTYPE5 = If_Other_Specify;
rename SUALBEER = Number_of_Beers_per_week;
rename SUALWINE = Num_glasses_of_Wine_per_week;
rename SUALSPIR = Number_of_Spirits_per_week;
run;

data OTHER1;
retain Subject SUOTTYPE SUOTCF SUOTEND SUOTYEAR;
set work.SUBSTANCE;
keep Subject SUOTTYPE SUOTCF SUOTEND SUOTYEAR;
rename Subject = Patient_ID;
rename SUOTTYPE = Other_Type_of_Substance_Used;
rename SUOTCF = Type_of_User;
rename SUOTEND = If_Former_Quit_Date;
rename SUOTYEAR = If_Current_Years_Using; 
run;



data VITASIGN1;
retain Subject VSYN VSDT VSTM HEIGHT WEIGHT BMI TEMP TEMPMETH SYSBP DIABP PULSE RESP;
set work.vitasign;
keep Subject VSYN VSDT VSTM HEIGHT WEIGHT BMI TEMP TEMPMETH SYSBP DIABP PULSE RESP;
rename Subject = Patient_ID;
rename VSYN = Were_vitals_collected;
rename VSDT = Date_of_Measurement;
rename VSTM = Time_of_Measurement;
rename HEIGHT = Height_in_cm;
rename WEIGHT = Weight_in_kg;
rename BMI = BMI_in_kg_per_m2;
rename TEMP = Temperature_in_Cel;
rename TEMPMETH = Temperature_method;
rename SYSBP = Systolic_Blood_Pressure_in_mmHg;
rename DIABP = Diastolic_Blood_Pressure_in_mmHg;
rename PULSE = Heart_Rate_in_beats_per_min;
rename RESP = Respiratory_Rate_in_breaths_min; 
run;


data VITASIGN2;
retain Subject VSYN VSTMPT VSDT VSTM TEMP TEMPMETH WEIGHT SYSBP DIABP PULSE RESP;
set work.vitasign;
keep Subject VSYN VSTMPT VSDT VSTM TEMP TEMPMETH WEIGHT SYSBP DIABP PULSE RESP;
rename Subject = Patient_ID;
rename VSYN = Were_vitals_collected;
rename VSTMPT = Timepoint;
rename VSDT = Date_of_Measurement;
rename VSTM = Time_of_Measurement;
rename TEMP = Temperature_in_Cel;
rename TEMPMETH = Temperature_method;
rename WEIGHT = Weight_in_kg;
rename SYSBP = Systolic_Blood_Pressure_in_mmHg;
rename DIABP = Diastolic_Blood_Pressure_in_mmHg;
rename PULSE = Heart_Rate_in_beats_per_min;
rename RESP = Respiratory_Rate_in_breaths_min; 
run;

*/ end reading and renaming of needed filed OIDs into a more organized listing in the work library*/

*/ begin transposed statement to change table structure*/

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


PROC TRANSPOSE DATA=_AEIRA_ OUT=AE_INF_ name= Variables prefix=Patient_Info;
    BY patient_ID;
           VAR Patient_ID Adverse_Event_Number Signs_and_Symptoms Start_Date Start_Time Start_Time_Unknown End_Date End_time_Unknown;

RUN;
*/ end transposed statement to change table structure*/

*/ begin SAS ODS for creating document */
ODS rtf 
FILE = '/folders/myfolders/ppp/profile2.rtf' startpage= no
style = BarrettsBlue;

*/ begin reporting and printing of new and transposed data listings created */

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


proc report  data = work.VSDAT1;
where Patient_ID = "US-999-001";
compute before _page_; 
 line @3 'Table 6.0: Visit Date - Patient Profile'; 
 endcomp;



proc report  data = work.AE1;
where Patient_ID = "US-999-001";
compute before _page_; 
 line @3 'Table 7.0: Adverse Events - Patient Profile'; 
 endcomp;

 

proc report  data = work.AETaken;
where Patient_ID = "US-999-001";
compute before _page_; 
 line @3 'Table 8.0: Action Taken: Adverse Events - Patient Profile'; 
 endcomp;


proc report  data = work.SAE;
where Patient_ID = "US-999-001";
compute before _page_; 
 line @3 'Table 9.0: Serious Adverse Events - Patient Profile'; 
 endcomp;


proc report  data = work._AEIRA_;
where Patient_ID = "990-001";
compute before _page_;
 line @3 'Table 10.0:  Adverse Events - Infusion Reaction and Anaphylaxis Signs and Symptoms'; 
 endcomp;

proc report  data = work.CM1;
where Patient_ID = "US-999-001";
compute before _page_;
 line @3 'Table 11.0:  Prior and Concomitant Medications - Patient Profile'; 
 endcomp;

proc report  data = work.CP1;
where Patient_ID = "US-999-001";
compute before _page_;
 line @3 'Table 12.0: Concomitant Procedures - Patient Profile'; 
 endcomp;


proc report  data = work.CP1;
where Patient_ID = "US-999-001";
compute before _page_;
 line @3 'Table 13.0: Medical History - Patient Profile'; 
 endcomp;

proc report  data = work.GOUT1;
where Patient_ID = "US-999-002";
compute before _page_;
 line @3 'Table 14.0: Gout History - Patient Profile'; 
 endcomp;

proc report  data = work.urate1;
where Patient_ID = "US-999-002";
compute before _page_;
 line @3 'Table 15.0: Urate lowering therapy history - Patient Profile'; 
 endcomp;
 
proc report  data = work.urate1;
where Patient_ID = "US-999-002";
compute before _page_;
 line @3 'Table 16.0: Substance Use: Tobacco - Patient Profile'; 
 endcomp;


proc report  data = work.Substance1;
where Patient_ID = "US-999-002";
compute before _page_;
 line @3 'Table 16.0: Substance Use: Tobacco - Patient Profile'; 
 endcomp;

proc report  data = work.alco1;
where Patient_ID = "US-999-001";
compute before _page_;
 line @3 'Table 17.0: Substance Use - Alcohol and Other - Patient Profile'; 
 endcomp;


proc report  data = work.other1;
where Patient_ID = "US-999-001";
compute before _page_;
 line @3 'Table 18.0: Other Substance Use - Patient Profile'; 
 endcomp;

proc report  data = work.VITASIGN1;
where Patient_ID = "US-999-001";
compute before _page_;
 line @3 'Table 19.0: Vital Signs: Screening, End of Study, ET - Patient Profile'; 
 endcomp;


proc report  data = work.VITASIGN2;
where Patient_ID = "US-999-001";
compute before _page_;
 line @3 'Table 20.0: Vital Signs: On Study - Patient Profile'; 
 endcomp;
 
*/ begin reporting and printing of new and transposed data listings created */

ODS rtf CLOSE;
*/ end SAS ODS for creating document */
