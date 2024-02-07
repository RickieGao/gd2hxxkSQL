insert into v_ewell_inpatient_info 
select a.* from v_ewell_inpatient_info@ewell_db a
--where ward_name like '%心血管%'
--and status = '住院'
where patient_id='638706'
select a.* from v_ewell_inpatient_info a
where patient_id='651966'
--护理计划模板
insert into MCS_nursing_plan_TEMPLATE
select a.*,rowid from MCS_nursing_plan_TEMPLATE a
@ewell_db

select a.*,rowid from mcs_order_schedule a
where  patient_id = '648140'
and bar_code like '022%'

select * from gdmch.v_ewell_inpatient_lis_order@his_db
where patient_id = '648140'
A2239798327
A2239799416
02239844445
02239844447
A2239894205
A2239894207
02239926045
02239926047
02239926049
--his 原始遗嘱
select * from v_ewell_inpatient_order2@his_db
--where dept_code = '0338'
--order by start_time desc
where admission_id = '2023-58816'
select * from v_ewell_inpatient_order3@his_db
where patient_id = '638706'


insert into mcs_order_schedule
select * from mcs_order_schedule@ewell_db
where patient_id = '648140'

delete from mcs_order_schedule
where patient_id = '648140'
select a.*,rowid from v_ewell_blood_yh a
where pack_no = '440111824245255E3039000'


insert into v_ewell_blood_yh
select kk.* from v_ewell_blood_yh@ewell_db kk
where ward_code ='血液科'
and pack_no = '440111824245255E3039000'

select ddd.*,rowid from  mcs_transf_blood ddd 
where pack_no = '440111824245255E3039000'

select a.*,rowid from v_ewell_inpatient_info a
where ward_name like '%肾内%'
and status = '住院'
and patient_id not like '%B%'

select a.*,rowid from MCS_MSYS_DEPT_WARD a
where name like '%心血管内一科%'


insert into mcs_sys_log
select * from mcs_sys_log@ewell_db
where log_time>=to_date('2022-8-25 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and log_time<to_date('2022-8-26 00:00:00', 'yyyy-MM-dd hh24:mi:ss')

select a.*,rowid from mcs_sys_log a
order by log_time desc
where log_time>=to_date('2022-8-10 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and log_time<to_date('2022-8-11 00:00:00', 'yyyy-MM-dd hh24:mi:ss')


insert into v_ewell_blood_yh
select * from v_ewell_blood_yh@ewell_db
where patient_id = '598968'

select * from v_ewell_blood_yh
where patient_id = '598968'

select a.*,rowid from mcs_transf_blood a
where patient_id = '598968'

select a.*,rowid from mcs_sys_log a

delete from mcs_sys_log
update mcs_sys_log set log_time = to_date('2023/9/4 19:03:40', 'yyyy-MM-dd hh24:mi:ss')



-------------------------------------------------输血信息------------------------------------
--输血基本表
select kk.*,rowid from v_ewell_blood_yh kk
--where ward_code = '血液科'
--order by plan_time desc
--where patient_id = '648140'
--order by plan_time desc
where pack_no like '%440112323543155E3040000%'
where apply_no = 'R2238767608'

select distinct(ward_code) from v_ewell_blood_yh  kk
where plan_time > to_date('2023-01-01', 'yyyy-mm-dd')

--输血执行表
select ddd.*,rowid from  mcs_transf_blood ddd
--where sx_time is not null
--order by sx_time desc
--where blood_name like '%手工分%'
--and a.blood_name not like 
where pack_no like '%440112323543155E3040000%'


select distinct(blood_name) from  mcs_transf_blood ddd 
--动作表
select a.*,rowid from mcs_blood_patrol_info a
--order by record_time desc
where blood_pack_no like '%440112317433855D1100600%'
