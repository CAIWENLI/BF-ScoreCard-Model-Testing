��
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------  �������ֿ�����˫�棩   ---------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
/**********************************************************************************
    * ���ܣ������������ֿ���ģ�����̣������������֣�
    * �����ˣ���˫
    * ����ʱ�䣺2016/09/07
    * ����ʱ�䣺2016/09/07
    * �汾��V1.0
**********************************************************************************/
sco.jn_car_column--�ֵ��
sco.zs_car_bining_pre_add_v1--�ַ����ñ��ȿ���飩
sco.zs_car_var_property_add_v1--�ֱַ�����һֵ����
sco.zs_CAR_var_pre_v2--ϸ�������ñ��ֶ����䣩

/*************************�������ֿ��ַ�V1*********************/
---------------------------- Section 1.1 �����ַ���
/*
-------- ������������� sco.zs_car_bining_pre_add_v1 ��ı���������ֵ�����Ĵַ������̲���ͬ��
create table sco.zs_car_bining_pre_add_v1
(
  state_name          VARCHAR2(120 CHAR),
  var_name            VARCHAR2(120 CHAR),
  group_type          VARCHAR2(120 CHAR),
  group_name          VARCHAR2(120 CHAR),
  n                   VARCHAR2(40),
  n1                  VARCHAR2(40),
  is_num              varchar2(10),   --�Ƿ���ֵ     0-�ı� 1-��ֵ
  is_monotone         varchar2(10),   --�Ƿ�����     0-���� 1-���� 2-����
  state_interva_sdate DATE,
  state_interva_edate DATE,
  create_time         DATE
)
;
*/


/* �����ű����Ƿ�һ�Լ�ȱʧ����ָ��
create table sco.zs_car_var_property_add_v1 
(
  column_name varchar2(50),
  is_var_del  number,  --�жϵ�һֵռ���Ƿ񳬹�85%
  is_var_del2 number,  --�ж�ȱʧֵ�Ƿ񳬹�70%
  DATA_TYPE   VARCHAR2(50)
)*/




--���ɴֱַ�������3��
1 INPUTDATE       ����ʱ��       
2 TARGET          ǰ�����Ƿ��������30��       
3 CONTRACT_NO     ��ͬ��       


--�ɴַ֣�t.var_type='INPUT'���ı���������30��
'GPS_FLAG',
'CAR_BRAND',
'CARSTATUS1',
'CAR_SPECIFICATIONS',
'CAR_HAVE',
'CAR_CARUSE',
'MONTHCALCULATION_METHOD',
'PRODUCT_TYPE',
'SERVICEPROVIDERS_BANK',
'BILL_RIGHT',
'BELONG_AREA',
'PROVINCE',
'CITY',
'RISK_IDENTIFICATION',
'SERVICEPROVIDER_SNAME',
'SERVICEPROVIDERS_TYPE',
'HOUSE_HAVE',
'EMPLOYEE_TYPE',
'POSITION',
'HEADSHIP',
'OCCUPATION',
'EDU_DEGREE',
'EDU_EXPERIENCE',
'NATIVE_PLACE',
'MARRIAGE_STAUTS',
'CERT_TYPE',
'CUSTOMER_TYPE',
'CUSTOMER_GENDER',
'REPLACE_BANK',
'REPAYMENT_WAY'



---�ɴַ֣�t.var_type='INPUT'����ֵ��������52��
'VEHICLE_PRICE',
'MFEE_SUM',
'SERVICE_FEE',
'STAMP_TAXAMT',
'USEDASSESS_FEE',
'CAR_JORUNEY',
'CAR_YEAR',
'ASSESS_PRICE',
'CAR_GUIDEPRICE',
'GPS_SUM',
'NET_MARGIN',
'CREDIT_MONTH',
'RENT_EXPEND',
'MONTH_EXPEND',
'MONTH_TOTAL',
'AGE_INCOME',
'OTHER_REVENUE',
'SPOUSE_INCOME',
'ONESELF_INCOME',
'CHILDREN_TOTAL',
'HOUSE_YEARS',
'WORK_TOT_YEARS',
'WORK_CUR_YEARS',
'CUSTOMER_AGE',
'CERTF_EXP_YEAR',
'CERTF_AWD_YEAR',
'PARTICIPANT9_CNT',
'PARTICIPANT8_CNT',
'PARTICIPANT7_CNT',
'PARTICIPANT6_CNT',
'PARTICIPANT5_CNT',
'PARTICIPANT4_CNT',
'PARTICIPANT3_CNT',
'PARTICIPANT2_CNT',
'PARTICIPANT1_CNT',
'PARTICIPANT_CNT',
'ASSURER_CNT',
'WITNESS_CNT',
'COAPPLICANT_CNT',
'CREDIT_RATE',
'PUTOUT_APPLYAMOUNT',
'PERIODS',
'DEPOSIT_SUM',
'DEPOSIT_RATE',
'FINALPAYMENT_SUM',
'FINALPAYMENT_RATE',
'PAYMENT_SUM',
'PAYMENT_RATE',
'CAR_TOTAL',
'REVENUE_TAX',
'INSURANCE_SUM',
'ALLOCATION_SUM',
--������һ��businesssum
,'businesssum'

