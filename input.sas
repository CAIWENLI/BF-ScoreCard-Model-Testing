libname car "E:\江楠\SAS 代码\2016-04-28 汽车金融评分卡2\sas数据集";
data car.BASE    ;
   %let _EFIERR_ = 0;
   infile
'E:\江楠\SQL SCRIPT\新的任务\汽车金融评分卡 2016-04-28\宽表.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
 informat CONTRACT_NO	$20.             ;
informat TARGET	best32.                 ;
informat INPUTDATE	yymmdd10.           ;
informat CUSTOMER_GENDER	$20.        ;
informat CUSTOMER_TYPE	$50.            ;
informat CERT_TYPE	$50.                ;
informat CERTF_AWD_YEAR	best32.         ;
informat CERTF_EXP_YEAR	best32.         ;
informat CUSTOMER_AGE	best32.         ;
informat MARRIAGE_STAUTS	$50.         ;
informat NATIVE_PLACE	$50.                ;
informat EDU_EXPERIENCE	$50.            ;
informat EDU_DEGREE	$50.                ;
informat WORK_CUR_YEARS	best32.         ;
informat WORK_TOT_YEARS	best32.         ;
informat OCCUPATION	$50.                ;
informat HEADSHIP	$50.                    ;
informat POSITION	$50.                    ;
informat EMPLOYEE_TYPE	$50.            ;
informat HOUSE_HAVE	$50.                ;
informat HOUSE_YEARS	best32.             ;
informat CHILDREN_TOTAL	best32.         ;
informat ONESELF_INCOME	best32.         ;
informat SPOUSE_INCOME	best32.         ;
informat OTHER_REVENUE	best32.         ;
informat AGE_INCOME	best32.             ;
informat MONTH_TOTAL	best32.             ;
informat MONTH_EXPEND	best32.             ;
informat RENT_EXPEND	best32.             ;
informat CREDIT_MONTH	best32.             ;
informat NET_MARGIN	best32.             ;
informat SERVICEPROVIDERS_TYPE	$50.    ;
informat SERVICEPROVIDER_SNAME	$100.   ;
informat RISK_IDENTIFICATION	$50.        ;
informat CITY	$50.                        ;
informat PROVINCE	$50.                    ;
informat BELONG_AREA	$50.                ;
informat BILL_RIGHT	$50.                ;
informat SERVICEPROVIDERS_BANK	$100.   ;
informat PRODUCT_TYPE	$50.                ;
informat MONTHCALCULATION_METHOD	$50.    ;
informat CAR_CARUSE	$100.               ;
informat CAR_HAVE	$50.                    ;
informat CAR_SPECIFICATIONS	$50.        ;
informat CAR_STATUS	$50.                ;
informat CAR_BRAND	$50.                ;
informat GPS_FLAG	$50.                    ;
informat GPS_SUM	best32.                 ;
informat CAR_GUIDEPRICE	best32.         ;
informat ASSESS_PRICE	best32.             ;
informat CAR_YEAR	best32.                 ;
informat CAR_JORUNEY	best32.             ;
informat USEDASSESS_FEE	best32.         ;
informat STAMP_TAXAMT	best32.             ;
informat SERVICE_FEE	best32.             ;
informat MFEE_SUM	best32.                 ;
informat VEHICLE_PRICE	best32.         ;
informat ALLOCATION_SUM	best32.         ;
informat INSURANCE_SUM	best32.         ;
informat REVENUE_TAX	best32.             ;
informat CAR_TOTAL	best32.             ;
informat PAYMENT_RATE	best32.             ;
informat PAYMENT_SUM	best32.             ;
informat FINALPAYMENT_RATE	best32.     ;
informat FINALPAYMENT_SUM	best32.         ;
informat DEPOSIT_RATE	best32.             ;
informat DEPOSIT_SUM	best32.             ;
informat PERIODS	best32.                 ;
informat PUTOUT_APPLYAMOUNT	best32.     ;
informat CREDIT_RATE	best32.             ;
informat REPAYMENT_WAY	$50.            ;
informat REPLACE_BANK	$50.                ;
informat COAPPLICANT_CNT	best32.         ;
informat WITNESS_CNT	best32.             ;
informat ASSURER_CNT	best32.             ;
informat PARTICIPANT_CNT	best32.         ;
informat PARTICIPANT1_CNT	best32.         ;
informat PARTICIPANT2_CNT	best32.         ;
informat PARTICIPANT3_CNT	best32.         ;
informat PARTICIPANT4_CNT	best32.         ;
informat PARTICIPANT5_CNT	best32.         ;
informat PARTICIPANT6_CNT	best32.         ;
informat PARTICIPANT7_CNT	best32.         ;
informat PARTICIPANT8_CNT	best32.         ;
informat PARTICIPANT9_CNT	best32.         ;
format CONTRACT_NO	$20.                ;
format TARGET	best32.                 ;
format INPUTDATE	yymmdd10.           ;
format CUSTOMER_GENDER	$20.            ;
format CUSTOMER_TYPE	$50.            ;
format CERT_TYPE	$50.                ;
format CERTF_AWD_YEAR	best32.         ;
format CERTF_EXP_YEAR	best32.         ;
format CUSTOMER_AGE	best32.             ;
format MARRIAGE_STAUTS	$50.            ;
format NATIVE_PLACE	$50.                ;
format EDU_EXPERIENCE	$50.            ;
format EDU_DEGREE	$50.                ;
format WORK_CUR_YEARS	best32.         ;
format WORK_TOT_YEARS	best32.         ;
format OCCUPATION	$50.                ;
format HEADSHIP	$50.                    ;
format POSITION	$50.                    ;
format EMPLOYEE_TYPE	$50.            ;
format HOUSE_HAVE	$50.                ;
format HOUSE_YEARS	best32.             ;
format CHILDREN_TOTAL	best32.         ;
format ONESELF_INCOME	best32.         ;
format SPOUSE_INCOME	best32.         ;
format OTHER_REVENUE	best32.         ;
format AGE_INCOME	best32.             ;
format MONTH_TOTAL	best32.             ;
format MONTH_EXPEND	best32.             ;
format RENT_EXPEND	best32.             ;
format CREDIT_MONTH	best32.             ;
format NET_MARGIN	best32.             ;
format SERVICEPROVIDERS_TYPE	$50.    ;
format SERVICEPROVIDER_SNAME	$100.   ;
format RISK_IDENTIFICATION	$50.        ;
format CITY	$50.                        ;
format PROVINCE	$50.                    ;
format BELONG_AREA	$50.                ;
format BILL_RIGHT	$50.                ;
format SERVICEPROVIDERS_BANK	$100.   ;
format PRODUCT_TYPE	$50.                ;
format MONTHCALCULATION_METHOD	$50.    ;
format CAR_CARUSE	$100.               ;
format CAR_HAVE	$50.                    ;
format CAR_SPECIFICATIONS	$50.        ;
format CAR_STATUS	$50.                ;
format CAR_BRAND	$50.                ;
format GPS_FLAG	$50.                    ;
format GPS_SUM	best32.                 ;
format CAR_GUIDEPRICE	best32.         ;
format ASSESS_PRICE	best32.             ;
format CAR_YEAR	best32.                 ;
format CAR_JORUNEY	best32.             ;
format USEDASSESS_FEE	best32.         ;
format STAMP_TAXAMT	best32.             ;
format SERVICE_FEE	best32.             ;
format MFEE_SUM	best32.                 ;
format VEHICLE_PRICE	best32.         ;
format ALLOCATION_SUM	best32.         ;
format INSURANCE_SUM	best32.         ;
format REVENUE_TAX	best32.             ;
format CAR_TOTAL	best32.             ;
format PAYMENT_RATE	best32.             ;
format PAYMENT_SUM	best32.             ;
format FINALPAYMENT_RATE	best32.     ;
format FINALPAYMENT_SUM	best32.         ;
format DEPOSIT_RATE	best32.             ;
format DEPOSIT_SUM	best32.             ;
format PERIODS	best32.                 ;
format PUTOUT_APPLYAMOUNT	best32.     ;
format CREDIT_RATE	best32.             ;
format REPAYMENT_WAY	$50.            ;
format REPLACE_BANK	$50.                ;
format COAPPLICANT_CNT	best32.         ;
format WITNESS_CNT	best32.             ;
format ASSURER_CNT	best32.             ;
format PARTICIPANT_CNT	best32.         ;
format PARTICIPANT1_CNT	best32.         ;
format PARTICIPANT2_CNT	best32.         ;
format PARTICIPANT3_CNT	best32.         ;
format PARTICIPANT4_CNT	best32.         ;
format PARTICIPANT5_CNT	best32.         ;
format PARTICIPANT6_CNT	best32.         ;
format PARTICIPANT7_CNT	best32.         ;
format PARTICIPANT8_CNT	best32.         ;
format PARTICIPANT9_CNT	best32.         ;
    input
