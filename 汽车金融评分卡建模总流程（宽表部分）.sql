；
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------  车贷评分卡（张双版）   ---------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
/**********************************************************************************
    * 功能：汽车金融评分卡建模总流程（宽表部分）
    * 创建人：张双
    * 创建时间：2016/09/07
    * 更新时间：2016/09/07
    * 版本：V1.0
**********************************************************************************/
select * from cu.zs_car_total1--未清洗的宽表
select * from cu.zs_car_total2--清洗的宽表（清洗的联系人、车况）
select * from sco.zs_car_base--最终的宽表（清洗车牌、部分变量衍生） 
select * from cu.ZS_CAR_ADD_BASETRAIN--训练集（增加贷款金额）
select * from sco.zs_car_train--最终训练集
select * from cu.zs_car_add_basetest--测试集（增加贷款金额）
select * from sco.zs_car_test--最终测试集

-----------------------------------------------------------------------
----------------------------一. 建立中间表-------------------------------
-----------------------------------------------------------------------


---------------------------- Section 1.1 未清洗的宽表
/*

*/
insert into cu.zs_car_total1
;
---------------------------- Section 1.2 清洗的宽表（清洗的联系人、车况）
/*
select * from cu.zs_car_total2;
*/

insert into cu.zs_car_total2(CONTRACT_NO, DEF_FPD30, DEF_SPD30, DEF_TPD30, DEF_QPD30, DEF_FIVEPD30, DEF_SIXPD30, DEF_SEVENPD30, AGR_FPD30, AGR_SPD30, AGR_TPD30, AGR_QPD30, AGR_FIVEPD30, AGR_SIXPD30, AGR_SEVENPD30, DPD30, TARGET, CUSTOMERID, CUSTOMER_GENDER, CUSTOMER_TYPE, CUSTOMER_NAME, BIRTH_DAY, CERT_TYPE, CERT_ID, AWARD_DATE, CERT_MATURITYDATE, CUSTOMER_AGE, MARRIAGE_STAUTS, NATIVE_PLACE, EDU_EXPERIENCE, EDU_DEGREE, FAMILY_ADD, WORK_CORP, WORK_ADD, CONTACT_ADD, MOBILE_TELEPHONE, FAMILY_TEL, WORK_TEL, JOB_BEGINDATE, OCCUPA_TION, HEAD_SHIP, POSI_TION, EMPLOYEE_TYPE, HOUSE_HAVE, FIRSTHOUSE_DATE, CHILDREN_TOTAL, ONESELF_INCOME, SPOUSE_INCOME, OTHER_REVENUE, AGE_INCOME, MONTH_TOTAL, MONTH_EXPEND, RENT_EXPEND, CREDIT_MONTH, NET_MARGIN, INPUTDATE, SERVICEPROVIDERS_TYPE, SERVICEPROVIDER_NO, SERVICEPROVIDER_SNAME, EXHIBITIONHALL_NO, EXHIBITIONHALL, RISK_IDENTIFICATION, CITY, PROVINCE, BELONG_AREA, BILL_RIGHT, MANAGERNAME, FINANCIALMANAGER, FINANCIALMANAGERTEL, SERVICEPROVIDERS_BANK, SERVICEPROVIDERSACCOUNT_TYPE, SERVICEPROVIDERS_ACCOUNTT, SERVICEPROVIDERS_BRANCH, WITNESS_CERTNO, WITNESS_NAME, WITNESS_PHONE, PRODUCT_NAME, PRODUCT_TYPE, MONTHCALCULATION_METHOD, CAR_CARUSE, CAR_HAVE, CAR_SPECIFICATIONS, CAR_STATUS, CAR_BRAND, CAR_TYPE, CAR_NUMBER, CAR_COLOUR, GPS_FLAG, GPS_SUM, CAR_GUIDEPRICE, ASSESS_PRICE, CAR_YEAR, CAR_JORUNEY, USEDASSESS_FEE, STAMP_TAXAMT, SERVICE_FEE, MFEE_SUM, VEHICLE_PRICE, ALLOCATION_SUM, INSURANCE_SUM, REVENUE_TAX, CAR_TOTAL, PAYMENT_RATE, PAYMENT_SUM, FINALPAYMENT_RATE, FINALPAYMENT_SUM, DEPOSIT_RATE, DEPOSIT_SUM, PERIODS, PUTOUT_APPLYAMOUNT, CREDIT_RATE, REPAYMENT_WAY, REPLACE_BANK, REPLACE_ACCOUNT, REPLACE_NAME, CO_APPLICANT, COAPPLICANT_ID, COAPPLICANT_CUSTOMERID, COAPPLICANT_PHONE, ASSURER, ASSURER_ID, ASSURER_CUSTOMERID, ASSURER_PHONE, PARTICIPANT_NAME, PARTICIPANT_PHONE, PARTICIPANT_STATUS, PARTICIPANT_ADD, WORKBEGINDATE, CARSTATUS1, PARTICIPANTSTATUS, PARTICIPANT_CNT, COAPPLICANT_CNT, WITNESS_CNT, ASSURER_CNT, PARTICIPANT1_CNT, PARTICIPANT2_CNT, PARTICIPANT3_CNT, PARTICIPANT4_CNT, PARTICIPANT5_CNT, PARTICIPANT6_CNT, PARTICIPANT7_CNT, PARTICIPANT8_CNT, PARTICIPANT9_CNT)
---------车贷宽表--------------------
 SELECT 
