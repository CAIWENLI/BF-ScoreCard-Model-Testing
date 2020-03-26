----grant select on sco.zs_car_base  to zhangshuang,jiangnan,cu;

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


 
