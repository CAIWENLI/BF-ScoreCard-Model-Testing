------------------�ı�����ϸ����-------------------
---1.belong_area-----------------------
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time) 
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
from sco.zs_car_basetrain t 
group by cube(case when t.belong_area in ('����','����') then '1'
            when t.belong_area in ('����','����') then '2'
            when t.belong_area in ('����') then '3' 
            else 'other' end)
);
--commit;
/*
----2.car_brand(����̫ϸ�����鲻����)
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

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
from sco.zs_car_basetrain t 
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
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

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
from sco.zs_car_basetrain t 
group by cube(case when t.EDU_EXPERIENCE in ('�о���','��ѧ����'��'��ѧר��') then '1'
            when t.EDU_EXPERIENCE in ('����','��ר/�еȼ�У','����ѧУ','����') then '2'
            else '3' end)
);
--commit;


-----4.headship
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

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
from sco.zs_car_basetrain t 
group by cube(case when t.headship in ('�߲������Ա/�ܼ�����/�ּ����ϸɲ�','�в������Ա/��������/�Ƽ����ϸɲ�') then '1'
            when t.headship in ('���������Ա/�����鳤/��Ա','˾��','����/�н�/ҵ�����/����') then '2'
            when t.headship in ('����','ũ��','����','��ҵ/����ҵ��Ա','һ��Ա��') then '3'
            else '4' end )
)
;
--commit;

----5.occupation 
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

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
from sco.zs_car_basetrain t 
group by cube(case when t.headship in ('���һ��ء���Ⱥ��֯����ҵ����ҵ��λ������','��������������ҵ��Ա') then '1'
            when t.headship in ('�����������豸������Ա���й���Ա','������Ա���й���Ա','��ҵ������ҵ��Ա') then '2'
            when t.headship in ('ũ���֡������桢ˮ��ҵ������Ա','רҵ������Ա','δ֪') then '3'
             else  'other' end)
)
;
--commit;

----6.PRODUCT_TYPE
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

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
from sco.zs_car_basetrain t 
group by cube(case when t.PRODUCT_TYPE in ('���ֿ����') then '1'
            when t.PRODUCT_TYPE in ('�������ɹ�','�Ῠ��','������') then '2'
            when t.PRODUCT_TYPE in ('������e��','�۱���','�����') then '3'
             else  'other' end)
)
;
--commit;

-----7.PROVINCE
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

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
from sco.zs_car_basetrain t 
group by cube(case when t.PROVINCE in ('����ʡ','����ʡ','������','����ʡ') then '1'
            when t.PROVINCE in ('����ʡ','����ʡ','����ʡ','����ʡ','����ʡ','ɽ��ʡ','�ӱ�ʡ','����ʡ') then '2'
            when t.PROVINCE in ('������ʡ','����ʡ','����ʡ','���ɹ�������','ɽ��ʡ') then '3'
            when t.PROVINCE in ('����ʡ','�㶫ʡ','����ʡ','������','����ʡ','�Ĵ�ʡ','�½�','���Ļ���������','�����') then '4'
             else  'other' end)
)
;
--commit;



-----9.CUSTOMER_GENDER
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

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
from sco.zs_car_basetrain t 
group by cube(case when t.CUSTOMER_GENDER='Ů' then '2' 
             else  '1' end)
)
;
--commit;
-------10.HOUSE_HAVE
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

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
from sco.zs_car_basetrain t 
group by cube(case when t.HOUSE_HAVE='��' then '1' end  
         else '2'end)
)
;
--commit;


------11.MARRIAGE_STAUTS
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

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
from sco.zs_car_basetrain t 
group by cube(case when t.MARRIAGE_STAUTS='����' then '1' 
                   when t.MARRIAGE_STAUTS='δ��' then '2' 
                   when t.MARRIAGE_STAUTS='�ѻ�' then '3'  
                    else  'other' end )
)
;
--commit;

------12.carstatus1
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

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
from sco.zs_car_basetrain t 
group by cube(case when t.carstatus1='���ֳ�' then '1' 
            when t.carstatus1='�³�' then '2' 
             else  'other' end)
)
;
--commit;
