create table sco.zs_car_test_testname_v1 
as
(
select 
      t.contract_no
     ,t.target
     ,t.inputdate
     ,case when t.CHILDREN_TOTAL=0 then '0' 
           when t.CHILDREN_TOTAL=1 then '1'
           else '(1,+∞]$other'  end  CHILDREN_TOTAL
     ,case when (t.GPS_SUM<=1068 or t.GPS_SUM is null) then '(-∞,1068]$null' 
           when t.GPS_SUM> 1068 then '(1068,+∞]'  end  GPS_SUM
     ,case when SERVICE_FEE<=130 then '(-∞,130]' 
           when SERVICE_FEE<=200 then '(130,200]'
           when SERVICE_FEE<=300 then '(200,300]'
           when SERVICE_FEE>300  then '(300,+∞]'                      
           else 'other' end  SERVICE_FEE
     ,case when VEHICLE_PRICE<=84300  then '(-∞,84300]' 
           when VEHICLE_PRICE<=240000 then '(84300,240000]'
           when VEHICLE_PRICE>240000 then '(240000,+∞]'                        
           else 'other' end VEHICLE_PRICE
     ,case when PAYMENT_SUM<=19800  then '(-∞,19800]' 
           when PAYMENT_SUM<=43800 then '(19800,43800]'  
           when PAYMENT_SUM>43800  then '(43800,+∞]'                                          
           else 'other' end PAYMENT_SUM
     ,case when BUSINESSSUM<=52500  then '(-∞,52500]' 
           when BUSINESSSUM<=77100 then '(52500,77100]'  
           when BUSINESSSUM>77100 then '(77100,+∞]'                                          
           else 'other' end   BUSINESSSUM
     ,case when CAR_GUIDEPRICE<=87000  then '(-∞,87100]' 
           when CAR_GUIDEPRICE<=167000 then '(87100,137300]'  
           when CAR_GUIDEPRICE>167000 then '(137300,+∞]'                                          
           else 'other' end   CAR_GUIDEPRICE
     ,case when CAR_TOTAL<=80000  then '(-∞,80000]' 
           when CAR_TOTAL<=128000 then '(80000,128000]'  
           when CAR_TOTAL>128000 then '(128000,+∞]'                                          
           else 'other' end  CAR_TOTAL
     ,case when (MONTH_TOTAL<=6300 or MONTH_TOTAL is null) then '(-∞,6300]$null' ---空值归到最好的分组
           when MONTH_TOTAL<=22500 then '(6300,22500]'  
           when MONTH_TOTAL>22500 then '(22500,+∞]' end MONTH_TOTAL
     ,case when MFEE_SUM<=0  then '(-∞,0]' 
           when MFEE_SUM<=30 then '(0,30]'  
           when MFEE_SUM>30 then '(30,+∞]'                                          
           else 'other' end  MFEE_SUM
     ,case when t.belong_area in ('华东','华南') then '1'
           when t.belong_area in ('东北','华北') then '2'
           when t.belong_area in ('西区') then '3' 
           else 'other' end belong_area
     ,case when t.car_brand in 
        ('上汽汽车','吉奥','东风裕隆','福迪汽车','华泰','三菱','华晨中华','奔驰','现代'
        ,'猎豹','福特','通用','路虎','起亚','北京汽车','宝马','奥迪','大众','马自达') then '1'
          when t.car_brand in 
        ('广汽乘用车','一汽奔腾','雪铁龙','丰田','日产','标致','别克','本田','江淮汽车'
         ,'雪佛兰','野马汽车','铃木','江铃','力帆') then '2'
          when t.car_brand in 
        ('猎豹汽车','海马','众泰','东风乘用车','吉利','奇瑞','上海大众斯柯达','长安汽车'
         ,'福田汽车','东风小康','北汽威旺','陆风汽车','东南汽车','长城汽车','五菱','中兴') then '3'
          when t.car_brand in 
        ('比亚迪','东风风行','Jeep','金杯','北汽银翔','北汽幻速','潍柴汽车') then '4'
          else 'other' end car_brand
     ,case when t.EDU_EXPERIENCE in ('研究生','大学本科','大学专科') then '2'
          else '1' end EDU_EXPERIENCE
     ,case when t.headship in ('高层管理人员/总监以上/局级以上干部','中层管理人员/经理以上/科级以上干部') then '1'
           when t.headship in ('基层管理人员/主管组长/科员','司机','销售/中介/业务代表/促销') then '2'
           when t.headship in ('个体','农民','其它','商业/服务业人员','一般员工') then '3'
           else '4' end headship
     ,case when t.PRODUCT_TYPE in ('二手快捷融') then '1'
           when t.PRODUCT_TYPE in ('二手轻松购','轻卡融','舒心融') then '2'
           when t.PRODUCT_TYPE in ('二手融e购','聚宝融','快捷融') then '3'
           else  'other' end PRODUCT_TYPE
     ,case when t.PROVINCE in ('福建省','陕西省','重庆市','湖北省') then '1'
           when t.PROVINCE in ('江西省','吉林省','江苏省','广西省','辽宁省','山东省','河北省','湖南省') then '2'
           when t.PROVINCE in ('黑龙江省','安徽省','河南省','内蒙古自治区','山西省') then '3'
           when t.PROVINCE in ('贵州省','广东省','云南省','北京市','海南省','四川省','新疆','宁夏回族自治区','天津市') then '4'
           else  'other' end PROVINCE
     ,case when t.CUSTOMER_GENDER='女' then '2' 
           else  '1' end CUSTOMER_GENDER
     ,case when t.HOUSE_HAVE='有' then '1'  
           else '2'end HOUSE_HAVE
     ,case when t.MARRIAGE_STAUTS='离异' then '1' 
           when t.MARRIAGE_STAUTS='未婚' then '2' 
            else  '3' end MARRIAGE_STAUTS
     ,case when t.carstatus1='二手车' then '1' 
           when t.carstatus1='新车' then '2' 
           else  'other' end carstatus1
 from sco.zs_car_total_base t);---截止到2016年5月26车贷追踪总表
