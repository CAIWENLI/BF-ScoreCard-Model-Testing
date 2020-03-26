
create table sco.zs_car_totalbase_clus_v1
as
(
select t1.contract_no
,t1.target
,t1.inputdate
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CHILDREN_TOTAL' and a.testname=t1.children_total ) children_total
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='VEHICLE_PRICE  ' and a.testname=t1.VEHICLE_PRICE ) VEHICLE_PRICE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='SERVICE_FEE  ' and a.testname=t1.SERVICE_FEE ) SERVICE_FEE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='PROVINCE ' and a.testname=t1.PROVINCE ) PROVINCE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='PRODUCT_TYPE '  and a.testname=t1.PRODUCT_TYPE ) PRODUCT_TYPE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='PAYMENT_SUM  ' and a.testname=t1.PAYMENT_SUM ) PAYMENT_SUM
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='MONTH_TOTAL ' and a.testname=t1.MONTH_TOTAL ) MONTH_TOTAL
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='MFEE_SUM ' and a.testname=t1.MFEE_SUM ) MFEE_SUM
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='MARRIAGE_STAUTS ' and a.testname=t1.MARRIAGE_STAUTS ) MARRIAGE_STAUTS
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='HOUSE_HAVE ' and a.testname=t1.HOUSE_HAVE ) HOUSE_HAVE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='HEADSHIP ' and a.testname=t1.HEADSHIP ) HEADSHIP
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='GPS_SUM ' and a.testname=t1.GPS_SUM ) GPS_SUM
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='EDU_EXPERIENCE ' and a.testname=t1.EDU_EXPERIENCE ) EDU_EXPERIENCE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CUSTOMER_GENDER ' and a.testname=t1.CUSTOMER_GENDER ) CUSTOMER_GENDER
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CAR_TOTAL  ' and a.testname=t1.CAR_TOTAL ) CAR_TOTAL
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CAR_GUIDEPRICE  ' and a.testname=t1.CAR_GUIDEPRICE ) CAR_GUIDEPRICE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CAR_BRAND ' and a.testname=t1.CAR_BRAND ) CAR_BRAND
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CARSTATUS1' and a.testname=t1.CARSTATUS1 ) CARSTATUS1
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='BUSINESSSUM  ' and a.testname=t1.BUSINESSSUM ) BUSINESSSUM
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='BELONG_AREA ' and a.testname=t1.BELONG_AREA ) BELONG_AREA

from sco.zs_car_totalbase_testname_v1 t1
);