CONTRACT_NO	$
TARGET	
INPUTDATE	
CUSTOMER_GENDER	$
CUSTOMER_TYPE	$
CERT_TYPE	$
CERTF_AWD_YEAR	
CERTF_EXP_YEAR	
CUSTOMER_AGE	
MARRIAGE_STAUTS	$
NATIVE_PLACE	$
EDU_EXPERIENCE	$
EDU_DEGREE	$
WORK_CUR_YEARS	
WORK_TOT_YEARS	
OCCUPATION	$
HEADSHIP	$
POSITION	$
EMPLOYEE_TYPE	$
HOUSE_HAVE	$
HOUSE_YEARS	
CHILDREN_TOTAL	
ONESELF_INCOME	
SPOUSE_INCOME	
OTHER_REVENUE	
AGE_INCOME	
MONTH_TOTAL	
MONTH_EXPEND	
RENT_EXPEND	
CREDIT_MONTH	
NET_MARGIN	
SERVICEPROVIDERS_TYPE	$
SERVICEPROVIDER_SNAME	$
RISK_IDENTIFICATION	$
CITY	$
PROVINCE	$
BELONG_AREA	$
BILL_RIGHT	$
SERVICEPROVIDERS_BANK	$
PRODUCT_TYPE	$
MONTHCALCULATION_METHOD	$
CAR_CARUSE	$
CAR_HAVE	$
CAR_SPECIFICATIONS	$
CAR_STATUS	$
CAR_BRAND	$
GPS_FLAG	$
GPS_SUM	
CAR_GUIDEPRICE	
ASSESS_PRICE	
CAR_YEAR	
CAR_JORUNEY	
USEDASSESS_FEE	
STAMP_TAXAMT	
SERVICE_FEE	
MFEE_SUM	
VEHICLE_PRICE	
ALLOCATION_SUM	
INSURANCE_SUM	
REVENUE_TAX	
CAR_TOTAL	
PAYMENT_RATE	
PAYMENT_SUM	
FINALPAYMENT_RATE	
FINALPAYMENT_SUM	
DEPOSIT_RATE	
DEPOSIT_SUM	
PERIODS	
PUTOUT_APPLYAMOUNT	
CREDIT_RATE	
REPAYMENT_WAY	$
REPLACE_BANK	$
COAPPLICANT_CNT	
WITNESS_CNT	
ASSURER_CNT	
PARTICIPANT_CNT	
PARTICIPANT1_CNT	
PARTICIPANT2_CNT	
PARTICIPANT3_CNT	
PARTICIPANT4_CNT	
PARTICIPANT5_CNT	
PARTICIPANT6_CNT	
PARTICIPANT7_CNT	
PARTICIPANT8_CNT	
PARTICIPANT9_CNT	

    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;