-- �ı������ַ��鹲��30�� �����������ı�������  
declare
     str_l_sql varchar2(10000);
     is_var_del    number;
     is_var_del2    number;
begin
    for c in (select T.COLUMN_NAME from all_tab_columns t
                where t.TABLE_NAME like upper('zs_car_train')
                      and t.DATA_TYPE='VARCHAR2'
                      and t.COLUMN_NAME<>'CONTRACT_NO'
           
               )  
    loop
        ---- �жϷֲ��Ƿ�һ����ȱʧֵ����
          -------------- is_var_del ��һֵռ�ȴ���85% ɾ��        
          str_l_sql:='select sum(case when var_proportion>= 0.85 then 1 else 0 end) is_var_del
                      from(
                            select '||c.column_name||' group_Type
                                   ,count(*)/(sum(count(*)) over()) var_proportion
                            from sco.zs_car_train 
                            group by '||c.column_name||'
                            )
                      ';
          dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into is_var_del;
    
          
          -------------- is_var_del2 ȱʧֵռ�ȴ���70% ɾ��        
          str_l_sql:='select sum(case when group_Type is null and var_proportion>= 0.7 then 1 else 0 end) is_var_del2
                      from(
                            select '||c.column_name||' group_Type
                                   ,count(*)/(sum(count(*)) over()) var_proportion
                            from sco.zs_car_train 
                            group by '||c.column_name||'
                            )
                      ';
          --dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into is_var_del2;
          
         
          ------- �жϵ�һֵռ���Ƿ����85%��ȱʧֵ�Ƿ����70%
          if is_var_del=0 and is_var_del2=0 then
            
    
        str_l_sql :=
                    'insert into sco.zs_car_bining_pre_add_v1(state_name,var_name,group_type,group_name,n,n1,is_num,is_monotone,state_interva_sdate,state_interva_edate,create_time)
                      select '||'''����������20160429'''||' state_name,
                             upper('''||c.column_name||''') var_name,
                             decode(group_name,null,'''||c.column_name||'''||'||''' Analysis'''||',null) group_type,
                             group_name,
                             decode(group_name,null,null,N) N,
                             decode(group_name,null,null,N1) N1,
                             0 is_num,
                             0 is_monotone,
                             to_date('||'''20140827'''||','||'''yyyymmdd'''||') state_Interva_sdate,
                             to_date('||'''20151015'''||','||'''yyyymmdd'''||') state_Interva_edate,
                             sysdate create_time
                      from
                      (
                      select nvl(flag,'||'''other'''||') group_name,
                             count(*) N,
                             sum(target) N1,
                             ROUND(100*sum(target)/count(*),2) BADRATE
                      from (select tt.*,
                                  (case when sum(1) over (partition by '||c.column_name||') <= 50 then '||'''other'''||'
                                    else to_char('||c.column_name||') end ) flag
                            from sco.zs_car_train tt)
                      group by cube(nvl(flag,'||'''other'''||'))
                      --order by (case when group_name is null then -1 else ROUND(100*sum(target)/count(*),2) end)
                      order by nvl(group_name,-99999)
                      )
    ';
     execute immediate str_l_sql;
     --dbms_output.put_line(str_l_sql);
     
     else 
       dbms_output.put_line(c.column_name);
     
     end if;
        
       str_l_sql:='insert into sco.zs_car_var_property_add_v1
                   select '''||c.column_name||''' column_name
                          ,'||is_var_del||' is_var_del
                          ,'||is_var_del2||' is_var_del2
                          ,''VAR'' data_type
                   from dual';  
       --dbms_output.put_line(str_l_sql);
       execute immediate str_l_sql;
      
    end loop;
    COMMIT;
    
exception
    when others then 
      rollback;
      --dbms_output.put_line(str_l_sql);
end;




-- ��ֵ�����ַ��鹲��52�� ������������ֵ������  

declare
       num_l_isgroup number;
       str_l_sql     varchar(10000);
       str_l_sql1    varchar(10000);
       is_var_del    number;
       is_var_del2    number;
       num_l_min     number;
       num_l_max     number;
       num_l_median  number;
       num_l_div     number;
       group_l_min   number;
       group_l_max   number;
       num_l_digits  number;
begin
    for c in (select t.column_name_en column_name from SCO.jn_car_COLUMN t
              where T.DATA_TYPE ='NUMBER' 
                    and t.var_type='INPUT'
                    --and t.column_name_en ='BUSINESSSUM'
                    --and rownum<2
                           )  
    loop
          ---- �жϷֲ��Ƿ�һ����ȱʧֵ����
          -------------- is_var_del ��һֵռ�ȴ���85% ɾ��        
          str_l_sql:='select sum(case when var_proportion>= 0.85 then 1 else 0 end) is_var_del
                      from(
                            select '||c.column_name||' group_Type
                                   ,count(*)/(sum(count(*)) over()) var_proportion
                            from sco.zs_car_train 
                            group by '||c.column_name||'
                            )
                      ';
          --dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into is_var_del;
    
          
          -------------- is_var_del2 ȱʧֵռ�ȴ���70% ɾ��        
          str_l_sql:='select sum(case when group_Type is null and var_proportion>= 0.7 then 1 else 0 end) is_var_del2
                      from(
                            select '||c.column_name||' group_Type
                                   ,count(*)/(sum(count(*)) over()) var_proportion
                            from sco.zs_car_train
                            group by '||c.column_name||'
                            )
                      ';
          dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into is_var_del2;
          
         
          ------- �жϵ�һֵռ���Ƿ����85%��ȱʧֵ�Ƿ����70%
          if is_var_del=0 and is_var_del2=0 then
            
          -------------- num_l_div         
          str_l_sql:='select count(distinct('||c.column_name||')) from sco.zs_car_train';
          --dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into num_l_div;

          num_l_div := 20;
          
          ------------- num_l_min
          str_l_sql := 'select trunc(0.05*count(*)) from sco.zs_car_train';
          --dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into num_l_min;
          ------------- num_l_max
          str_l_sql := 'select trunc(0.95*count(*)) from sco.zs_car_train';
          --dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into num_l_max;
          ------------- num_l_median
          str_l_sql := 'select median('||c.column_name||') from sco.zs_car_train';
          --dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into num_l_median;
                    
          ------------- group_l_min          
          str_l_sql := 
         'select case when abs(min('||c.column_name||' ))<1 then round(min('||c.column_name||'),2)
                      when abs(min('||c.column_name||' ))<10 then round(min('||c.column_name||'),1)
                      when abs(min('||c.column_name||' ))<100 then round(min('||c.column_name||'),0)
                      when abs(min('||c.column_name||' ))<1000 then round(min('||c.column_name||'),-1)
                      when abs(min('||c.column_name||' ))<10000 then round(min('||c.column_name||'),-2)
                      when abs(min('||c.column_name||' ))<100000 then round(min('||c.column_name||'),-3)
                      else round(min('||c.column_name||' ),-4) end group_l_min 
          from (
                  select t.*,
                         sum(t.n) over(order by '||c.column_name||' ) acc_sum,
                         du.num_l_min 
                  from 
                    (select '||c.column_name||', 
                           count(*) n       
                     from sco.zs_car_train
                     where 1=1
                     group by '||c.column_name||' 
                     order by '||c.column_name||') t,
                    (select '||num_l_min||' num_l_min from dual) du
          )
          where acc_sum > num_l_min';
          --num_l_minָ����ǰ���ռ�ܱ�Ϊ0.05��ֵ��Ϊ1409--��μ�Ϊȡ���ڵ�ֵ
          --dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into group_l_min;
          ------------- group_l_max       
          str_l_sql :=         
         'select case when abs(max('||c.column_name||' ))<1 then round(max('||c.column_name||'),2)
                      when abs(max('||c.column_name||' ))<10 then round(max('||c.column_name||'),1)
                      when abs(max('||c.column_name||' ))<100 then round(max('||c.column_name||'),0)
                      when abs(max('||c.column_name||' ))<1000 then round(max('||c.column_name||'),-1)
                      when abs(max('||c.column_name||' ))<10000 then round(max('||c.column_name||'),-2)
                      when abs(max('||c.column_name||' ))<100000 then round(max('||c.column_name||'),-3)
                      else round(max('||c.column_name||' ),-4) end  group_l_max 
                                
          from (
                  select t.*,
                         sum(t.n) over(order by '||c.column_name||') acc_sum,
                         du.num_l_max 
                  from 
                    (select '||c.column_name||' , 
                           count(*) n       
                     from sco.zs_car_train
                     where 1=1
                     group by '||c.column_name||'
                     order by '||c.column_name||') t,
                    (select '||num_l_max||' num_l_max from dual) du
          )
          where acc_sum < num_l_max';
          --dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into group_l_max;
          
          
          ------------- num_l_digits
          str_l_sql := 'select case when '||num_l_median||' < 2 then 2
                      when '||num_l_median||' < 20 then 1
                      when '||num_l_median||' < 200 then 0
                      when '||num_l_median||' < 2000 then -1
                      when '||num_l_median||' < 20000 then -2
                      when '||num_l_median||' < 200000 then -3
                      else -4 end num_l_digits
           from dual';
          --dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into num_l_digits;
             
          ------------- ������       
          str_l_sql :=
                      'insert into sco.zs_car_bining_pre_add_v1(state_name,var_name,group_type,group_name,n,n1,is_num,is_monotone,state_interva_sdate,state_interva_edate,create_time)
                      select '||'''����������20160429'''||' state_name,
                             upper('''||c.column_name||''') var_name,
                             decode(group_name,null,'''||c.column_name||'''||'||''' Analysis'''||',null) group_type,
                             group_name,
                             decode(group_name,null,null,N) N,
                             decode(group_name,null,null,N1) N1,
                             1 is_num,
                             0 is_monotone,
                             to_date('||'''20140827'''||','||'''yyyymmdd'''||') state_Interva_sdate,
                             to_date('||'''20151015'''||','||'''yyyymmdd'''||') state_Interva_edate,
                             sysdate create_time
                      from
                      (select case when flag<='||group_l_min||' then '''||'(-��,'||group_l_min||']'||'''
                                                when flag>'||group_l_min||'+21*num_l_div
                                                  then '''||'('||'''||('||group_l_min||'+21*num_l_div)||'''||',+��]'||'''
                                                when flag is null then '''||'other'||'''
                                                  else '''||'('||'''||((ceil((flag-'||group_l_min||')/num_l_div)-1)*num_l_div+'||group_l_min||')||'''||','||'''||((ceil((flag-'||group_l_min||')/num_l_div))*num_l_div+'||group_l_min||')||'''||']'||'''
                                                    end group_name,
                                           count(*) N,
                                           sum(target) N1,
                                           ROUND(100*sum(target)/count(*),2) BADRATE
                              from (select tt.*,
                                           '||c.column_name||' flag,
                                           round(('||group_l_max||' - '||group_l_min||')/'||num_l_div||','||num_l_digits||') num_l_div
                                           --('||c.column_name||' - ('||group_l_min||')) / (('||group_l_max||') - ('||group_l_min||'))  flag
                                    from sco.zs_car_train tt)
                              group by cube(case when flag<='||group_l_min||' then '''||'(-��,'||group_l_min||']'||'''
                                                when flag>'||group_l_min||'+21*num_l_div
                                                  then '''||'('||'''||('||group_l_min||'+21*num_l_div)||'''||',+��]'||'''
                                                when flag is null then '''||'other'||'''
                                                  else '''||'('||'''||((ceil((flag-'||group_l_min||')/num_l_div)-1)*num_l_div+'||group_l_min||')||'''||','||'''||((ceil((flag-'||group_l_min||')/num_l_div))*num_l_div+'||group_l_min||')||'''||']'||'''
                                                    end)
                              --order by (case when group_name is null then -1 else ROUND(100*sum(target)/count(*),2) end)
                              order by nvl(group_name,-99999)
                              )t1
                      
                      ';  
       dbms_output.put_line(str_l_sql);
       execute immediate str_l_sql;
       
    else 
        dbms_output.put_line(c.column_name);
         end if;
        
       str_l_sql:='insert into sco.zs_car_var_property_add_v1
                   select '''||c.column_name||''' column_name
                          ,'||is_var_del||' is_var_del
                          ,'||is_var_del2||' is_var_del2
                          ,''NUMBER'' data_type
                   from dual';  
       --dbms_output.put_line(str_l_sql);
       execute immediate str_l_sql;
    end loop;
    COMMIT;
    
exception
    when others then 
      rollback;
      dbms_output.put_line(str_l_sql);
end;

---���⴦��
/*insert into sco.zs_car_bining_pre_add_v1(state_name,var_name,group_type,group_name,n,n1,is_num,is_monotone,state_interva_sdate,state_interva_edate,create_time)                      select seq_instalment.nextval id,
                             '����������20160429' state_name,
                             upper('WECHATLENGTH') var_name,
                             decode(group_name,null,'WECHATLENGTH'||' Analysis',null) group_type,
                             group_name,
                             decode(group_name,null,null,N) N,
                             decode(group_name,null,null,N1) N1,
                             0 is_num,
                             0 is_monotone,
                             to_date('20150101','yyyymmdd') state_Interva_sdate,
                             to_date('20151114','yyyymmdd') state_Interva_edate,
                             sysdate create_time
                      from
                      (
                      select nvl(flag,'other') group_name,
                             count(*) N,
                             sum(target) N1,
                             ROUND(100*sum(target)/count(*),2) BADRATE
                      from (select tt.*,
                                  (case when sum(1) over (partition by length(wechat)) <= 50 then 'other'
                                    else to_char(length(wechat)) end ) flag
                            from sco.zs_car_train_model tt)
                      where agr_tpd30 = 1
                      group by cube(nvl(flag,'other'))
                      --order by (case when group_name is null then -1 else ROUND(100*sum(target)/count(*),2) end)
                      order by nvl(group_name,-99999)
                      );
commit;
*/
/*delete from sco.zs_car_bining_pre_add_v1 where is_num=1;
select distinct var_name from sco.zs_car_bining_pre_add_v1
where is_num=1*/

--

/*************************�������ֿ�ϸ��V1*********************/
---------------------------- Section 2.1 ����ϸ����

------------��ֵ����ϸ����------------------
sco.zs_CAR_var_pre_v2
/*create table  sco.zs_CAR_var_pre_v2
(
state_name Varchar2(30)
,var_name  Varchar2(20)
,group_type Varchar2(30)
,group_name Varchar2(20)
,N  number
,N1 number
,state_Interva_sdate date
,state_Interva_edate date
,create_time date
)*/
--1��CHILDREN_TOTAL
--insert into  sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '����������20160517' state_name,
       upper('CHILDREN_TOTAL ') var_name,
       decode(group_name,null,'CHILDREN_TOTAL '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.CHILDREN_TOTAL=0 then '0' 
            when t.CHILDREN_TOTAL=1 then '1'
            else '(1,+��]$other'  end  
                  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_CAR_train t 
group by cube(case when t.CHILDREN_TOTAL=0 then '0' 
            when t.CHILDREN_TOTAL=1 then '1'
            else '(1,+��]$other' end  )
);
--commit;
delete from sco.zs_CAR_var_pre_v2 t
where var_name='GPS_SUM '
--2��GPS_SUM
--insert into  sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '����������20160517' state_name,
       upper('GPS_SUM ') var_name,
       decode(group_name,null,'GPS_SUM '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when (t.GPS_SUM<=1068 or t.GPS_SUM is null) then '(-��,1068]$null' 
            when t.GPS_SUM> 1068 then '(1068,+��]'  end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_CAR_train t 
group by cube(case when (t.GPS_SUM<=1068 or t.GPS_SUM is null) then '(-��,1068]$null' 
            when t.GPS_SUM> 1068 then '(1068,+��]'  end)
);
--commit;
--3��SERVICE_FEE
--insert into  sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '����������20160517' state_name,
       upper('SERVICE_FEE ') var_name,
       decode(group_name,null,'SERVICE_FEE '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(select case when SERVICE_FEE<=130 then '(-��,130]' 
             when SERVICE_FEE<=200 then '(130,200]'
             when SERVICE_FEE<=300 then '(200,300]'
             when SERVICE_FEE>300  then '(300,+��]'                      
                 else 'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_CAR_train t 
group by cube(case when SERVICE_FEE<=130  then '(-��,130]' 
                   when SERVICE_FEE<=200 then '(130,200]'
                   when SERVICE_FEE<=300 then '(200,300]'
                   when SERVICE_FEE>300 then '(300,+��]'                      
                   else 'other' end)
);
--commit;
/*(-��,133]
(133,218]
(218,388]
(388,+��]
*/
-----4��VEHICLE_PRICE
--insert into  sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '����������20160517' state_name,
       upper('VEHICLE_PRICE ') var_name,
       decode(group_name,null,'VEHICLE_PRICE '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(select  case when VEHICLE_PRICE<=84300  then '(-��,84300]' 
              when VEHICLE_PRICE<=240000 then '(84300,240000]'
              when VEHICLE_PRICE>240000 then '(240000,+��]'                        
              else 'other' end group_name     
         ,count(*) N 
         ,sum(t.target) N1
  from sco.zs_CAR_train t 
  group by cube(case when VEHICLE_PRICE<=84300  then '(-��,84300]' 
                     when VEHICLE_PRICE<=240000 then '(84300,240000]'
                     when VEHICLE_PRICE>240000  then '(240000,+��]'                        
                     else 'other' end)
);
--commit;

----5��PAYMENT_SUM 
--insert into  sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '����������20160517' state_name,
       upper('PAYMENT_SUM ') var_name,
       decode(group_name,null,'PAYMENT_SUM '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when PAYMENT_SUM<=19800  then '(-��,19800]' 
                   when PAYMENT_SUM<=43800 then '(19800,43800]'  
                   when PAYMENT_SUM>43800  then '(43800,+��]'                                          
                   else 'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_CAR_train t 
group by cube(case when PAYMENT_SUM<=19800  then '(-��,19800]' 
                   when PAYMENT_SUM<=43800 then '(19800,43800]'  
                   when PAYMENT_SUM>43800  then '(43800,+��]'                                          
                   else 'other' end
              )
)
--commit;

--ԭ���Լ��ֹ������
/*(61000,+��]
(41000,61000]
(-��,41000]*/

----6��BUSINESSSUM
--insert into  sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '����������20160517' state_name,
       upper('BUSINESSSUM ') var_name,
       decode(group_name,null,'BUSINESSSUM '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when BUSINESSSUM<=52500  then '(-��,52500]' 
            when BUSINESSSUM<=77100 then '(52500,77100]'  
            when BUSINESSSUM>77100 then '(77100,+��]'                                          
            else 'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when BUSINESSSUM<=52500  then '(-��,52500]' 
            when BUSINESSSUM<=77100 then '(52500,77100]'  
            when BUSINESSSUM>77100 then '(77100,+��]'                                          
            else 'other' end )
)
--commit;
--ԭ���Լ����ֹ�����
/*(-��,42000]
(42000,77000]
(77000,+��]*/

--8��CAR_GUIDEPRICE
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '����������20160517' state_name,
       upper('CAR_GUIDEPRICE ') var_name,
       decode(group_name,null,'CAR_GUIDEPRICE '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when CAR_GUIDEPRICE<=87000  then '(-��,87100]' 
            when CAR_GUIDEPRICE<=167000 then '(87100,137300]'  
            when CAR_GUIDEPRICE>167000 then '(137300,+��]'                                          
            else 'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from cu.zs_car_add_basetrain t 
group by cube(case when CAR_GUIDEPRICE<=87000  then '(-��,87100]' 
            when CAR_GUIDEPRICE<=167000 then '(87100,137300]'  
            when CAR_GUIDEPRICE>167000 then '(137300,+��]'                                          
            else 'other' end)
);
--commit;
/*(-��,87100]
(87100,137300]
(137300,+��]*/

--9��CAR_TOTAL
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '����������20160517' state_name,
       upper('CAR_TOTAL ') var_name,
       decode(group_name,null,'CAR_TOTAL '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when CAR_TOTAL<=80000  then '(-��,80000]' 
            when CAR_TOTAL<=128000 then '(80000,128000]'  
            when CAR_TOTAL>128000 then '(128000,+��]'                                          
            else 'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from cu.zs_car_add_basetrain t 
group by cube(case when CAR_TOTAL<=80000  then '(-��,80000]' 
            when CAR_TOTAL<=128000 then '(80000,128000]'  
            when CAR_TOTAL>128000 then '(128000,+��]'                                          
            else 'other' end)
);
--commit;
--10��MONTH_TOTAL
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '����������20160517' state_name,
       upper('MONTH_TOTAL ') var_name,
       decode(group_name,null,'MONTH_TOTAL '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when (MONTH_TOTAL<=6300 or MONTH_TOTAL is null)  then '(-��,6300]$other' ---��ֵ�鵽��õķ���
            when MONTH_TOTAL<=22500 then '(6300,22500]'  
            when MONTH_TOTAL>22500 then '(22500,+��]' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from cu.zs_car_add_basetrain t 
group by cube(case when (MONTH_TOTAL<=6300 or MONTH_TOTAL is null)  then '(-��,6300]$other' ---��ֵ�鵽��õķ���
            when MONTH_TOTAL<=22500 then '(6300,22500]'  
            when MONTH_TOTAL>22500 then '(22500,+��]' end)
);
--commit;


--11��MFEE_SUM
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '����������20160517' state_name,
       upper('MFEE_SUM ') var_name,
       decode(group_name,null,'MFEE_SUM '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when MFEE_SUM<=0  then '(-��,0]' 
            when MFEE_SUM<=30 then '(0,30]'  
            when MFEE_SUM>30 then '(30,+��]'                                          
            else 'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from cu.zs_car_add_basetrain t 
group by cube(case when MFEE_SUM<=0  then '(-��,0]' 
            when MFEE_SUM<=30 then '(0,30]'  
            when MFEE_SUM>30 then '(30,+��]'                                          
            else 'other' end )
);
--commit;
------------------�ı�����ϸ����-------------------
---1.belong_area-----------------------
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time) 
select '����������20160517' state_name,
       upper('belong_area') var_name,
       decode(group_name,null,'belong_area '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select (case when t.belong_area in ('����','����') then '1'
            when t.belong_area in ('����','����') then '2'
            when t.belong_area in ('����') then '3' 
            else 'other' end)  group_name     
       ,count(*) N
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when t.belong_area in ('����','����') then '1'
            when t.belong_area in ('����','����') then '2'
            when t.belong_area in ('����') then '3' 
            else 'other' end)
);
--commit;
/*
----2.car_brand(����̫ϸ�����鲻����)
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '����������20160517' state_name,
       upper('car_brand ') var_name,
       decode(group_name,null,'car_brand '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select 
case when t.car_brand in 
 ('��������','����','����ԣ¡','��������','��̩','����','�����л�','����','�ִ�'
 ,'�Ա�','����','ͨ��','·��','����','��������','����','�µ�','����','���Դ�') then '1'
 when t.car_brand in 
 ('�������ó�','һ������','ѩ����','����','�ղ�','����','���','����','��������'
,'ѩ����','Ұ������','��ľ','����','����') then '2'
 when t.car_brand in 
 ('�Ա�����','����','��̩','������ó�','����','����','�Ϻ�����˹�´�','��������'
,'��������','����С��','��������','½������','��������','��������','����','����') then '3'
when t.car_brand in 
 ('���ǵ�','�������','Jeep','��','��������','��������','Ϋ������') then '4'
 else 'other' end  group_name     
       ,count(*) N
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when t.car_brand in 
 ('��������','����','����ԣ¡','��������','��̩','����','�����л�','����','�ִ�'
 ,'�Ա�','����','ͨ��','·��','����','��������','����','�µ�','����','���Դ�') then '1'
 when t.car_brand in 
 ('�������ó�','һ������','ѩ����','����','�ղ�','����','���','����','��������'
,'ѩ����','Ұ������','��ľ','����','����') then '2'
 when t.car_brand in 
 ('�Ա�����','����','��̩','������ó�','����','����','�Ϻ�����˹�´�','��������'
,'��������','����С��','��������','½������','��������','��������','����','����') then '3'
when t.car_brand in 
 ('���ǵ�','�������','Jeep','��','��������','��������','Ϋ������') then '4'
 else 'other' end)
)
--commit;*/


-----3.EDU_EXPERIENCE
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '����������20160517' state_name,
       upper('EDU_EXPERIENCE ') var_name,
       decode(group_name,null,'EDU_EXPERIENCE '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.EDU_EXPERIENCE in ('�о���','��ѧ����'��'��ѧר��') then '1'
            when t.EDU_EXPERIENCE in ('����','��ר/�еȼ�У','����ѧУ','����') then '2'
            else '3' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when t.EDU_EXPERIENCE in ('�о���','��ѧ����'��'��ѧר��') then '1'
            when t.EDU_EXPERIENCE in ('����','��ר/�еȼ�У','����ѧУ','����') then '2'
            else '3' end)
);
--commit;


-----4.headship
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '����������20160517' state_name,
       upper('headship ') var_name,
       decode(group_name,null,'headship '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.headship in ('�߲������Ա/�ܼ�����/�ּ����ϸɲ�','�в������Ա/��������/�Ƽ����ϸɲ�') then '1'
            when t.headship in ('���������Ա/�����鳤/��Ա','˾��','����/�н�/ҵ�����/����') then '2'
            when t.headship in ('����','ũ��','����','��ҵ/����ҵ��Ա','һ��Ա��') then '3'
            else '4' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when t.headship in ('�߲������Ա/�ܼ�����/�ּ����ϸɲ�','�в������Ա/��������/�Ƽ����ϸɲ�') then '1'
            when t.headship in ('���������Ա/�����鳤/��Ա','˾��','����/�н�/ҵ�����/����') then '2'
            when t.headship in ('����','ũ��','����','��ҵ/����ҵ��Ա','һ��Ա��') then '3'
            else '4' end )
)
;
--commit;

----5.occupation 
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '����������20160517' state_name,
       upper('headship ') var_name,
       decode(group_name,null,'headship '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.headship in ('���һ��ء���Ⱥ��֯����ҵ����ҵ��λ������','��������������ҵ��Ա') then '1'
            when t.headship in ('�����������豸������Ա���й���Ա','������Ա���й���Ա','��ҵ������ҵ��Ա') then '2'
            when t.headship in ('ũ���֡������桢ˮ��ҵ������Ա','רҵ������Ա','δ֪') then '3'
             else  'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when t.headship in ('���һ��ء���Ⱥ��֯����ҵ����ҵ��λ������','��������������ҵ��Ա') then '1'
            when t.headship in ('�����������豸������Ա���й���Ա','������Ա���й���Ա','��ҵ������ҵ��Ա') then '2'
            when t.headship in ('ũ���֡������桢ˮ��ҵ������Ա','רҵ������Ա','δ֪') then '3'
             else  'other' end)
)
;
--commit;

----6.PRODUCT_TYPE
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '����������20160517' state_name,
       upper('PRODUCT_TYPE ') var_name,
       decode(group_name,null,'PRODUCT_TYPE '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.PRODUCT_TYPE in ('���ֿ����') then '1'
            when t.PRODUCT_TYPE in ('�������ɹ�','�Ῠ��','������') then '2'
            when t.PRODUCT_TYPE in ('������e��','�۱���','�����') then '3'
             else  'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when t.PRODUCT_TYPE in ('���ֿ����') then '1'
            when t.PRODUCT_TYPE in ('�������ɹ�','�Ῠ��','������') then '2'
            when t.PRODUCT_TYPE in ('������e��','�۱���','�����') then '3'
             else  'other' end)
)
;
--commit;

-----7.PROVINCE
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '����������20160517' state_name,
       upper('PROVINCE ') var_name,
       decode(group_name,null,'PROVINCE '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.PROVINCE in ('����ʡ','����ʡ','������','����ʡ') then '1'
            when t.PROVINCE in ('����ʡ','����ʡ','����ʡ','����ʡ','����ʡ','ɽ��ʡ','�ӱ�ʡ','����ʡ') then '2'
            when t.PROVINCE in ('������ʡ','����ʡ','����ʡ','���ɹ�������','ɽ��ʡ') then '3'
            when t.PROVINCE in ('����ʡ','�㶫ʡ','����ʡ','������','����ʡ','�Ĵ�ʡ','�½�','���Ļ���������','�����') then '4'
             else  'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when t.PROVINCE in ('����ʡ','����ʡ','������','����ʡ') then '1'
            when t.PROVINCE in ('����ʡ','����ʡ','����ʡ','����ʡ','����ʡ','ɽ��ʡ','�ӱ�ʡ','����ʡ') then '2'
            when t.PROVINCE in ('������ʡ','����ʡ','����ʡ','���ɹ�������','ɽ��ʡ') then '3'
            when t.PROVINCE in ('����ʡ','�㶫ʡ','����ʡ','������','����ʡ','�Ĵ�ʡ','�½�','���Ļ���������','�����') then '4'
             else  'other' end)
)
;
--commit;



-----9.CUSTOMER_GENDER
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '����������20160517' state_name,
       upper('CUSTOMER_GENDER ') var_name,
       decode(group_name,null,'CUSTOMER_GENDER '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.CUSTOMER_GENDER='Ů' then '2' 
             else  '1' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when t.CUSTOMER_GENDER='Ů' then '2' 
             else  '1' end)
)
;
--commit;
-------10.HOUSE_HAVE
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '����������20160517' state_name,
       upper('HOUSE_HAVE ') var_name,
       decode(group_name,null,'HOUSE_HAVE '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
 select case when t.HOUSE_HAVE='��' then '1' end  
         else '2'end group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when t.HOUSE_HAVE='��' then '1' end  
         else '2'end)
)
;
--commit;


------11.MARRIAGE_STAUTS
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '����������20160517' state_name,
       upper('MARRIAGE_STAUTS ') var_name,
       decode(group_name,null,'MARRIAGE_STAUTS '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.MARRIAGE_STAUTS='����' then '1' 
            when t.MARRIAGE_STAUTS='δ��' then '2' 
            else  '3' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when t.MARRIAGE_STAUTS='����' then '1' 
                   when t.MARRIAGE_STAUTS='δ��' then '2' 
                   when t.MARRIAGE_STAUTS='�ѻ�' then '3'  
                    else  'other' end )
)
;
--commit;

------12.carstatus1
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '����������20160517' state_name,
       upper('carstatus1 ') var_name,
       decode(group_name,null,'carstatus1 '||'����',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.carstatus1='���ֳ�' then '1' 
            when t.carstatus1='�³�' then '2' 
             else  'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when t.carstatus1='���ֳ�' then '1' 
            when t.carstatus1='�³�' then '2' 
             else  'other' end)
)
;
--commit;