tt.*
,(case when product_type in ('车抵融','快抵融','第一车网','一证通（二手车）','二手宝捷融','二手快捷融','二手轻松购','二手融e购')  then '二手车'
when product_type in ('宝捷融LCV','聚宝融','快捷融','快捷融2.0','气球融','轻卡融','舒心融','新车宝捷融') then '新车'
else '其它' end)carstatus
,a.participantstatus
,a.participant_cnt
,a.coapplicant_cnt
,a.witness_cnt
,a.assurer_cnt
,a.participant1_cnt,
a.participant2_cnt,
a.participant3_cnt,
a.participant4_cnt,
a.participant5_cnt,
a.participant6_cnt,
a.participant7_cnt,
a.participant8_cnt,
a.participant9_cnt
,a.workbegindate 
FROM
(
select  
        bc.serialno,        ----主借款人（个人/企业/自雇）信息
        nvl(ii.customerid,ei.customerid) customerid,
        nvl(nvl(decode(ii.sex,'1','男','2','女'),decode(ei.sex,'1',' 男','2','女')),
            case when ii.certtype='Ind01' and mod(substr(ii.certid,17,1),2)=0 then '女'
                 when ii.certtype='Ind01' and mod(substr(ii.certid,17,1),2)=1 then '男'
                 when ei.certtype='Ind01' and mod(substr(ei.certid,17,1),2)=0 then '女'
                 when ei.certtype='Ind01' and mod(substr(ei.certid,17,1),2)=1 then '男'
                 else null end) customer_gender,
        (select itemname from s3.code_library where codeno='CustomerType' and isinuse='1' and itemno =bc.CustomerType)Customer_Type, 
        nvl(ii.customername,case when ei.customertype='04' then ei.customername else ei.legalperson end)customer_name,
        nvl(nvl(ii.birthday,ei.birthday),
            case when ii.certtype='Ind01' then substr(ii.certid,7,4)||'/'||substr(ii.certid,11,2)||'/'||substr(ii.certid,13,2)
                 when ei.certtype='Ind01' and length(ei.certid)=18 then substr(ei.certid,7,4)||'/'||substr(ei.certid,11,2)||'/'||substr(ei.certid,13,2)
                 else null end) birth_day,
        nvl((select ItemName from s3.code_library where codeno='CertType' and ItemDescribe='Car' and ItemNo=ii.certtype),
             case when ei.certtype='Ind01' then '身份证' when ei.certtype='Ent02' then '组织机构代码证' else null end)Cert_Type,
        nvl(ii.certid,case when ei.certtype='Ind01' then ei.certid when ei.certtype='Ent02' then ei.organizationcode else null end)cert_id, 
        nvl(ii.awarddate,ei.awarddate) award_date ,
        nvl(ii.maturitydate,ei.maturitydate) cert_maturitydate,
        nvl(nvl(ii.age,ei.age),
             case when ii.certtype='Ind01' and length(ii.certid)=18 then 
                       to_number(trunc(((to_date(bc.applydate,'yyyy/mm/dd')-to_date(substr(ii.certid,7,4)||'/'||substr(ii.certid,11,2)||'/'||substr(ii.certid,13,2),'yyyy/mm/dd'))/365)))
                  when ei.certtype='Ind01' and length(ei.certid)=18 then 
                       to_number(trunc(((to_date(bc.applydate,'yyyy/mm/dd')-to_date(substr(ei.certid,7,4)||'/'||substr(ei.certid,11,2)||'/'||substr(ei.certid,13,2),'yyyy/mm/dd'))/365)))
                  else null end)customer_age,
        nvl((select itemname from s3.code_library where codeno='Marriage' and  ITEMNO = ii.Marriage),(select itemname from s3.code_library where codeno='Marriage' and  ITEMNO = ei.Marriage))Marriage_stauts,
        nvl((select itemname from s3.CODE_LIBRARY where codeno='AreaCode' and itemno=ii.nativeplace),(select itemname from s3.CODE_LIBRARY where codeno='AreaCode' and itemno=ei.nativeplace))native_place,
        nvl((select itemname from s3.code_library where codeno='EducationExperience' and ITEMNO = ii.eduexperience),
            (select itemname from s3.code_library where codeno='EducationExperience' and ITEMNO = ei.eduexperience))edu_experience,
        nvl((select itemname from s3.code_library where codeno='EducationDegree' and ITEMNO = ii.edudegree),
            (select itemname from s3.code_library where codeno='EducationDegree' and ITEMNO = ei.edudegree)) edu_degree,
        nvl(nvl((select itemname from s3.CODE_LIBRARY where codeno='AreaCode' and itemno=ii.familyadd)||ii.countryside||ii.villagecenter||ii.plot||ii.room,
            (select itemname from s3.CODE_LIBRARY where codeno='AreaCode' and itemno=ei.familyadd)||ei.countryside||ei.villagecenter||ei.plot||ei.room)
            ,ei.registeradd) family_add,
        nvl(ii.workcorp,ei.workcorp)work_corp,
        nvl((select itemname from s3.CODE_LIBRARY where codeno='AreaCode' and itemno=ii.workadd)||ii.unitcountryside||ii.unitstreet||ii.unitroom||ii.unitno,
            (select itemname from s3.CODE_LIBRARY where codeno='AreaCode' and itemno=ei.workadd)||ei.unitcountryside||ei.unitstreet||ei.unitroom||ei.unitno) work_add,
       (case when ii.flag6='01' then (select itemname from s3.CODE_LIBRARY where codeno='AreaCode' and itemno=ii.workadd)||ii.unitcountryside||ii.unitstreet||ii.unitroom||ii.unitno                          
             when ii.flag6='02' then (select itemname from s3.CODE_LIBRARY where codeno='AreaCode' and itemno=ii.familyadd)||ii.countryside||ii.villagecenter||ii.plot||ii.room
             when ei.flag6='01' then (select itemname from s3.CODE_LIBRARY where codeno='AreaCode' and itemno=ei.workadd)||ei.unitcountryside||ei.unitstreet||ei.unitroom||ei.unitno
             when ei.flag6='02' then nvl((select itemname from s3.CODE_LIBRARY where codeno='AreaCode' and itemno=ei.familyadd)||ei.countryside||ei.villagecenter||ei.plot||ei.room,ei.registeradd)
             else null end) contact_add,
    nvl(ii.mobiletelephone,ei.mobiletelephone)mobile_telephone,
    nvl(ii.Familytel,ei.familytel)family_tel,
    nvl(ii.worktel,ei.worktel)work_tel,
    nvl(ii.jobbegindate,ei.jobbegindate) job_begindate,
    nvl((select itemname from s3.code_library where codeno ='Occupation' and itemno=ii.Occupation),
        (select itemname from s3.code_library where codeno ='Occupation' and itemno=ei.Occupation))Occupa_tion,
    nvl((select ItemName from s3.CODE_LIBRARY where CodeNo = 'HeadShip' and itemno=ii.headship),
        (select ItemName from s3.CODE_LIBRARY where CodeNo = 'HeadShip' and itemno=ei.headship))head_ship,
    nvl((select ItemName from s3.CODE_LIBRARY where CodeNo = 'TechPost' and itemno=ii.position),
        (select ItemName from s3.CODE_LIBRARY where CodeNo = 'TechPost' and itemno=ei.position))posi_tion,
    nvl((select itemname from s3.code_library where codeno='EmployeeType' and itemno=ii.employeetype),
        (select itemname from s3.code_library where codeno='EmployeeType' and itemno=ei.employeetype))employee_type,
    nvl((select itemname from s3.code_library where codeno='HaveNot' and itemno=ii.flag5),
        (select itemname from s3.code_library where codeno='HaveNot' and itemno=ei.flag5))house_have,
    nvl(ii.housedate,ei.housedate) firsthouse_date,
    nvl(ii.childrentotal,ei.childrentotal) children_total, 
    nvl(ii.oneselfincome,ei.oneselfincome) oneself_income,
    nvl(ii.spouseincome,ei.spouseincome) spouse_income,
    nvl(ii.otherrevenue,ei.otherrevenue) other_revenue,
    nvl(ii.ageincome,ei.ageincome) age_income,
    nvl(ii.monthtotal,ei.monthtotal) month_total,
    nvl(ii.monthexpend,ei.monthexpend) month_expend,
    nvl(ii.rentexpend,ei.rentexpend) rent_expend,
    nvl(ii.creditmonth,ei.creditmonth) credit_month,
    nvl(ii.netmargin,ei.netmargin) net_margin,
     ii.workbegindate,             
     (select itemname from s3.code_library where codeno='DistributorType' and itemno=sp.serviceproviderstype)SERVICEPROVIDERS_TYPE,    ----经销商信息
     sp.serialno serviceprovider_no,
     sp.serviceprovidersname serviceprovider_sname,
     si.sno exhibitionhall_no,  
     si.sname exhibitionhall,
     sp.riskidentification risk_identification,
     (select ItemName from s3.Code_Library where CodeNo='AreaCode' and ItemNo=sp.city)city,
     (select attr2 from s3.baseDataSet_info where TypeCode='AreaCodeCar' and attr1=sp.BelongArea)Belong_Area,
   rcas.pkg_utl.f_get_province_name(si.city) province,
     (select itemname from s3.code_library where codeno = 'YesNo' and itemno = sp.BillRight)Bill_Right,
      bc.ManagerName,
      bc.INPUTDATE,
      sp.financialmanager,
      sp.financialmanagertel,
         
                     
      a.putoutdate putout_date,                                                                                           ----放款信息
      bc.lastputoutapplytime lastputout_applytime,
      bc.putoutentrytime putout_entrytime,
      bc.putoutapprovetime putout_approvetime,
      bc.putoutexecutetime putout_executetime,
      a.maturitydate maturity_date,
      bc.businesssum apply_businesssum,
      a.businesssum putout_businesssum,
              
                                                              ----逾期情况信息
      a.lastduedate last_duedate,
      a.nextduedate next_duedate,
      a.overduedays over_duedays,
      a.historymaxcpddays history_maxcpd,
      a.normalbalance normal_balance,
      a.overduebalance overdue_balance,
      a.odintebalance odinte_balance,
      a.fineintebalance fineinte_balance,
      a.compdintebalance compdinte_balance,
      a.ACCRUEINTEBALANCE ACCRUEINTE_BALANCE,                ---可增加现在的总余额
      
      (select itemname from s3.code_library where codeno = 'BankCode' and itemno = ai.bankname) serviceproviders_Bank,                ----经销商银行信息
      (select itemname from s3.code_library where codeno = 'Accouncitype1' and itemno = ai.accounttype) serviceprovidersaccount_Type,
      ai.accountNo serviceproviders_accountt,
      (select BankName from s3.Bank_Info where BankNo = ai.openbranch)serviceproviders_branch,
    
    
      wi.certno witness_certno,                         ----见证人信息
      wi.contactsname witness_name,
      wi.contactsphone witness_phone,
      wi.contacts_cnt witness_cnt,
    
        bc.productname product_name,                    ----产品信息
        (case when bc.productname like '%佰仟快捷融%' then '快捷融' when bc.productname like '%佰仟舒心融%' then '舒心融'
      when bc.productname like '%气球融%' then '气球融' when bc.productname like '%二手车快捷融%' then '二手快捷融'
      when bc.productname like '%二手车轻松购%' then '二手轻松购'
      when bc.productname like '%佰仟二手车融e购%' then '二手融e购' 
      when bc.productname like '%车抵融%' then '车抵融' 
      when bc.productname like '%聚宝融%' then '聚宝融'
      when bc.productname like '%员工%' then '员工融'
      When bc.productname like '%快抵融%' then '快抵融' 
      when bc.productname like '%轻卡融%' then '轻卡融'
      when bc.productname like '%快捷融2.0%' then '快捷融2.0' 
      when bc.productname like '%一证通（二手车）%' then '一证通（二手车）'
      when bc.productname like '%一证通（新车）%' then '快捷融2.0'
      when bc.productname like '%佰仟e%'  then '汽车之家'
      when bc.productname like '%网速融%'  then '第一车网'
      when bc.productname like '宝捷融（新车%' then '新车宝捷融'
      when bc.productname like '宝捷融（二手%' then '二手宝捷融'
      when bc.productname like '宝捷融（LCV%' then '宝捷融LCV'
      else '其他' end) PRODUCT_TYPE,
        bt.typename business_type,
        to_number(bt.isinuse)product_isinuse,
        bt.monthcalculationmethod monthcalculation_method,
    (select itemname from s3.code_library where codeno = ' ' and itemno = bc.uncreditflag) uncredit_flag,    
    (select itemname from s3.code_library where codeno = 'CarCaruse' and itemno=bc.carcaruse)car_caruse,                           ----车况信息
    (select itemname from s3.code_library where codeno = 'HaveNot' and itemno=bc.falg7) car_have,   
    decode (bc.carspecifications ,'01' , '美规车','02' , '中规车') car_specifications, 
    decode(bc.carstatus,'01','新车','02','二手车','03','试乘试驾')car_status,  
    bc.carbrand car_brand,
    bc.cartype car_type,
    bc.carframe car_frame,
    bc.carnumber car_number,
    bc.carcolour car_colour,
    (select itemname from s3.code_library where codeno = 'YesNo' and itemno = bc.GPSflag) GPS_flag,
    bc.gpssum gps_sum,
    bc.carguideprice car_guideprice,
    bc.assessprice assess_price,                 
    bc.caryear car_year,
    bc.Journey car_joruney,          
  
                                           
    bc.usedassessfee usedassess_fee,                       ----费用信息
    bc.stamptaxamt stamp_taxamt,
    bc.servicefee service_fee,
    bc.mfeesum  mfee_sum,         
    bc.vehicleprice vehicle_price,             
    bc.allocationsum allocation_sum,
    bc.insurancesum insurance_sum, 
    bc.revenuetax revenue_tax, 
    bc.cartotal car_total,             
    bc.paymentrate payment_rate,
    bc.paymentsum payment_sum,
    bc.finalpayment finalpayment_rate,
    bc.finalpaymentsum finalpayment_sum,
    bc.deposit deposit_rate,
    bc.bailsum deposit_sum,
   
    
    bc.periods,                                           ----贷款信息  
    bc.applyreturnamount apply_returnamount,
    bc.putoutapplyamount putout_applyamount,
    to_number(bc.creditrate)credit_rate,               
    bc.applydate apply_date,
  bc.returnbackopinion returnback_opinion,
    (select itemname from s3.code_library where codeno='RepaymentWay' and itemno=bc.repaymentway) repayment_way,
   
    (select serviceprovidersname from s3.Service_Providers where CustomerType1='05' and SerialNo= openbank)replace_bank,      ----代扣信息
    bc.replaceaccount replace_account, 
    bc.replacename replace_name, 
    
    co.customername co_applicant,                        ----共同申请人
    co.certid coapplicant_id,
    co.customerid  coapplicant_customerid,
    co.mobiletelephone coapplicant_phone,
    co.customer_cnt coapplicant_cnt,
    
    su.customername assurer,                             ----保证人
    su.certid assurer_id,
    su.customerid assurer_customerid,
    su.customer_cnt assurer_cnt,
    (select i.mobiletelephone from s3.ind_info i where i.customerid=su.customerid) assurer_phone,
                                    
    cp.participantname participant_name,                   ---关联人
    cp.participantphone participant_phone,               
    cp.participantstatus participantstatus,
    cp.participantadd participant_add,
    cp.participant_cnt,
    cp.participant1_cnt,
    cp.participant2_cnt,
    cp.participant3_cnt,
    cp.participant4_cnt,
    cp.participant5_cnt,
    cp.participant6_cnt,
    cp.participant7_cnt,
    cp.participant8_cnt,
    cp.participant9_cnt,

    
    bc.remark,   
    mi.express contract_express,
    mi.expressno contract_expressno,
    mi.maildate contract_maildate,
    mi.remark express_remark

from  s3.business_contract_cu bc 
left join s3.mail_info mi
on mi.contractserialno=bc.serialno
left join s3.ind_info ii 
on bc.customerid=ii.customerid
left join s3.ent_info ei
on bc.customerid=ei.customerid
left join s3.store_info si
on bc.stores=si.sno
left join s3.service_providers sp
on sp.serialno=si.rserialno
left join s3.account_information ai
on sp.serialno=ai.relativeserialno
left join s3.acct_loan a
on bc.serialno=a.putoutno 


left join
(
select relativeserialno,
       listagg(wi.contactsname,' & ')within group (order by wi.relativeserialno) contactsname,
       listagg(wi.contactsphone,' & ')within group (order by wi.relativeserialno) contactsphone,
       listagg(wi.certno,' & ')within group (order by wi.relativeserialno) certno
       ,count(wi.contactsname)contacts_cnt
from s3.witness_information wi 
group by relativeserialno
)wi
on wi.relativeserialno=sp.serialno

left join s3.business_type bt
on bt.typeno=bc.businesstype
left join 
(
select ucp.customerid,listagg(cp.participantname,' & ')within group (order by ucp.customerid) participantname
    ,listagg(cp.participantphone,' & ') within group (order by ucp.customerid) participantphone 
    ,listagg(cp.participantstatus,' & ') within group (order by ucp.customerid) participantstatus
    ,listagg(cp.participantadd,' & ') within group (order by ucp.customerid) participantadd
    ,count(cp.participantadd) participant_cnt
    ,sum(case when cp.participantstatus = '父亲' then 1 else 0 end)participant1_cnt
    ,sum(case when cp.participantstatus = '母亲' then 1 else 0 end)participant2_cnt
    ,sum(case when cp.participantstatus = '配偶' then 1 else 0 end)participant3_cnt
    ,sum(case when cp.participantstatus = '子女' then 1 else 0 end)participant4_cnt
    ,sum(case when cp.participantstatus = '兄弟姐妹' then 1 else 0 end)participant5_cnt
    ,sum(case when cp.participantstatus in ('亲属','孙子') then 1 else 0 end)participant6_cnt
    ,sum(case when cp.participantstatus = '外系亲属' then 1 else 0 end)participant7_cnt
    ,sum(case when cp.participantstatus in ('同事','师徒') then 1 else 0 end)participant8_cnt
    ,sum(case when cp.participantstatus in ('朋友','同学') then 1 else 0 end)participant9_cnt
    from cu.zs_customer_PARTICIPANt cp
    left join
   (select customerid from s3.ind_info
           union
    select customerid from s3.ent_info
   ) ucp
    on cp.relativeserialno=ucp.customerid
    group by ucp.customerid
 ) cp
on cp.customerid=ii.customerid
left join(

select 
       serialno,
       listagg(co.customername,' & ')within group (order by co.serialno) customername,
       listagg(co.certid,' & ')within group (order by co.serialno) certid,
       listagg(co.customerid,' & ')within group (order by co.serialno) customerid,
       listagg(co.mobiletelephone,' & ') within group (order by co.serialno)mobiletelephone
       ,count(co.customername) customer_cnt
from
(select distinct t.*,cr.serialno,uc.mobiletelephone from s3.contract_relative cr,
       (select * from s3.customer_info where customerid in (select ii.customerid from s3.ind_info ii))t,
            (select customerid,mobiletelephone from s3.ind_info
            union
            select  customerid,mobiletelephone from s3.ent_info) uc
where cr.objectno = t.customerid and cr.objecttype='BusinessContract' and cr.customerrole='02' and uc.customerid = cr.objectno
) co
 group by serialno
) co
on bc.serialno = co.serialno 
left join
(
select 
       serialno,
       listagg(su.customername,' & ')within group (order by su.serialno) customername,
       listagg(su.certid,' & ')within group (order by su.serialno) certid,
       listagg(su.customerid,' & ')within group (order by su.serialno) customerid,
       listagg(su.mobiletelephone,' & ') within group (order by su.serialno)mobiletelephone
       ,count(su.customername)  customer_cnt
from
(select distinct t.*,cr.serialno,uc.mobiletelephone from s3.contract_relative cr,(select * from s3.customer_info where customerid in (select ii.customerid from s3.ind_info ii))t,
            (select customerid,mobiletelephone from s3.ind_info
            union
            select  customerid,mobiletelephone from s3.ent_info
            ) uc
where cr.objectno = t.customerid 
and cr.objecttype='BusinessContract' 
and cr.customerrole='03' 
and uc.customerid = cr.objectno
)su
group by serialno)su
on bc.serialno = su.serialno 
)A
left join 
(
select tt1.putoutno,tt2.firstduedate
from s3.acct_loan tt1
join s3.acct_rpt_segment tt2 
on tt1.serialno=tt2.objectno 
and tt2.objecttype='jbo.app.ACCT_LOAN' 
)E
on E.PUTOUTNO=A.SERIALNO
join rcas.v_Car_Indicators t
on A.serialno=t.CONTRACT_NO
join cu.zs_car_total1 tt
on A.serialno=tt.CONTRACT_NO
;
commit;
---------------------------- Section 1.3 最终宽表 sco.zs_car_base
/*
select * from sco.zs_car_base;
*/ 
create table sco.zs_car_base as
(
select CONTRACT_NO,
       DEF_FPD30+DEF_SPD30+DEF_TPD30+DEF_QPD30+DEF_FIVEPD30 target,
       to_date(inputdate,'yyyy/mm/dd') inputdate,
       CUSTOMER_GENDER,
       CUSTOMER_TYPE,
       CERT_TYPE,
       --AWARD_DATE,     
       case when AWARD_DATE is not null 
       then round(months_between(to_date(t.inputdate,'yyyy/mm/dd'),to_date(AWARD_DATE,'yyyy/mm/dd'))/12) 
       else null end certf_awd_year,                            --身份证使用年限                                     -- 
       --CERT_MATURITYDATE,                                     --身份证到期日
       case when CERT_MATURITYDATE is not null 
       then round(months_between(to_date(CERT_MATURITYDATE,'yyyy/mm/dd'),to_date(t.inputdate,'yyyy/mm/dd'))/12) 
       else null end certf_exp_year,                             -- 身份证有效年限
       CUSTOMER_AGE,
       MARRIAGE_STAUTS,
       NATIVE_PLACE,                                             -- 出生地
       EDU_EXPERIENCE,                                           -- 学历
       EDU_DEGREE,                                               -- 学位
       --FAMILY_ADD,
       --WORK_CORP,
       --WORK_ADD,
       
       --work_begindate,                                         -- 最近工作开始时间
       case when workbegindate is not null
            then round(months_between(to_date(t.inputdate,'yyyy/mm/dd'),to_date(t.workbegindate,'yyyy/mm/dd'))/12) 
       else null end work_cur_years,                             -- 工作年限
         
       case when JOB_BEGINDATE is not null
            then round(months_between(to_date(t.inputdate,'yyyy/mm/dd'),to_date(t.JOB_BEGINDATE,'yyyy/mm/dd'))/12) 
       else null end work_tot_years,                             -- 工作年限
       OCCUPA_TION OCCUPATION,                                   -- 职业
       HEAD_SHIP   HEADSHIP,                                     -- 职位
       POSI_TION   POSITION,                                     -- 职位2
       EMPLOYEE_TYPE,                                            -- 雇佣类型
       HOUSE_HAVE,                                               -- 是否自有房
       --FIRSTHOUSE_DATE,                                        -- 首次自有房时间
       case when FIRSTHOUSE_DATE is not null 
                 then round(months_between(to_date(FIRSTHOUSE_DATE,'yyyy/mm/dd'),to_date(t.inputdate,'yyyy/mm/dd'))/12) 
            else null end house_years,                           -- 自有房产年限
                 
      case when  CHILDREN_TOTAL>7 then 2 else  CHILDREN_TOTAL  end  CHILDREN_TOTAL ,-- 子女个数
       ONESELF_INCOME,                                           -- 个人月收入
       SPOUSE_INCOME,                                            -- 配偶月收入
       OTHER_REVENUE,                                            -- 其他月收入
       AGE_INCOME,                                               -- 年收入
       MONTH_TOTAL,                                              -- 月总收入
       MONTH_EXPEND,                                             -- 月总支出
       RENT_EXPEND,                                              -- 租金支出
       CREDIT_MONTH,                                             -- 贷款月供
       NET_MARGIN,                                               -- 月净收入
       SERVICEPROVIDERS_TYPE,                            -- 经销商类型
       SERVICEPROVIDER_SNAME,                            -- 经销商
       RISK_IDENTIFICATION,                              -- 风险标识
       CITY,                                             -- 城市
       PROVINCE,                                         -- 省份
       BELONG_AREA,                                      -- 区域
       BILL_RIGHT,                                       -- 是否具有开票权
       SERVICEPROVIDERS_BANK,                            -- 银行
       --WITNESS_CERTNO,
       --length(WITNESS_CERTNO)-length(replace(WITNESS_CERTNO,'&',''))+1 witness_id_cnt, -- 提供身份证号码数量
       --WITNESS_NAME,
       --length(WITNESS_NAME)-length(replace(WITNESS_NAME,'&',''))+1 witness_na_cnt,     -- 提供姓名数量
       --WITNESS_PHONE,
       --length(WITNESS_PHONE)-length(replace(WITNESS_PHONE,'&',''))+1 witness_ph_cnt,   -- 提供手机号码数量
       --PRODUCT_NAME,
       PRODUCT_TYPE,                                                      
       MONTHCALCULATION_METHOD,
       CAR_CARUSE,                                                   --是否自用
       CAR_HAVE,                                                     --是否有车
       CAR_SPECIFICATIONS,                                           --车型
       carstatus1,                                                    --车况
       (case when t.car_brand  like '%沃尔沃%' then '沃尔沃'
       when t.car_brand like '%菲亚特%' then '菲亚特'           
       when t.car_brand like '%莲花%' then '莲花'                
       when t.car_brand like '%三菱%' then '三菱'          
       when t.car_brand like '%三菱%' then '三菱'         
       when t.car_brand like '%凯迪拉克%' then '凯迪拉克'                
       when t.car_brand like '%丰田%' then '丰田'
       when t.car_brand like '%别克%' then '别克'
       when t.car_brand like '%铃木%' then '铃木'
       when t.car_brand like '%日产%' then '日产'         
       when t.car_brand like '%标致%' then '标致'            
       when t.car_brand like '%雪铁龙%' then '雪铁龙'
       when t.car_brand like '%马自达%' then '马自达'                 
       when t.car_brand like '%奔驰%' then '奔驰' 
       when t.car_brand like '%华泰%' then '华泰'            
       when t.car_brand like '%宝马%' then '宝马'        
       when t.car_brand like '%英菲尼迪' then '英菲尼迪'  
       when t.car_brand like '%Jeep' then 'Jeep' 
       when t.car_brand like '%雪佛兰' then '雪佛兰'            
       when (t.car_brand like '%奔驰' or t.car_brand like '%梅赛德斯%') then '奔驰'                                   
       when t.car_brand like '%丰田' then '丰田'                       
       when t.car_brand like '%海马%' then '海马' 
       when t.car_brand like '%三菱%' then '三菱'    
       when t.car_brand like '%奥迪%' then '奥迪'
       when t.car_brand like '%现代%' then '现代'       
       when t.car_brand like '%菲亚特%' then '菲亚特' 
       when t.car_brand like '%长城哈弗%' then '长城哈弗' 
       when t.car_brand like '%上汽荣威' then '上汽荣威'
       when t.car_brand like '%双龙%' then '双龙' 
       when t.car_brand like '%北京汽车%' then '北京汽车' 
       when t.car_brand like '%金龙%' then '金龙' 
       when t.car_brand like '%观致%' then '观致' 
       when t.car_brand like '%铃木%' then '铃木' 
       when t.car_brand like '%起亚%' then '起亚' 
       when t.car_brand like '%保时捷%' then '保时捷' 
       when t.car_brand like '%福田汽车%' then '福田汽车' 
       when t.car_brand like '%大运汽车%' then '大运汽车' 
       when t.car_brand like '%克莱斯勒%' then '克莱斯勒' 
       when t.car_brand like '%比亚迪%' then '比亚迪' 
       when t.car_brand like '%江铃%' then '江铃' 
       when t.car_brand like '%英菲尼迪%' then '英菲尼迪'
       when t.car_brand like '%吉奥%' then '吉奥'
       when t.car_brand like '%通用五菱%' then '通用五菱'
       when t.car_brand like '%海马%' then '海马'
       when t.car_brand like '%金杯%' then '金杯'
       when t.car_brand like '%中国重汽%' then '中国重汽'
       when t.car_brand like '%力帆%' then '力帆'
       when t.car_brand in( '迷你' ,'MINI') then 'MINI'
       when t.car_brand in ('上汽','上汽商用车','上汽集团') then '上汽汽车'
       else t.car_brand end ) carbrand ,                                --汽车品牌
       --CAR_TYPE,                                                     --汽车款式
       --CAR_NUMBER,                                                   --车牌
       --CAR_COLOUR,                                                   --汽车颜色
       GPS_FLAG,                                                     --是否有GPS
       GPS_SUM,                                                      --车管家费用
       CAR_GUIDEPRICE,                                               --汽车指导价格
       (case when USEDASSESS_FEE>0 then ASSESS_PRICE else 0 end ) ASSESS_PRICE,  --二手车评估费                                               --汽车评估价格
       to_number(case when USEDASSESS_FEE>0  then CAR_YEAR else '0' end) car_year,  ---车的使用年限                                                   --使用年限
       (case when CAR_JORUNEY>13 then 13 else CAR_JORUNEY end) CAR_JORUNEY , ---车程（万里数）                                                 --里程数
       USEDASSESS_FEE,                                               --评估费
       STAMP_TAXAMT,                                                 --印花税
       SERVICE_FEE,                                                  --服务费
       MFEE_SUM,                                                     --管理费
       VEHICLE_PRICE,                                                --汽车价格
       ALLOCATION_SUM,                                               --配置费用
       INSURANCE_SUM,                                                --保险费
       REVENUE_TAX,                                                  --所得税
       CAR_TOTAL,                                                    --车总价
       PAYMENT_RATE,                                                 --首付比例
       PAYMENT_SUM,                                                  --首付金额
       FINALPAYMENT_RATE,                                            --尾款比例
       FINALPAYMENT_SUM,                                             --尾款金额
       DEPOSIT_RATE,                                                 --保证金比例
       DEPOSIT_SUM,                                                  --保证金金额
       PERIODS,                                                      --期数
       PUTOUT_APPLYAMOUNT,                                           --放款申请次数
       CREDIT_RATE,                                                  --贷款利率
       REPAYMENT_WAY,                                                --还款方式
       REPLACE_BANK,                                                 --还款开户银行
       --decode(co_applicant,null,0,1) is_coapplicant,               --是否有共申人
       --decode(ASSURER,null,0,1) is_ASSURER,                        --是否有保证人  
       --PARTICIPANT_NAME,
       --PARTICIPANT_PHONE,
       --PARTICIPANT_STATUS,
       --PARTICIPANT_ADD,
       --PARTICIPANTSTATUS,
       
       COAPPLICANT_CNT,                                              -- 共申人数量
       WITNESS_CNT,                                                  -- 见证人数量
       ASSURER_CNT,                                                  -- 保证人数量
       PARTICIPANT_CNT,                                              -- 其他联系人数量
       PARTICIPANT1_CNT,                                             -- 父亲
       PARTICIPANT2_CNT,                                             -- 母亲
       PARTICIPANT3_CNT,                                             -- 配偶
       PARTICIPANT4_CNT,                                             -- 子女
       PARTICIPANT5_CNT,                                             -- 兄弟姐妹
       PARTICIPANT6_CNT,                                             -- 亲属，孙子
       PARTICIPANT7_CNT,                                             -- 外系亲属
       PARTICIPANT8_CNT,                                             -- 同事,师徒
       PARTICIPANT9_CNT                                              -- 朋友,同学
  from cu.zs_car_total2 t                                                
 where t.agr_fivepd30 = 1
       and t.product_type not like '%员工%'
       and t.product_type not like '%快抵%'
       and t.product_type not like '%车抵%'
       and t.product_type not like '%气球融%'
 );



