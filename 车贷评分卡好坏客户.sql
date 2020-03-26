---------------------------坏客户-----------------------------------------------------
select * from cu.zs_car_total t
where t.dpd30=1;

select * from cu.zs_car_total t 
where t.agr_fivepd30=1
and t.def_fpd30+t.def_spd30+t.def_tpd30+t.def_qpd30+t.def_fivepd30=1;
select * from cu.zs_car_total t 
where  t.def_fpd30+t.def_spd30+t.def_tpd30+t.def_qpd30+t.def_fivepd30=1;
---------------------------好客户----------------------------------------------------
select * from cu.zs_car_total t
where t.dpd30=0;
select * from cu.zs_car_total t 
where t.agr_fivepd30=1
and t.def_fpd30+t.def_spd30+t.def_tpd30+t.def_qpd30+t.def_fivepd30=0;
select * from cu.zs_car_total t 
where t.def_fpd30+t.def_spd30+t.def_tpd30+t.def_qpd30+t.def_fivepd30=0;

select * from cu.zs_car_total t 
