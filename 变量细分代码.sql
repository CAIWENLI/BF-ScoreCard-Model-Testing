----文本变量细分-------------
--------belong_area(19689)-------------------
select 
t1.belong_area testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.belong_area
and t.name='BELONG_AREA'
group by t1.belong_area,t.clus;

select 
'BELONG_AREA'
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.belong_area
and t.name='BELONG_AREA'
group by cube( t.clus);
--------------------------------------
------------------CAR_BRAND(19689)-----------------
select 'CAR_BRAND' GROUP_TYPE
,t1.CAR_BRAND testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.CAR_BRAND
and t.name='CAR_BRAND'
group by t1.CAR_BRAND,t.clus;

select 'CAR_BRAND' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.CAR_BRAND
and t.name='CAR_BRAND'
group by cube(t.clus);

---------------------CAR_JORUNEY--空值为12249,建议删除----------
select 'CAR_JORUNEY' GROUP_TYPE
,t1.CAR_JORUNEY testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.CAR_JORUNEY
and t.name='CAR_JORUNEY'
group by t1.CAR_JORUNEY,t.clus;

select 'CAR_JORUNEY' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.CAR_JORUNEY
and t.name='CAR_JORUNEY'
group by cube(t.clus);

-----------CERTF_AWD_YEAR 有值为172条 建议删除------------
select 'CERTF_AWD_YEAR' GROUP_TYPE
,t1.CERTF_AWD_YEAR testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.CERTF_AWD_YEAR
and t.name='CERTF_AWD_YEAR'
group by t1.CERTF_AWD_YEAR,t.clus;

select 'CERTF_AWD_YEAR' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.CERTF_AWD_YEAR
and t.name='CERTF_AWD_YEAR'
group by cube( t.clus);

----------CERTF_EXP_YEAR  有值为172条 建议删除------------
select 'CERTF_EXP_YEAR' GROUP_TYPE
,t1.CERTF_EXP_YEAR testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.CERTF_EXP_YEAR
and t.name='CERTF_EXP_YEAR'
group by t1.CERTF_EXP_YEAR,t.clus;

select 'CERTF_EXP_YEAR' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.CERTF_EXP_YEAR
and t.name='CERTF_EXP_YEAR'
group by cube( t.clus);

--------------CITY（19689）按省份来区分
select 'CITY' GROUP_TYPE
,t1.CITY testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.CITY
and t.name='CITY'
group by t1.CITY,t.clus;

select 'CITY' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.CITY
and t.name='CITY'
group by cube( t.clus);

------------------EDU_DEGREE（6474）空值太多，建议删除-------------
select 'EDU_DEGREE' GROUP_TYPE
,t1.EDU_DEGREE testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.EDU_DEGREE
and t.name='EDU_DEGREE'
group by t1.EDU_DEGREE,t.clus;

select 'EDU_DEGREE' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.EDU_DEGREE
and t.name='EDU_DEGREE'
group by cube( t.clus);

-------------
--------------EDU_EXPERIENCE（19603）-------------
select 'EDU_EXPERIENCE' GROUP_TYPE
,t1.EDU_EXPERIENCE testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.EDU_EXPERIENCE
and t.name='EDU_EXPERIENCE'
group by t1.EDU_EXPERIENCE,t.clus;

select 'EDU_EXPERIENCE' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.EDU_EXPERIENCE
and t.name='EDU_EXPERIENCE'
group by cube( t.clus);

-------------EMPLOYEE_TYPE(19602)---全是全职自雇和全职雇佣，而且两个的 
select 'EMPLOYEE_TYPE' GROUP_TYPE
,t1.EMPLOYEE_TYPE testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.EMPLOYEE_TYPE
and t.name='EMPLOYEE_TYPE'
group by t1.EMPLOYEE_TYPE,t.clus;

select 'EMPLOYEE_TYPE' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.EMPLOYEE_TYPE
and t.name='EMPLOYEE_TYPE'
group by cube( t.clus);


------------------HEADSHIP(19605)
select 'HEADSHIP' GROUP_TYPE
,t1.HEADSHIP testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target))*100,2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.HEADSHIP
and t.name='HEADSHIP'
group by t1.HEADSHIP,t.clus;

select 'HEADSHIP' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.HEADSHIP
and t.name='HEADSHIP'
group by cube( t.clus);