/*
select count(1) from cu.zs_car_total1;
select count(1) from cu.zs_car_total2;
select count(1) from sco.zs_car_base;


select * from cu.zs_car_total1;
select * from cu.zs_car_total2;
select * from sco.zs_car_base;
*/

-----------------------------------------------------------------------
----------------------------二. 抽样（训练集vs测试集 7:3）-------------------------------
-----------------------------------------------------------------------

select * from cu.ZS_CAR_ADD_BASETRAIN--训练集（增加贷款金额）
select * from sco.zs_car_train--最终训练集
select * from cu.zs_car_add_basetest--测试集（增加贷款金额）
select * from sco.zs_car_test--最终测试集

---- 2.1.1 训练集（增加贷款金额）
-- SAS 抽样后导入数据库

---- 2.1.2 最终训练集
create table sco.zs_car_train
as
(
select  CONTRACT_NO
,TARGET
,INPUTDATE
,CUSTOMER_GENDER
,CUSTOMER_TYPE
,CERT_TYPE
,CERTF_AWD_YEAR
,CERTF_EXP_YEAR
,CUSTOMER_AGE
,MARRIAGE_STAUTS
,NATIVE_PLACE
,EDU_EXPERIENCE
,EDU_DEGREE
,WORK_CUR_YEARS
,WORK_TOT_YEARS
,OCCUPATION
,HEADSHIP
,POSITION
,EMPLOYEE_TYPE
,HOUSE_HAVE
,HOUSE_YEARS
,CHILDREN_TOTAL
,ONESELF_INCOME
,SPOUSE_INCOME
,OTHER_REVENUE
,AGE_INCOME
,MONTH_TOTAL
,MONTH_EXPEND
,RENT_EXPEND
,CREDIT_MONTH
,businesssum
,NET_MARGIN
,SERVICEPROVIDERS_TYPE
,SERVICEPROVIDER_SNAME
,RISK_IDENTIFICATION
,CITY
,PROVINCE
,BELONG_AREA
,BILL_RIGHT
,SERVICEPROVIDERS_BANK
,PRODUCT_TYPE
,MONTHCALCULATION_METHOD
,CAR_CARUSE
,CAR_HAVE
,CAR_SPECIFICATIONS
,CARSTATUS1
,(case when t.car_brand  like '%沃尔沃%' then '沃尔沃'
when t.car_brand like '%菲亚特%' then '菲亚特'           
when t.car_brand like '%莲花%' then '莲花'                
when t.car_brand like '%三菱%' then '三菱'          
when t.car_brand like '%三菱%' then '三菱'         
when t.car_brand like '%凯迪拉克%' then '凯迪拉克'                
when t.car_brand like '%丰田%' then '丰田'
when t.car_brand like '%别克%' then '别克'
when t.car_brand like '%铃木%' then '铃木'
when t.car_brand like '%日产%' then '日产'         
when t.car_brand like '%标致%' then '标致'            
when t.car_brand like '%雪铁龙%' then '雪铁龙'
when t.car_brand like '%马自达%' then '马自达'                 
when t.car_brand like '%奔驰%' then '奔驰' 
when t.car_brand like '%华泰%' then '华泰'            
when t.car_brand like '%宝马%' then '宝马'        
when t.car_brand like '%英菲尼迪' then '英菲尼迪'  
when t.car_brand like '%Jeep' then 'Jeep' 
when t.car_brand like '%雪佛兰' then '雪佛兰'            
when (t.car_brand like '%奔驰' or t.car_brand like '%梅赛德斯%') then '奔驰'                                   
when t.car_brand like '%丰田' then '丰田'                       
when t.car_brand like '%海马%' then '海马' 
when t.car_brand like '%三菱%' then '三菱'    
when t.car_brand like '%奥迪%' then '奥迪'
when t.car_brand like '%现代%' then '现代'       
when t.car_brand like '%菲亚特%' then '菲亚特' 
when t.car_brand like '%长城哈弗%' then '长城哈弗' 
when t.car_brand like '%上汽荣威' then '上汽荣威'
when t.car_brand like '%双龙%' then '双龙' 
when t.car_brand like '%北京汽车%' then '北京汽车' 
when t.car_brand like '%金龙%' then '金龙' 
when t.car_brand like '%观致%' then '观致' 
when t.car_brand like '%铃木%' then '铃木' 
when t.car_brand like '%起亚%' then '起亚' 
when t.car_brand like '%保时捷%' then '保时捷' 
when t.car_brand like '%福田汽车%' then '福田汽车' 
when t.car_brand like '%大运汽车%' then '大运汽车' 
when t.car_brand like '%克莱斯勒%' then '克莱斯勒' 
when t.car_brand like '%比亚迪%' then '比亚迪' 
when t.car_brand like '%江铃%' then '江铃' 
when t.car_brand like '%英菲尼迪%' then '英菲尼迪'
when t.car_brand like '%吉奥%' then '吉奥'
when t.car_brand like '%通用五菱%' then '通用五菱'
when t.car_brand like '%海马%' then '海马'
when t.car_brand like '%金杯%' then '金杯'
when t.car_brand like '%中国重汽%' then '中国重汽'
when t.car_brand like '%力帆%' then '力帆'
when t.car_brand in( '迷你' ,'MINI') then 'MINI'
when t.car_brand in ('上汽','上汽商用车','上汽集团') then '上汽汽车'
else t.car_brand end) CARBRAND
,GPS_FLAG
,GPS_SUM
,CAR_GUIDEPRICE
,ASSESS_PRICE
,CAR_YEAR
,CAR_JORUNEY
,USEDASSESS_FEE
,STAMP_TAXAMT
,SERVICE_FEE
,MFEE_SUM
,VEHICLE_PRICE
,ALLOCATION_SUM
,INSURANCE_SUM
,REVENUE_TAX
,CAR_TOTAL
,PAYMENT_RATE
,PAYMENT_SUM
,FINALPAYMENT_RATE
,FINALPAYMENT_SUM
,DEPOSIT_RATE
,DEPOSIT_SUM
,PERIODS
,PUTOUT_APPLYAMOUNT
,CREDIT_RATE
,REPAYMENT_WAY
,REPLACE_BANK
,COAPPLICANT_CNT
,WITNESS_CNT
,ASSURER_CNT
,PARTICIPANT_CNT
,PARTICIPANT1_CNT
,PARTICIPANT2_CNT
,PARTICIPANT3_CNT
,PARTICIPANT4_CNT
,PARTICIPANT5_CNT
,PARTICIPANT6_CNT
,PARTICIPANT7_CNT
,PARTICIPANT8_CNT
,PARTICIPANT9_CNT
 from cu.zs_car_add_basetrain t
 );

---- 2.2.1 测试集（增加贷款金额）
-- SAS 抽样后导入数据库

---- 2.2.2 最终测试集
create table sco.zs_car_test
as (select * from cu.zs_car_add_basetest);


select count(1) from cu.ZS_CAR_ADD_BASETRAIN;
select count(1) from sco.zs_car_train;
select count(1) from cu.zs_car_add_basetest;
select count(1) from sco.zs_car_test;
