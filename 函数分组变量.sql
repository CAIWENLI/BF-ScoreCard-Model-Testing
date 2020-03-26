

select  T1.AMOUNT_X_INITPAY 
--,sum(case when T1.city='惠州市' then 1 else 0 end ) 惠州
,count(*) 
 from 
(
    
                select          
                      T.CONTRACT_NO,
                      T.APP_DATE,
                      T.STATUS_EN,
                      T1.HEADSHIP,
                      t.sub_product_type,
                      cu.f_sco_var_level_2('AMOUNT_X_INITPAY',t.CREDIT_AMOUNT||'$'||t.INIT_PAY) AMOUNT_X_INITPAY,                                        
                      
                      cu.f_sco_var_level_2('CERT_4_INITAL',T1.CERTID) CERT_4_INITAL,
                                         
                      cu.f_sco_var_level_2('GOODS_INFO',CU.F_JN_GET_GOODS_INFO(T.PRODUCTCATEGORYNAME,T.GOODS_TYPE,T.BRANDTYPE,T.MANUFACTURER,T.PRICE)) GOODS_INFO,
                                       
                      cu.f_sco_var_level_2('INCOME_X_AGE',(case when trunc(to_date(t1.inputdate,'yyyy/mm/dd hh24:mi:ss'))>=to_date('2015/01/19','yyyy/mm/dd') 
                                                              then t1.SelfMonthIncome 
                                                              else t1.familymonthincome 
                                                              end)
                                                        ||
                                                        '$'
                                                        ||
                                                        (case when length(T1.CERTID)=18 
                                                              then TRUNC(months_between(trunc(T.app_date),to_date(substr(T1.CERTID,7,8),'yyyymmdd'))/12,0)
                                                              else null 
                                                              end)
                                        ) INCOME_X_AGE,
                                         
                      cu.f_sco_var_level_2('INNER_CODE',decode(t2.Interiorcode,'2','2','1')) INNER_CODE,
                                         
                      cu.f_sco_var_level_2('IS_DD',decode(T2.REPAYMENTWAY,'2','0','1')) IS_DD,
                                         
                      cu.f_sco_var_level_2('PROD_CODE',t.PROD_CODE) PROD_CODE,
                                         
                      cu.f_sco_var_level_2('SEX_X_FAMILYSTATE',T1.SEX||'$'||T1.MARRIAGE) SEX_X_FAMILYSTATE,
                                         
                      cu.f_sco_var_level_2('CERTF_EXP_YEAR',to_char(t.CERTF_EXP,'yyyymmdd')) CERTF_EXP_YEAR,
                                         
                      cu.f_sco_var_level_2('CITY',t3.CITY) CITY,
                                        
                      null  WORK_EMP_TYPE
                                     
                from rcas.v_Cu_Risk_Credit_Summary t,
                      s1.ind_info t1,
                      s1.business_contract_cu t2,
                      S1.STORE_INFO t3,
                      sco.jn_chlg2_train_v2 t4
                where t.ID_PERSON=t1.customerid 
                       and t.CONTRACT_NO=t2.serialno 
                       and t.POS_CODE=t3.SNO
                       and t.contract_no=t4.con
                       and t.LOAN_TYPE = '030' -- POS 贷
                       AND T.DATA_SOURCE='AMAR'--安硕系统数据
                       AND T.STATUS_EN in ('050','160','020', '090','040','080','010','110')--状态为通过或拒绝
                       /*AND t.APP_DATE>=to_date('20160101','yyyymmdd')--时间下限
                       AND t.APP_DATE<to_date('20160201','yyyymmdd')--时间上限*/
                       --AND nvl(t2.Interiorcode,0)<>'3'--剔除内部代码为3的单

       
        )t1
        group by T1.AMOUNT_X_INITPAY
        ;
        
