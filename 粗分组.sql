；
---------------------------- Section 2.1 变量粗分组
/*
-------- 分析结果储存在jn_cash_loan_var_analysis里，文本变量和数值变量的粗分组流程不相同。
create table cu.jn_cash_loan_var_analysis1
(
  id                  INTEGER,
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
'C_OPERATE_MODE'
'C_PERIODS'
'C_POS_TYPE'
'C_PROD_CODE'
'C_PROVINCE'
'C_PURPOSE'
'C_QUALITYGRADE'
'C_SA_APP_AGE'
'C_SA_RGROUP'
'C_SA_SEX'
'C_SUBMIT_HR'
'C_SUBMIT_HR2'
'C_SURETYPE'
'DD1'
'DD2'
'DD3'
'DEFAULT_AMT'
'DEF_10_NUM'
'DEF_20_NUM'
'DEF_30_NUM'
'DEPARTMENT'
'DORMITROYRESULT'
'EDUCATION'
'EMAIL'
'FAMILYLINERESULT10000'
'FAMILYMEMBERRESULT'
'FAMILY_STATE'
'FINALRISKGROUP'
'FLINKRESULT'
'FLOW_NAME'
'P_INTER_CODE'
'P_IS_DD'
'P_PAYMENT_NUM'
'P_PRODUCTCATEGORYNAME'
'P_PROD_CODE'
'P_SA_APP_AGE'
'P_SA_RGROUP'
'P_SA_SEX'
'QQ_LENGTH'
'RELATIVEADD_SAME_REG'
'RELATIVE_TEL_TYPE'
'RELATIVE_TYPE'
'SEQID'
'SEX'
'SIGNS'
'SPOUSEPHONERESULT'
'TOTAL_WK_EXP'
'UNPAY_SEQID'


'C_SA_AVG_CREAMOUNT'
,'C_SA_SUMMIT_DUETIME'
,'C_SA_WORK_MONTH'
,'EXPENSE_MONTH'
,'FAMILYMEMBERRESULT'
,'P_INIT_PAY'
,'P_PRICE'
,'TOTAL_AUDIT_TIME'
,'UW_AUDIT_TIME'
,'VALUE_INSTALMENT1'
,'VALUE_INSTALMENT2'
,'VALUE_INSTALMENT3'


-- 文本变量粗分组 （批量处理文本变量）  
declare
     str_l_sql varchar2(10000);
begin
    for c in (select t.column_name from all_tab_columns t
              where table_name = 'JN_CASH_SCO_BASE_V2_MODEL'
                    ------ is_num = 1
                    and upper(column_name) in ('C_OPERATE_MODE'
,'C_PERIODS'
,'C_POS_TYPE'
,'C_PROD_CODE'
,'C_PROVINCE'
,'C_PURPOSE'
,'C_QUALITYGRADE'
,'C_SA_APP_AGE'
,'C_SA_RGROUP'
,'C_SA_SEX'
,'C_SUBMIT_HR'
,'C_SUBMIT_HR2'
,'C_SURETYPE'
,'DD1'
,'DD2'
,'DD3'
,'DEFAULT_AMT'
,'DEF_10_NUM'
,'DEF_20_NUM'
,'DEF_30_NUM'
,'DEPARTMENT'
,'DORMITROYRESULT'
,'EDUCATION'
,'EMAIL'
,'FAMILYLINERESULT10000'
,'FAMILYMEMBERRESULT'
,'FAMILY_STATE'
,'FINALRISKGROUP'
,'FLINKRESULT'
,'FLOW_NAME'
,'P_INTER_CODE'
,'P_IS_DD'
,'P_PAYMENT_NUM'
,'P_PRODUCTCATEGORYNAME'
,'P_PROD_CODE'
,'P_SA_APP_AGE'
,'P_SA_RGROUP'
,'P_SA_SEX'
,'QQ_LENGTH'
,'RELATIVEADD_SAME_REG'
,'RELATIVE_TEL_TYPE'
,'RELATIVE_TYPE'
,'SEQID'
,'SEX'
,'SIGNS'
,'SPOUSEPHONERESULT'
,'TOTAL_WK_EXP'
,'UNPAY_SEQID')
                    --and rownum<2
                           )  
    loop
        
        str_l_sql :=
                      'insert into cu.jn_cash_loan_var_analysis1(id,state_name,var_name,group_type,group_name,N,N1,IS_NUM,IS_MONOTONE,state_Interva_sdate,state_Interva_edate,create_time)
                      select seq_instalment.nextval id,
                             '||'''交叉现金贷宽表分析20151114'''||' state_name,
                             upper('''||c.column_name||''') var_name,
                             decode(group_name,null,'''||c.column_name||'''||'||''' Analysis'''||',null) group_type,
                             group_name,
                             decode(group_name,null,null,N) N,
                             decode(group_name,null,null,N1) N1,
                             0 is_num,
                             0 is_monotone,
                             to_date('||'''20150101'''||','||'''yyyymmdd'''||') state_Interva_sdate,
                             to_date('||'''20151114'''||','||'''yyyymmdd'''||') state_Interva_edate,
                             sysdate create_time
                      from
                      (
                      select nvl(flag,'||'''other'''||') group_name,
                             count(*) N,
                             sum(def_ftpd30) N1,
                             ROUND(100*sum(def_ftpd30)/count(*),2) BADRATE
                      from (select tt.*,
                                  (case when sum(1) over (partition by '||c.column_name||') <= 50 then '||'''other'''||'
                                    else to_char('||c.column_name||') end ) flag
                            from cu.jn_cash_sco_base_v2_model tt)
                      where agr_tpd30 = 1
                      group by cube(nvl(flag,'||'''other'''||'))
                      --order by (case when group_name is null then -1 else ROUND(100*sum(def_ftpd30)/count(*),2) end)
                      order by nvl(group_name,-99999)
                      )
    ';
     execute immediate str_l_sql;
     --dbms_output.put_line(str_l_sql);

    end loop;
    COMMIT;
    
exception
    when others then 
      rollback;
      dbms_output.put_line(str_l_sql);
end;

-- 数值变量粗分组 （批量处理数值变量）  

--truncate table jn_cash_loan_var_analysis1;
declare
       num_l_isgroup number;
       str_l_sql     varchar(10000);
       str_l_sql1    varchar(10000);
       num_l_min     number;
       num_l_max     number;
       num_l_median  number;
       num_l_div     number;
       group_l_min   number;
       group_l_max   number;
       num_l_digits  number;
begin
    for c in (select t.column_name from all_tab_columns t
              where table_name = 'JN_CASH_SCO_BASE_V2_MODEL'
                    ------ is_num = 1
                    and upper(column_name) in ('C_SA_AVG_CREAMOUNT'
                                              ,'C_SA_SUMMIT_DUETIME'
                                              ,'C_SA_WORK_MONTH'
                                              ,'EXPENSE_MONTH'
                                              ,'FAMILY_INCOME'
                                              ,'P_INIT_PAY'
                                              ,'P_PRICE'
                                              ,'TOTAL_AUDIT_TIME'
                                              ,'UW_AUDIT_TIME'
                                              ,'VALUE_INSTALMENT1'
                                              ,'VALUE_INSTALMENT2'
                                              ,'VALUE_INSTALMENT3')
                    --and rownum<2
                           )  
    loop
          -------------- num_l_div         
          str_l_sql:='select count(distinct('||c.column_name||')) from cu.jn_CASH_SCO_BASE_V2';
          execute immediate str_l_sql into num_l_div;

          num_l_div := 20;
          
          ------------- num_l_min
          str_l_sql := 'select trunc(0.05*count(*)) from cu.jn_cash_sco_base_v2';
          execute immediate str_l_sql into num_l_min;
          ------------- num_l_max
          str_l_sql := 'select trunc(0.95*count(*)) from cu.jn_cash_sco_base_v2';
          execute immediate str_l_sql into num_l_max;
          ------------- num_l_median
          str_l_sql := 'select median('||c.column_name||') from cu.jn_cash_sco_base_v2_model';
          execute immediate str_l_sql into num_l_median;
                    
          ------------- group_l_min          
          str_l_sql := 
         'select case when abs(min('||c.column_name||' ))<1 then round(min('||c.column_name||'),2)
                      when abs(min('||c.column_name||' ))<10 then round(min('||c.column_name||'),1)
                      when abs(min('||c.column_name||' ))<100 then round(min('||c.column_name||'),0)
                      when abs(min('||c.column_name||' ))<1000 then round(min('||c.column_name||'),-1)
                      else round(min('||c.column_name||' ),-2) end group_l_min 
          from (
                  select t.*,
                         sum(t.n) over(order by '||c.column_name||' ) acc_sum,
                         du.num_l_min 
                  from 
                    (select '||c.column_name||', 
                           count(*) n       
                     from cu.jn_cash_sco_base_v2
                     where 1=1
                     group by '||c.column_name||' 
                     order by '||c.column_name||') t,
                    (select '||num_l_min||' num_l_min from dual) du
          )
          where acc_sum > num_l_min';
          execute immediate str_l_sql into group_l_min;
          ------------- group_l_max       
          str_l_sql :=         
         'select case when abs(max('||c.column_name||' ))<1 then round(max('||c.column_name||'),2)
                      when abs(max('||c.column_name||' ))<10 then round(max('||c.column_name||'),1)
                      when abs(max('||c.column_name||' ))<100 then round(max('||c.column_name||'),0)
                      when abs(max('||c.column_name||' ))<1000 then round(max('||c.column_name||'),-1)
                      else round(max('||c.column_name||' ),-2) end group_l_max 
                                
          from (
                  select t.*,
                         sum(t.n) over(order by '||c.column_name||') acc_sum,
                         du.num_l_max 
                  from 
                    (select '||c.column_name||' , 
                           count(*) n       
                     from cu.jn_cash_sco_base_v2
                     where 1=1
                     group by '||c.column_name||'
                     order by '||c.column_name||') t,
                    (select '||num_l_max||' num_l_max from dual) du
          )
          where acc_sum < num_l_max';
          execute immediate str_l_sql into group_l_max;
          
          
          ------------- num_l_digits
          str_l_sql := 'select case when '||num_l_median||' < 2 then 2
                      when '||num_l_median||' < 20 then 1
                      when '||num_l_median||' < 200 then 0
                      when '||num_l_median||' < 2000 then -1
                      else -2 end num_l_digits
           from dual';
          
          execute immediate str_l_sql into num_l_digits;
             
          ------------- 主程序       
          str_l_sql :=
                      'insert into cu.jn_cash_loan_var_analysis1(id,state_name,var_name,group_type,group_name,N,N1,IS_NUM,IS_MONOTONE,state_Interva_sdate,state_Interva_edate,create_time)
                      select seq_instalment.nextval id,
                             '||'''交叉现金贷宽表分析20151114'''||' state_name,
                             upper('''||c.column_name||''') var_name,
                             decode(group_name,null,'''||c.column_name||'''||'||''' Analysis'''||',null) group_type,
                             group_name,
                             decode(group_name,null,null,N) N,
                             decode(group_name,null,null,N1) N1,
                             1 is_num,
                             0 is_monotone,
                             to_date('||'''20150101'''||','||'''yyyymmdd'''||') state_Interva_sdate,
                             to_date('||'''20151114'''||','||'''yyyymmdd'''||') state_Interva_edate,
                             sysdate create_time
                      from
                      (select case when flag<='||group_l_min||' then '''||'(-∞,'||group_l_min||']'||'''
                                                when flag>'||group_l_min||'+21*num_l_div
                                                  then '''||'('||'''||('||group_l_min||'+21*num_l_div)||'''||',+∞]'||'''
                                                when flag is null then '''||'other'||'''
                                                  else '''||'('||'''||((ceil((flag-'||group_l_min||')/num_l_div)-1)*num_l_div+'||group_l_min||')||'''||','||'''||((ceil((flag-'||group_l_min||')/num_l_div))*num_l_div+'||group_l_min||')||'''||']'||'''
                                                    end group_name,
                                           count(*) N,
                                           sum(def_ftpd30) N1,
                                           ROUND(100*sum(def_ftpd30)/count(*),2) BADRATE
                              from (select tt.*,
                                           '||c.column_name||' flag,
                                           round(('||group_l_max||' - '||group_l_min||')/'||num_l_div||','||num_l_digits||') num_l_div
                                           --('||c.column_name||' - ('||group_l_min||')) / (('||group_l_max||') - ('||group_l_min||'))  flag
                                    from cu.jn_cash_sco_base_v2 tt)
                              where agr_tpd30 = 1
                              group by cube(case when flag<='||group_l_min||' then '''||'(-∞,'||group_l_min||']'||'''
                                                when flag>'||group_l_min||'+21*num_l_div
                                                  then '''||'('||'''||('||group_l_min||'+21*num_l_div)||'''||',+∞]'||'''
                                                when flag is null then '''||'other'||'''
                                                  else '''||'('||'''||((ceil((flag-'||group_l_min||')/num_l_div)-1)*num_l_div+'||group_l_min||')||'''||','||'''||((ceil((flag-'||group_l_min||')/num_l_div))*num_l_div+'||group_l_min||')||'''||']'||'''
                                                    end)
                              --order by (case when group_name is null then -1 else ROUND(100*sum(def_ftpd30)/count(*),2) end)
                              order by nvl(group_name,-99999)
                              )t1
                      
                      ';  
        --dbms_output.put_line(str_l_sql);
        execute immediate str_l_sql;
    end loop;
    COMMIT;
    
exception
    when others then 
      rollback;
      dbms_output.put_line(str_l_sql);
end;

---特殊处理
insert into cu.jn_cash_loan_var_analysis1(id,state_name,var_name,group_type,group_name,N,N1,IS_NUM,IS_MONOTONE,state_Interva_sdate,state_Interva_edate,create_time)
                      select seq_instalment.nextval id,
                             '交叉现金贷宽表分析20151114' state_name,
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
                             sum(def_ftpd30) N1,
                             ROUND(100*sum(def_ftpd30)/count(*),2) BADRATE
                      from (select tt.*,
                                  (case when sum(1) over (partition by length(wechat)) <= 50 then 'other'
                                    else to_char(length(wechat)) end ) flag
                            from cu.jn_cash_sco_base_v2_model tt)
                      where agr_tpd30 = 1
                      group by cube(nvl(flag,'other'))
                      --order by (case when group_name is null then -1 else ROUND(100*sum(def_ftpd30)/count(*),2) end)
                      order by nvl(group_name,-99999)
                      );
commit;

select * from cu.jn_cash_loan_var_analysis
