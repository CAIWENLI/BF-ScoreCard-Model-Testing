truncate table sco.jn_car_base;
drop table sco.jn_car_base;


create table sco.jn_car_base2 as
select CONTRACT_NO,
       DEF_FPD30+DEF_SPD30+DEF_TPD30+DEF_QPD30+DEF_FIVEPD30 target,
       to_date(inputdate,'yyyy/mm/dd') inputdate,
       CUSTOMER_GENDER,
       CUSTOMER_TYPE,
       CERT_TYPE,
       --AWARD_DATE,     
       case when AWARD_DATE is not null 
                 then round(months_between(to_date(t.inputdate,'yyyy/mm/dd'),to_date(AWARD_DATE,'yyyy/mm/dd'))/12) 
            else null end certf_awd_year,                   -- ���֤ʹ������                                     -- 
       --CERT_MATURITYDATE,                                   -- ���֤������
       case when CERT_MATURITYDATE is not null 
                 then round(months_between(to_date(CERT_MATURITYDATE,'yyyy/mm/dd'),to_date(t.inputdate,'yyyy/mm/dd'))/12) 
            else null end certf_exp_year,                   -- ���֤��Ч����
       CUSTOMER_AGE,
       MARRIAGE_STAUTS,
       NATIVE_PLACE,                                        -- ������
       EDU_EXPERIENCE,                                      -- ѧ��
       EDU_DEGREE,                                          -- ѧλ
       --FAMILY_ADD,
       --WORK_CORP,
       --WORK_ADD,
       
       --work_begindate,                                         -- ���������ʼʱ��
       case when work_begindate is not null
            then round(months_between(to_date(t.inputdate,'yyyy/mm/dd'),to_date(work_begindate,'yyyy/mm/dd'))/12) 
       else null end work_cur_years,                            -- ��������
         
       case when JOB_BEGINDATE is not null
            then round(months_between(to_date(t.inputdate,'yyyy/mm/dd'),to_date(JOB_BEGINDATE,'yyyy/mm/dd'))/12) 
       else null end work_tot_years,                            -- ��������
       OCCUPA_TION OCCUPATION,                              -- ְҵ
       HEAD_SHIP   HEADSHIP,                                -- ְλ
       POSI_TION   POSITION,                                -- ְλ2
       EMPLOYEE_TYPE,                                       -- ��Ӷ����
       HOUSE_HAVE,                                          -- �Ƿ����з�
       --FIRSTHOUSE_DATE,                                     -- �״����з�ʱ��
       case when FIRSTHOUSE_DATE is not null 
                 then round(months_between(to_date(FIRSTHOUSE_DATE,'yyyy/mm/dd'),to_date(t.inputdate,'yyyy/mm/dd'))/12) 
            else null end house_years,                   -- ���з�������
       CHILDREN_TOTAL,                                   -- ��Ů����
       ONESELF_INCOME,                                   -- ����������
       SPOUSE_INCOME,                                    -- ��ż������
       OTHER_REVENUE,                                    -- ����������
       AGE_INCOME,                                       -- ������
       MONTH_TOTAL,                                      -- ��������
       MONTH_EXPEND,                                     -- ����֧��
       RENT_EXPEND,                                      -- ���֧��
       CREDIT_MONTH,                                     -- �����¹�
       NET_MARGIN,                                       -- �¾�����
       SERVICEPROVIDERS_TYPE,                            -- ����������
       SERVICEPROVIDER_SNAME,                            -- ������
       RISK_IDENTIFICATION,                              -- ���ձ�ʶ
       CITY,                                             -- ����
       PROVINCE,                                         -- ʡ��
       BELONG_AREA,                                      -- ����
       BILL_RIGHT,                                       -- �Ƿ���п�ƱȨ
       SERVICEPROVIDERS_BANK,                            -- ����
       --WITNESS_CERTNO,
       --length(WITNESS_CERTNO)-length(replace(WITNESS_CERTNO,'&',''))+1 witness_id_cnt, -- �ṩ���֤��������
       --WITNESS_NAME,
       --length(WITNESS_NAME)-length(replace(WITNESS_NAME,'&',''))+1 witness_na_cnt,     -- �ṩ��������
       --WITNESS_PHONE,
       --length(WITNESS_PHONE)-length(replace(WITNESS_PHONE,'&',''))+1 witness_ph_cnt,   -- �ṩ�ֻ���������
       --PRODUCT_NAME,
       PRODUCT_TYPE,
       MONTHCALCULATION_METHOD,
       CAR_CARUSE,                                                   --�Ƿ�����
       CAR_HAVE,                                                     --�Ƿ��г�
       CAR_SPECIFICATIONS,                                           --����
       CAR_STATUS,                                                   --����
       CAR_BRAND,                                                    --����Ʒ��
       --CAR_TYPE,                                                     --������ʽ
       --CAR_NUMBER,                                                   --����
       --CAR_COLOUR,                                                   --������ɫ
       GPS_FLAG,                                                     --�Ƿ���GPS
       GPS_SUM,                                                      --���ܼҷ���
       CAR_GUIDEPRICE,                                               --����ָ���۸�
       ASSESS_PRICE,                                                 --���������۸�
       to_number(CAR_YEAR) car_year,                                                     --ʹ������
       CAR_JORUNEY,                                                  --�����
       USEDASSESS_FEE,                                               --������
       STAMP_TAXAMT,                                                 --ӡ��˰
       SERVICE_FEE,                                                  --�����
       MFEE_SUM,                                                     --�����
       VEHICLE_PRICE,                                                --�����۸�
       ALLOCATION_SUM,                                               --���÷���
       INSURANCE_SUM,                                                --���շ�
       REVENUE_TAX,                                                  --����˰
       CAR_TOTAL,                                                    --���ܼ�
       PAYMENT_RATE,                                                 --�׸�����
       PAYMENT_SUM,                                                  --�׸����
       FINALPAYMENT_RATE,                                            --β�����
       FINALPAYMENT_SUM,                                             --β����
       DEPOSIT_RATE,                                                 --��֤�����
       DEPOSIT_SUM,                                                  --��֤����
       PERIODS,                                                      --����
       PUTOUT_APPLYAMOUNT,                                           --�ſ��������
       CREDIT_RATE,                                                  --��������
       REPAYMENT_WAY,                                                --���ʽ
       REPLACE_BANK,                                                 --���������
       --decode(co_applicant,null,0,1) is_coapplicant,               --�Ƿ��й�����
       --decode(ASSURER,null,0,1) is_ASSURER,                        --�Ƿ��б�֤��  
       --PARTICIPANT_NAME,
       --PARTICIPANT_PHONE,
       --PARTICIPANT_STATUS,
       --PARTICIPANT_ADD,
       --PARTICIPANTSTATUS,
       
       COAPPLICANT_CNT,                                              -- ����������
       WITNESS_CNT,                                                  -- ��֤������
       ASSURER_CNT,                                                  -- ��֤������
       PARTICIPANT_CNT,                                              -- ������ϵ������
       PARTICIPANT1_CNT,                                             -- ����
       PARTICIPANT2_CNT,                                             -- ĸ��
       PARTICIPANT3_CNT,                                             -- ��ż
       PARTICIPANT4_CNT,                                             -- ��Ů
       PARTICIPANT5_CNT,                                             -- �ֵܽ���
       PARTICIPANT6_CNT,                                             -- ����������
       PARTICIPANT7_CNT,                                             -- ��ϵ����
       PARTICIPANT8_CNT,                                             -- ͬ��,ʦͽ
       PARTICIPANT9_CNT                                              -- ����,ͬѧ
  from cu.zs_car_total2 t                                                
 where t.agr_fivepd30 = 1
       and t.product_type not like '%Ա��%'
       and t.product_type not like '%���%'
       and t.product_type not like '%����%'
