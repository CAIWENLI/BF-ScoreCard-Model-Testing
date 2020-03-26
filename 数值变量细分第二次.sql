
------------数值变量细分组------------------

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
--1、CHILDREN_TOTAL
--insert into  sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '宽表变量分析20160517' state_name,
       upper('CHILDREN_TOTAL ') var_name,
       decode(group_name,null,'CHILDREN_TOTAL '||'分析',null) group_type,
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
            else '(1,+∞]$other'  end  
                  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_CAR_train t 
group by cube(case when t.CHILDREN_TOTAL=0 then '0' 
            when t.CHILDREN_TOTAL=1 then '1'
            else '(1,+∞]$other' end  )
);
--commit;
delete from sco.zs_CAR_var_pre_v2 t
where var_name='GPS_SUM '
--2、GPS_SUM
--insert into  sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '宽表变量分析20160517' state_name,
       upper('GPS_SUM ') var_name,
       decode(group_name,null,'GPS_SUM '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when (t.GPS_SUM<=1068 or t.GPS_SUM is null) then '(-∞,1068]$null' 
            when t.GPS_SUM> 1068 then '(1068,+∞]'  end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_CAR_train t 
group by cube(case when (t.GPS_SUM<=1068 or t.GPS_SUM is null) then '(-∞,1068]$null' 
            when t.GPS_SUM> 1068 then '(1068,+∞]'  end)
);
--commit;
--3、SERVICE_FEE
--insert into  sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '宽表变量分析20160517' state_name,
       upper('SERVICE_FEE ') var_name,
       decode(group_name,null,'SERVICE_FEE '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when SERVICE_FEE<=130 then '(-∞,130]' 
            when SERVICE_FEE<=200 then '(130,200]'
            when SERVICE_FEE<=300 then '(200,300]'
            when SERVICE_FEE>300  then '(300,+∞]'                      
                 else 'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_CAR_train t 
group by cube(case when SERVICE_FEE<=130  then '(-∞,130]' 
                   when SERVICE_FEE<=200 then '(130,200]'
                   when SERVICE_FEE<=300 then '(200,300]'
                   when SERVICE_FEE>300 then '(300,+∞]'                      
                   else 'other' end)
);
--commit;
/*(-∞,133]
(133,218]
(218,388]
(388,+∞]
*/
-----4、VEHICLE_PRICE
--insert into  sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '宽表变量分析20160517' state_name,
       upper('VEHICLE_PRICE ') var_name,
       decode(group_name,null,'VEHICLE_PRICE '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when VEHICLE_PRICE<=84300  then '(-∞,84300]' 
            when VEHICLE_PRICE<=240000 then '(84300,240000]'
            when VEHICLE_PRICE>240000 then '(240000,+∞]'                        
            else 'other' end group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_CAR_train t 
group by cube(case when VEHICLE_PRICE<=84300  then '(-∞,84300]' 
                   when VEHICLE_PRICE<=240000 then '(84300,240000]'
                   when VEHICLE_PRICE>240000  then '(240000,+∞]'                        
                   else 'other' end)
);
--commit;

----5、PAYMENT_SUM 
--insert into  sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '宽表变量分析20160517' state_name,
       upper('PAYMENT_SUM ') var_name,
       decode(group_name,null,'PAYMENT_SUM '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when PAYMENT_SUM<=19800  then '(-∞,19800]' 
                   when PAYMENT_SUM<=43800 then '(19800,43800]'  
                   when PAYMENT_SUM>43800  then '(43800,+∞]'                                          
                   else 'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_CAR_train t 
group by cube(case when PAYMENT_SUM<=19800  then '(-∞,19800]' 
                   when PAYMENT_SUM<=43800 then '(19800,43800]'  
                   when PAYMENT_SUM>43800  then '(43800,+∞]'                                          
                   else 'other' end
              )
)
--commit;

--原来自己手工分组的
/*(61000,+∞]
(41000,61000]
(-∞,41000]*/

