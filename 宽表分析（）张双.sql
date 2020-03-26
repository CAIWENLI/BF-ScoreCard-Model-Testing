/*************************车贷评分卡粗分V1*********************/
---------------------------- Section 2.1 变量粗分组
/*
-------- 分析结果储存在 sco.zs_car_bining_pre_v1 里，文本变量和数值变量的粗分组流程不相同。
create table sco.zs_car_bining_pre_v1
(
  state_name          VARCHAR2(120 CHAR),
  var_name            VARCHAR2(120 CHAR),
  group_type          VARCHAR2(120 CHAR),
  group_name          VARCHAR2(120 CHAR),
  n                   VARCHAR2(40),
  n1                  VARCHAR2(40),
  is_num              varchar2(10),   --是否数值     0-文本 1-数值
  is_monotone         varchar2(10),   --是否有序     0-无序 1-升序 2-降序
  state_interva_sdate DATE,
  state_interva_edate DATE,
  create_time         DATE
)
;
*/


/* 建表存放变量是否单一以及缺失比率指标
create table sco.zs_car_var_property_v1 
(
  column_name varchar2(50),
  is_var_del  number,  --判断单一值占比是否超过85%
  is_var_del2 number,  --判断缺失值是否超过70%
  DATA_TYPE   VARCHAR2(50)
)*/




--不可粗分变量共计3个
1 INPUTDATE       申请时间       
2       TARGET       前五期是否出现逾期30天       
3       CONTRACT_NO       合同号       


--可粗分（t.var_type='INPUT'）文本变量共计30个
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



---可粗分（t.var_type='INPUT'）数值变量共计52个
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
'ALLOCATION_SUM'


-- 文本变量粗分组共计30个 （批量处理文本变量）  
declare
     str_l_sql varchar2(10000);
     is_var_del    number;
     is_var_del2    number;