---------------OCCUPATION(19605)
select 'OCCUPATION' GROUP_TYPE
,t1.OCCUPATION testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.OCCUPATION
and t.name='OCCUPATION'
group by t1.OCCUPATION,t.clus;

select 'OCCUPATION' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.OCCUPATION
and t.name='OCCUPATION'
group by cube( t.clus);

------------POSITION(19605)
select 'POSITION' GROUP_TYPE
,t1.OCCUPATION testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.OCCUPATION
and t.name='POSITION'
group by t1.OCCUPATION,t.clus;

select 'POSITION' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.OCCUPATION
and t.name='POSITION'
group by cube( t.clus);

----------PRODUCT_TYPE(19689)
select 'PRODUCT_TYPE' GROUP_TYPE
,t1.PRODUCT_TYPE testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.PRODUCT_TYPE
and t.name='PRODUCT_TYPE'
group by t1.PRODUCT_TYPE,t.clus;

select 'PRODUCT_TYPE' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.PRODUCT_TYPE
and t.name='PRODUCT_TYPE'
group by cube( t.clus);

-------------PROVINCE(19689)
select 'PROVINCE' GROUP_TYPE
,t1.PROVINCE testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.PROVINCE
and t.name='PROVINCE'
group by t1.PROVINCE,t.clus;

select 'PROVINCE' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.PROVINCE
and t.name='PROVINCE'
group by cube( t.clus);


---REPLACE_BANK(19689)
select 'REPLACE_BANK' GROUP_TYPE
,t1.REPLACE_BANK testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.REPLACE_BANK
and t.name='REPLACE_BANK'
group by t1.REPLACE_BANK,t.clus;

select 'REPLACE_BANK' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.REPLACE_BANK
and t.name='REPLACE_BANK'
group by cube( t.clus);

-----SERVICEPROVIDERS_BANK(19689)

select 'SERVICEPROVIDERS_BANK' GROUP_TYPE
,t1.SERVICEPROVIDERS_BANK testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.OCCUPATION
and t.name='SERVICEPROVIDERS_BANK'
group by t1.SERVICEPROVIDERS_BANK,t.clus;

select 'SERVICEPROVIDERS_BANK' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.SERVICEPROVIDERS_BANK
and t.name='SERVICEPROVIDERS_BANK'
group by cube( t.clus);

------------SERVICEPROVIDER_SNAME(19689)

select 'SERVICEPROVIDER_SNAME' GROUP_TYPE
,t1.SERVICEPROVIDER_SNAME testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.SERVICEPROVIDER_SNAME
and t.name='SERVICEPROVIDER_SNAME'
group by t1.SERVICEPROVIDER_SNAME,t.clus;

select 'SERVICEPROVIDER_SNAME' GROUP_TYPE
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.SERVICEPROVIDER_SNAME
and t.name='SERVICEPROVIDER_SNAME'
group by cube( t.clus);

--
select 'SERVICEPROVIDER_SNAME' GROUP_TYPE
,t1.SERVICEPROVIDER_SNAME testname
,t.clus
,sum(t1.target) N1
,count(t1.target)N
,round(decode(count(t1.target),0,0,sum(t1.target)/count(t1.target)),2)||'%' Badrate
from ZS_VAR_CLUSTER_OUT t,sco.zs_car_basetrain t1
where t.testname=t1.SERVICEPROVIDER_SNAME
and t.name='SERVICEPROVIDER_SNAME'
group by t1.SERVICEPROVIDER_SNAME,t.clus;


---数值变量细分；





---9.EXTRA_SA_AVG    函数
/*cu.f_sco_number_compress_dj（‘表名’，‘列名’，‘条件’，响应变量，组数，组间最小间隔，每组最小单，是否有序，每组要求最小样本数）*/
--insert into sco.SHENJI_AREA_VAR_woe_step1(create_time,update_time,group_type,testname,clus,n,n1,badrate,is_num,is_monotone,default_group ,woe )
select  sysdate CREATE_TIME,
        sysdate UPDATE_TIME,
        'CAR_GUIDEPRICE' GROUP_TYPE,
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
 from table(cu.f_sco_number_compress_dj('sco.zs_car_basetrain','CAR_GUIDEPRICE','','target',2,5,100,1,200)) 
)t2
where t2.type_name is not null
order by t2.woe desc
;
--COMMIT;