----6、BUSINESSSUM
--insert into  sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '宽表变量分析20160517' state_name,
       upper('BUSINESSSUM ') var_name,
       decode(group_name,null,'BUSINESSSUM '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when BUSINESSSUM<=52500  then '(-∞,52500]' 
            when BUSINESSSUM<=77100 then '(52500,77100]'  
            when BUSINESSSUM>77100 then '(77100,+∞]'                                          
            else 'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_train t 
group by cube(case when BUSINESSSUM<=52500  then '(-∞,52500]' 
            when BUSINESSSUM<=77100 then '(52500,77100]'  
            when BUSINESSSUM>77100 then '(77100,+∞]'                                          
            else 'other' end )
)
--commit;
--原来自己的手工分组
/*(-∞,42000]
(42000,77000]
(77000,+∞]*/

--8、CAR_GUIDEPRICE
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '宽表变量分析20160517' state_name,
       upper('CAR_GUIDEPRICE ') var_name,
       decode(group_name,null,'CAR_GUIDEPRICE '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when CAR_GUIDEPRICE<=87000  then '(-∞,87100]' 
            when CAR_GUIDEPRICE<=167000 then '(87100,137300]'  
            when CAR_GUIDEPRICE>167000 then '(137300,+∞]'                                          
            else 'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from cu.zs_car_add_basetrain t 
group by cube(case when CAR_GUIDEPRICE<=87000  then '(-∞,87100]' 
            when CAR_GUIDEPRICE<=167000 then '(87100,137300]'  
            when CAR_GUIDEPRICE>167000 then '(137300,+∞]'                                          
            else 'other' end)
);
--commit;
/*(-∞,87100]
(87100,137300]
(137300,+∞]*/

--9、CAR_TOTAL
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '宽表变量分析20160517' state_name,
       upper('CAR_TOTAL ') var_name,
       decode(group_name,null,'CAR_TOTAL '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when CAR_TOTAL<=80000  then '(-∞,80000]' 
            when CAR_TOTAL<=128000 then '(80000,128000]'  
            when CAR_TOTAL>128000 then '(128000,+∞]'                                          
            else 'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from cu.zs_car_add_basetrain t 
group by cube(case when CAR_TOTAL<=80000  then '(-∞,80000]' 
            when CAR_TOTAL<=128000 then '(80000,128000]'  
            when CAR_TOTAL>128000 then '(128000,+∞]'                                          
            else 'other' end)
);
--commit;
--10、MONTH_TOTAL
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '宽表变量分析20160517' state_name,
       upper('MONTH_TOTAL ') var_name,
       decode(group_name,null,'MONTH_TOTAL '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when (MONTH_TOTAL<=6300 or MONTH_TOTAL is null)  then '(-∞,6300]$other' ---空值归到最好的分组
            when MONTH_TOTAL<=22500 then '(6300,22500]'  
            when MONTH_TOTAL>22500 then '(22500,+∞]' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from cu.zs_car_add_basetrain t 
group by cube(case when (MONTH_TOTAL<=6300 or MONTH_TOTAL is null)  then '(-∞,6300]$other' ---空值归到最好的分组
            when MONTH_TOTAL<=22500 then '(6300,22500]'  
            when MONTH_TOTAL>22500 then '(22500,+∞]' end)
);
--commit;


--11、MFEE_SUM
--insert into sco.zs_CAR_var_pre_v2(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)
select '宽表变量分析20160517' state_name,
       upper('MFEE_SUM ') var_name,
       decode(group_name,null,'MFEE_SUM '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when MFEE_SUM<=0  then '(-∞,0]' 
            when MFEE_SUM<=30 then '(0,30]'  
            when MFEE_SUM>30 then '(30,+∞]'                                          
            else 'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from cu.zs_car_add_basetrain t 
group by cube(case when MFEE_SUM<=0  then '(-∞,0]' 
            when MFEE_SUM<=30 then '(0,30]'  
            when MFEE_SUM>30 then '(30,+∞]'                                          
            else 'other' end )
);
--commit;