begin
    for c in (select t.column_name_en column_name from SCO.jn_car_COLUMN t
              where T.DATA_TYPE ='VARCHAR2' 
                    and t.var_type='INPUT'
                    --and rownum<2
                           )  
    loop
        ---- 判断分布是否单一或者缺失值过多
          -------------- is_var_del 单一值占比大于85% 删除        
          str_l_sql:='select sum(case when var_proportion>= 0.85 then 1 else 0 end) is_var_del
                      from(
                            select '||c.column_name||' group_Type
                                   ,count(*)/(sum(count(*)) over()) var_proportion
                            from sco.zs_car_base 
                            group by '||c.column_name||'
                            )
                      ';
          dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into is_var_del;
    
          
          -------------- is_var_del2 缺失值占比大于70% 删除        
          str_l_sql:='select sum(case when group_Type is null and var_proportion>= 0.7 then 1 else 0 end) is_var_del2
                      from(
                            select '||c.column_name||' group_Type
                                   ,count(*)/(sum(count(*)) over()) var_proportion
                            from sco.zs_car_base 
                            group by '||c.column_name||'
                            )
                      ';
          dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into is_var_del2;
          
         
          ------- 判断单一值占比是否大于85%和缺失值是否大于70%
          if is_var_del=0 and is_var_del2=0 then
            
    
        str_l_sql :=
                    'insert into sco.jn_car_bining_pre_v1(state_name,var_name,group_type,group_name,n,n1,is_num,is_monotone,state_interva_sdate,state_interva_edate,create_time)
                      select '||'''车贷宽表分析20160429'''||' state_name,
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
                            from sco.zs_car_base tt)
                      group by cube(nvl(flag,'||'''other'''||'))
                      --order by (case when group_name is null then -1 else ROUND(100*sum(target)/count(*),2) end)
                      order by nvl(group_name,-99999)
                      )
    ';
     --execute immediate str_l_sql;
     dbms_output.put_line(is_var_del);
     
     else 
       dbms_output.put_line(c.column_name);
     
     end if;
        
       str_l_sql:='insert into sco.zs_car_var_property_v1
                   select '''||c.column_name||''' column_name
                          ,'||is_var_del||' is_var_del
                          ,'||is_var_del2||' is_var_del2
                          ,''VAR'' data_type
                   from dual';  
       dbms_output.put_line(str_l_sql);
       --execute immediate str_l_sql;
      
    end loop;
    COMMIT;
    
exception
    when others then 
      rollback;
      dbms_output.put_line(str_l_sql);
end;



-- 数值变量粗分组共计52个 （批量处理数值变量）  

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
                    --and t.column_name_en ='CREDIT_MONTH'
                    --and rownum<2
                           )  
    loop
          ---- 判断分布是否单一或者缺失值过多
          -------------- is_var_del 单一值占比大于85% 删除        
          str_l_sql:='select sum(case when var_proportion>= 0.85 then 1 else 0 end) is_var_del
                      from(
                            select '||c.column_name||' group_Type
                                   ,count(*)/(sum(count(*)) over()) var_proportion
                            from sco.zs_car_base 
                            group by '||c.column_name||'
                            )
                      ';
          dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into is_var_del;
    
          
          -------------- is_var_del2 缺失值占比大于70% 删除        
          str_l_sql:='select sum(case when group_Type is null and var_proportion>= 0.7 then 1 else 0 end) is_var_del2
                      from(
                            select '||c.column_name||' group_Type
                                   ,count(*)/(sum(count(*)) over()) var_proportion
                            from sco.zs_car_base 
                            group by '||c.column_name||'
                            )
                      ';
          dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into is_var_del2;
          
         
          ------- 判断单一值占比是否大于85%和缺失值是否大于70%
          if is_var_del=0 and is_var_del2=0 then
            
          -------------- num_l_div         
          str_l_sql:='select count(distinct('||c.column_name||')) from sco.zs_car_base';
          --dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into num_l_div;

          num_l_div := 20;
          
          ------------- num_l_min
          str_l_sql := 'select trunc(0.05*count(*)) from sco.zs_car_base';
          --dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into num_l_min;
          ------------- num_l_max
          str_l_sql := 'select trunc(0.95*count(*)) from sco.zs_car_base';
          --dbms_output.put_line(str_l_sql);
          execute immediate str_l_sql into num_l_max;
          ------------- num_l_median
          str_l_sql := 'select median('||c.column_name||') from sco.zs_car_base';
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
                     from sco.zs_car_base
                     where 1=1
                     group by '||c.column_name||' 
                     order by '||c.column_name||') t,
                    (select '||num_l_min||' num_l_min from dual) du
          )
          where acc_sum > num_l_min';
          --num_l_min指的是前面的占总比为0.05的值即为1409--这段即为取出节点值
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
                     from sco.zs_car_base
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
             
          ------------- 主程序       
          str_l_sql :=
                      'insert into sco.jn_car_bining_pre_v1(state_name,var_name,group_type,group_name,n,n1,is_num,is_monotone,state_interva_sdate,state_interva_edate,create_time)
                      select '||'''车贷宽表分析20160429'''||' state_name,
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
                      (select case when flag<='||group_l_min||' then '''||'(-∞,'||group_l_min||']'||'''
                                                when flag>'||group_l_min||'+21*num_l_div
                                                  then '''||'('||'''||('||group_l_min||'+21*num_l_div)||'''||',+∞]'||'''
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
                                    from sco.zs_car_base tt)
                              group by cube(case when flag<='||group_l_min||' then '''||'(-∞,'||group_l_min||']'||'''
                                                when flag>'||group_l_min||'+21*num_l_div
                                                  then '''||'('||'''||('||group_l_min||'+21*num_l_div)||'''||',+∞]'||'''
                                                when flag is null then '''||'other'||'''
                                                  else '''||'('||'''||((ceil((flag-'||group_l_min||')/num_l_div)-1)*num_l_div+'||group_l_min||')||'''||','||'''||((ceil((flag-'||group_l_min||')/num_l_div))*num_l_div+'||group_l_min||')||'''||']'||'''
                                                    end)
                              --order by (case when group_name is null then -1 else ROUND(100*sum(target)/count(*),2) end)
                              order by nvl(group_name,-99999)
                              )t1
                      
                      ';  
       --dbms_output.put_line(str_l_sql);
       execute immediate str_l_sql;
       
    else 
        dbms_output.put_line(c.column_name);
         end if;
        
       str_l_sql:='insert into sco.jn_car_var_property_v1
                   select '''||c.column_name||''' column_name
                          ,'||is_var_del||' is_var_del
                          ,'||is_var_del2||' is_var_del2
                          ,''NUMBER'' data_type
                   from dual';  
       --dbms_output.put_line(str_l_sql);
       --execute immediate str_l_sql;
       
       
    end loop;
    COMMIT;
    
exception
    when others then 
      rollback;
      dbms_output.put_line(str_l_sql);
end;

---特殊处理
/*insert into sco.jn_car_bining_pre_v1(state_name,var_name,group_type,group_name,n,n1,is_num,is_monotone,state_interva_sdate,state_interva_edate,create_time)                      select seq_instalment.nextval id,
                             '车贷宽表分析20160429' state_name,
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
                            from sco.zs_car_base_model tt)
                      where agr_tpd30 = 1
                      group by cube(nvl(flag,'other'))
                      --order by (case when group_name is null then -1 else ROUND(100*sum(target)/count(*),2) end)
                      order by nvl(group_name,-99999)
                      );
commit;
*/
delete from sco.jn_car_bining_pre_v1 where is_num=1;
select distinct var_name from sco.jn_car_bining_pre_v1
where is_num=1
