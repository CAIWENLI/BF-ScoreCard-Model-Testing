---------�������--------------------
 SELECT 
tt.*
,(case when product_type in ('������','�����','��һ����','һ֤ͨ�����ֳ���','���ֱ�����','���ֿ����','�������ɹ�','������e��')  then '���ֳ�'
when product_type in ('������LCV','�۱���','�����','�����2.0','������','�Ῠ��','������','�³�������') then '�³�'
else '����' end)carstatus
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
        bc.serialno,        ----������ˣ�����/��ҵ/�Թͣ���Ϣ
        nvl(ii.customerid,ei.customerid) customerid,
        nvl(nvl(decode(ii.sex,'1','��','2','Ů'),decode(ei.sex,'1',' ��','2','Ů')),
            case when ii.certtype='Ind01' and mod(substr(ii.certid,17,1),2)=0 then 'Ů'
                 when ii.certtype='Ind01' and mod(substr(ii.certid,17,1),2)=1 then '��'
                 when ei.certtype='Ind01' and mod(substr(ei.certid,17,1),2)=0 then 'Ů'
                 when ei.certtype='Ind01' and mod(substr(ei.certid,17,1),2)=1 then '��'
                 else null end) customer_gender,
        (select itemname from s3.code_library where codeno='CustomerType' and isinuse='1' and itemno =bc.CustomerType)Customer_Type, 
        nvl(ii.customername,case when ei.customertype='04' then ei.customername else ei.legalperson end)customer_name,
        nvl(nvl(ii.birthday,ei.birthday),
            case when ii.certtype='Ind01' then substr(ii.certid,7,4)||'/'||substr(ii.certid,11,2)||'/'||substr(ii.certid,13,2)
                 when ei.certtype='Ind01' and length(ei.certid)=18 then substr(ei.certid,7,4)||'/'||substr(ei.certid,11,2)||'/'||substr(ei.certid,13,2)
                 else null end) birth_day,
        nvl((select ItemName from s3.code_library where codeno='CertType' and ItemDescribe='Car' and ItemNo=ii.certtype),
             case when ei.certtype='Ind01' then '���֤' when ei.certtype='Ent02' then '��֯��������֤' else null end)Cert_Type,
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
     (select itemname from s3.code_library where codeno='DistributorType' and itemno=sp.serviceproviderstype)SERVICEPROVIDERS_TYPE,    ----��������Ϣ
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
         
                     
      a.putoutdate putout_date,                                                                                           ----�ſ���Ϣ
      bc.lastputoutapplytime lastputout_applytime,
      bc.putoutentrytime putout_entrytime,
      bc.putoutapprovetime putout_approvetime,
      bc.putoutexecutetime putout_executetime,
      a.maturitydate maturity_date,
      bc.businesssum apply_businesssum,
      a.businesssum putout_businesssum,
              
                                                                               ----���������Ϣ
      a.lastduedate last_duedate,
      a.nextduedate next_duedate,
      a.overduedays over_duedays,
      a.historymaxcpddays history_maxcpd,
      a.normalbalance normal_balance,
      a.overduebalance overdue_balance,
      a.odintebalance odinte_balance,
      a.fineintebalance fineinte_balance,
      a.compdintebalance compdinte_balance,
      a.ACCRUEINTEBALANCE ACCRUEINTE_BALANCE,                ---���������ڵ������
      
      (select itemname from s3.code_library where codeno = 'BankCode' and itemno = ai.bankname) serviceproviders_Bank,                ----������������Ϣ
      (select itemname from s3.code_library where codeno = 'Accouncitype1' and itemno = ai.accounttype) serviceprovidersaccount_Type,
      ai.accountNo serviceproviders_accountt,
      (select BankName from s3.Bank_Info where BankNo = ai.openbranch)serviceproviders_branch,
    
    
      wi.certno witness_certno,                         ----��֤����Ϣ
      wi.contactsname witness_name,
      wi.contactsphone witness_phone,
      wi.contacts_cnt witness_cnt,
    
        bc.productname product_name,                    ----��Ʒ��Ϣ
        (case when bc.productname like '%��Ǫ�����%' then '�����' when bc.productname like '%��Ǫ������%' then '������'
      when bc.productname like '%������%' then '������' when bc.productname like '%���ֳ������%' then '���ֿ����'
      when bc.productname like '%���ֳ����ɹ�%' then '�������ɹ�'
      when bc.productname like '%��Ǫ���ֳ���e��%' then '������e��' 
      when bc.productname like '%������%' then '������' 
      when bc.productname like '%�۱���%' then '�۱���'
      when bc.productname like '%Ա��%' then 'Ա����'
      When bc.productname like '%�����%' then '�����' 
      when bc.productname like '%�Ῠ��%' then '�Ῠ��'
      when bc.productname like '%�����2.0%' then '�����2.0' 
      when bc.productname like '%һ֤ͨ�����ֳ���%' then 'һ֤ͨ�����ֳ���'
      when bc.productname like '%һ֤ͨ���³���%' then '�����2.0'
      when bc.productname like '%��Ǫe%'  then '����֮��'
      when bc.productname like '%������%'  then '��һ����'
      when bc.productname like '�����ڣ��³�%' then '�³�������'
      when bc.productname like '�����ڣ�����%' then '���ֱ�����'
      when bc.productname like '�����ڣ�LCV%' then '������LCV'
      else '����' end) PRODUCT_TYPE,
        bt.typename business_type,
        to_number(bt.isinuse)product_isinuse,
        bt.monthcalculationmethod monthcalculation_method,
    (select itemname from s3.code_library where codeno = ' ' and itemno = bc.uncreditflag) uncredit_flag,    
    (select itemname from s3.code_library where codeno = 'CarCaruse' and itemno=bc.carcaruse)car_caruse,                           ----������Ϣ
    (select itemname from s3.code_library where codeno = 'HaveNot' and itemno=bc.falg7) car_have,   
    decode (bc.carspecifications ,'01' , '���泵','02' , '�й泵') car_specifications, 
    decode(bc.carstatus,'01','�³�','02','���ֳ�','03','�Գ��Լ�')car_status,  
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
  
                                           
    bc.usedassessfee usedassess_fee,                       ----������Ϣ
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
   
    
    bc.periods,                                           ----������Ϣ  
    bc.applyreturnamount apply_returnamount,
    bc.putoutapplyamount putout_applyamount,
    to_number(bc.creditrate)credit_rate,               
    bc.applydate apply_date,
  bc.returnbackopinion returnback_opinion,
    (select itemname from s3.code_library where codeno='RepaymentWay' and itemno=bc.repaymentway) repayment_way,
   
    (select serviceprovidersname from s3.Service_Providers where CustomerType1='05' and SerialNo= openbank)replace_bank,      ----������Ϣ
    bc.replaceaccount replace_account, 
    bc.replacename replace_name, 
    
    co.customername co_applicant,                        ----��ͬ������
    co.certid coapplicant_id,
    co.customerid  coapplicant_customerid,
    co.mobiletelephone coapplicant_phone,
    co.customer_cnt coapplicant_cnt,
    
    su.customername assurer,                             ----��֤��
    su.certid assurer_id,
    su.customerid assurer_customerid,
    su.customer_cnt assurer_cnt,
    (select i.mobiletelephone from s3.ind_info i where i.customerid=su.customerid) assurer_phone,
                                    
    cp.participantname participant_name,                   ---������
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
    ,sum(case when cp.participantstatus = '����' then 1 else 0 end)participant1_cnt
    ,sum(case when cp.participantstatus = 'ĸ��' then 1 else 0 end)participant2_cnt
    ,sum(case when cp.participantstatus = '��ż' then 1 else 0 end)participant3_cnt
    ,sum(case when cp.participantstatus = '��Ů' then 1 else 0 end)participant4_cnt
    ,sum(case when cp.participantstatus = '�ֵܽ���' then 1 else 0 end)participant5_cnt
    ,sum(case when cp.participantstatus in ('����','����') then 1 else 0 end)participant6_cnt
    ,sum(case when cp.participantstatus = '��ϵ����' then 1 else 0 end)participant7_cnt
    ,sum(case when cp.participantstatus in ('ͬ��','ʦͽ') then 1 else 0 end)participant8_cnt
    ,sum(case when cp.participantstatus in ('����','ͬѧ') then 1 else 0 end)participant9_cnt
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
