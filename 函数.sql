---9.EXTRA_SA_AVG    ����
/*cu.f_sco_number_compress_dj����������������������������������Ӧ�����������������С�����ÿ����С�����Ƿ�����ÿ��Ҫ����С��������*/
--insert into sco.SHENJI_AREA_VAR_woe_step1(create_time,update_time,group_type,testname,clus,n,n1,badrate,is_num,is_monotone,default_group ,woe )
select  sysdate CREATE_TIME,
        sysdate UPDATE_TIME,
        'EXTRA_SA_AVG' GROUP_TYPE,
        type_name TESTNAME,
        N,
        N1,
        row_number()over(order by woe desc) clus, 
        rate badrate,
        1 IS_NUM,
        1 IS_MONOTONE,
        '1' default_group,
        WOE
from
(select * 
 from table(cu.f_sco_number_compress_dj('sco.shenji_area_train_new','EXTRA_SA_AVG','','def_fpd30',2,5,100,1,200)) 
)t2
where t2.type_name is not null
order by t2.woe desc
;
--COMMIT;
