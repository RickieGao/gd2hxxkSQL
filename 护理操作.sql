--护理操作
--科室字典
select a.*,rowid from MCS_MSYS_DEPT_WARD a
--where abb = '3'
where name like '%消化%'
where code in ('92')

select a.*,rowid from mcs_sys_user_wards a
where user_id in (select id from mcs_sys_users where user_code in (
'0350'))

update mcs_sys_users
set user_type = 'NURSE'
WHERE user_type is null

select * from mcs_sys_users
where user_type is null
---------------------------------------------------护士权限分配---------------------------------------------------
--根据工号批量添加用户
insert into mcs_sys_users
select mcs_sys_user_id.nextval,lsh,xm,'c4ca4238a0b923820dcc509a6f75849b','','NURSE','','1','0','' from gdmch.rl_t_ygk@his_db 
where lsh in (
'Q427',
'Q440',
'Q441',
'Q430',
'Q492',
'Q490',
'Q443',
'R596'
)

--根据科室分配权限
insert into mcs_sys_user_wards
select id,
'55'--分配权限病区
from mcs_sys_users
where user_code in 
(select lsh from gdmch.rl_t_ygk@his_db where 
ksbm='0338'--待分配权限科室
and nvl(zwdm,'未定职务') in 
('4053',--护师
'4013',--副主任护师
'4033',--主管护师
'4062',--护士
'4097'--助理护士
) and lsh in 
(select yhbm from gdmch.zt_t_user@his_db where yhmm is not null and yhzt='1' and (jslb is not null or mklb is not null)))

--同步his护士工作站权限
insert into mcs_sys_user_wards
select b.id,
a.bqbh
from gdmch.Ks_t_bqqx@his_db a left join mcs_sys_users b on a.ygh = b.user_code
where a.ygh in (
'0228',
'0236',
'Q027',
'T630',
'0235',
'Z702',
'8581',
'8515',
'Z324',
'T096',
'Z325',
'T140',
'Q128',
'8470',
'Z322',
'T592',
'0227',
'Z323',
'Q277',
'0242'
)

--根据科室删除除特定病区外的权限
delete from mcs_sys_user_wards
where user_id in (select id from mcs_sys_users where user_code in 
(select lsh from gdmch.rl_t_ygk@his_db where 
ksbm='0045'--待分配权限科室
and nvl(zwdm,'未定职务') in 
('4053',--护师
'4013',--副主任护师
'4033',--主管护师
'4062',--护士
'4097'--助理护士
) and lsh in 
(select yhbm from gdmch.zt_t_user@his_db where yhmm is not null and yhzt='1' and (jslb is not null or mklb is not null))))
and ward_code not in ('04','9N')


--删除表里的重复数据
delete from mcs_sys_user_wards where (user_id,ward_code) in (select user_id,ward_code from mcs_sys_user_wards a
group by user_id,ward_code having count(*)>1)
and rowid not in
(select max(rowid) from mcs_sys_user_wards a
group by user_id,ward_code having count(*)>1)

select count(*) from mcs_sys_user_wards a
group by user_id,ward_code having count(*)>1

select count(*) from mcs_sys_user_wards a

--根据工号分配权限
insert into mcs_sys_user_wards
select id,
('57')--分配权限病区
from mcs_sys_users
where user_code in 
('0228',
'0236',
'Q027',
'T630',
'0235',
'Z702',
'8581',
'8515',
'Z324',
'T096',
'Z325',
'T140',
'Q128',
'8470',
'Z322',
'T592',
'0227',
'Z323',
'Q277',
'0242'
)

--根据工号开启ca
update mcs_sys_users a
set a.isopen_ca = 1
where user_code in 
('Q205'
)

select a.*,rowid from mcs_sys_users a
where user_code in 
('T967','T742','S175','R721','T987','S096','S091','R219','R483'
)

--根据工号分配全院病区权限
insert into mcs_sys_user_wards
select id,b.code from mcs_sys_users a,MCS_MSYS_DEPT_WARD b
where b.is_dept = '0'
and b.code not in ('53','54','55','91','92','93','94','81','98')
and b.abb is null
and a.user_code in (
'J151',
'0LYT',
'8066',
'0190',
'8245',
'8643',
'S912',
'S872',
'Z690',
'Q005'
)


select b.* from MCS_MSYS_DEPT_WARD b
where b.is_dept = '0'
and b.code not in ('53','54','55','91','92','93','94','81','98')
and b.abb is null
--根据工号删除权限
delete from mcs_sys_user_wards
where user_id not in (select id from mcs_sys_users where user_code in (
'0167',
'0347',
'0350',
'T781',
'T103',
'T619',
'T937',
'T946',
'R069','DBA'))
and ward_code in ('9L')

--删除所有人的该病区权限
delete from mcs_sys_user_wards
where ward_code in ('72','80','79','73','74','75','76','77','78','67','66','65','64','63','62','61','60','53','54','55','71','70','69')

--根据姓名分配权限
insert into mcs_sys_user_wards
select id,
('74')--分配权限病区
from mcs_sys_users
where user_name in 
('李燕燕','唐丽钊','李惠婷','张泳琳','尹琼娇','袁莉','曾晓明','胡芳芳','刘曼玲','朱小银','刘雪岩','刘燕芳','李松芬','罗湘金',
'孔玉玲','王亚丹','龚雯','桂慧琳','刘贺玲','谢敏','阳婷','刘惠远','沈美玲')

--给有这个病区权限的所有人分配另一个病区权限
insert into mcs_sys_user_wards
select user_id,'9P' from mcs_sys_user_wards
where ward_code = '15'

--查找特定科室的所有护士
select xm,ksmc from gdmch.rl_t_ygk@his_db a left join gdmch.rl_t_keshiku@his_db b on b.ksbm = a.ksbm 
where ksmc like '%MH%'
and nvl(zwdm,'未定职务') in 
('4053',--护师
'4013',--副主任护师
'4033',--主管护师
'4062',--护士
'4097'--助理护士
) and lsh in 
(select yhbm from gdmch.zt_t_user@his_db where yhmm is not null and yhzt='1' and (jslb is not null or mklb is not null))

select *from mcs_sys_user_wards
 where (user_id,ward_code) in ( select user_id,ward_code from mcs_sys_user_wards
 group by user_id,ward_code
 having count(1)>1)
 and rowid not in (
 select max(rowid) from mcs_sys_user_wards
 group by user_id,ward_code
 having count(1)>1
 ) and  user_id='4023'
 
update v_ewell_inpatient_info a
set a.bed_no = 'B'||a.bed_no
where ward_code = '0B'
and bed_no not like '%B%'

--给没有角色的用户分配普通护士角色
insert into mcs_sys_user_roles
select id,'4' from mcs_sys_users
where id not in (select distinct user_id from mcs_sys_user_roles)

--批量取消归档
update mcs_archived_patient a
set status = '0'
where patient_id in (
'566133'
)

--患者归档
select rowid,a.* from mcs_archived_patient a
where patient_id='700000'
-------------------------------------------------统计------------------------------------
--输血巡视每日统计
select h.name 科室,g.扫码执行总数,nvl(g.有巡视,0) 有巡视,nvl(g.巡视时间合规,0) 巡视时间合规,nvl(g.有扫结束,0) 有扫结束 from
(select c.ward_code,c.sum 扫码执行总数,d.sum 有巡视,e.sum 巡视时间合规,f.sum 有扫结束 from 
(select count(a.ward_code) sum,ward_code from mcs_transf_blood a
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
group by ward_code) c
left join
(select count(distinct(b.blood_pack_no)) sum,ward_code from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
and b.process_type = 'PATROL'
group by ward_code) d on c.ward_code = d.ward_code
left join
(select count(distinct(b.blood_pack_no)) sum,ward_code from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
and b.process_type = 'PATROL'
and (b.record_time - a.sx_start_time)*24*60 >= 5
and (b.record_time - a.sx_start_time)*24*60 <= 35
group by ward_code) e on c.ward_code = e.ward_code
left join
(select count(a.ward_code) sum,ward_code from mcs_transf_blood a
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
and sx_end_time is not null
group by ward_code) f on c.ward_code = f.ward_code
) g left join MCS_MSYS_DEPT_WARD h on g.ward_code = h.code

--手术出入科室扫描统计
select t.ward_name 科室名称, count(distinct order_no) 手术总数,nvl(sum(out_flag),0) 出病房扫描数,count(distinct order_no)-nvl(sum(out_flag),0) 出病房未扫数,nvl(sum(return_flag),0) 回病房扫描数,count(distinct order_no)-nvl(sum(return_flag),0) 回病房未扫数 from
(select b.ward_name,a.order_no,case c.type when 5 then 1 end out_flag, case c.type when 10 then 1 end return_flag
from gdmch.v_ewell_operation@his_db a left join v_ewell_inpatient_info b on a.patient_no = b.admission_id left join mcs_scan_turninout c on a.order_no = c.order_no
where a.start_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.end_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and b.ward_name not like '%MH%'
and b.ward_name not like '%ICU%'
and a.operation_type not like '%急诊%'
and a.ss_type = '手术'
and a.sss in ('1','2')
--and b.ward_name like '%全科%'
) t
group by ward_name

--手术出入科漏扫详情
select * from gdmch.v_ewell_operation@his_db a left join v_ewell_inpatient_info b on a.patient_no = b.admission_id 
where a.start_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.end_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and b.ward_name like '%日间%'
and b.ward_name not like '%MH%'
and a.operation_type not like '%急诊%'
and a.ss_type = '手术'
and a.sss in ('1','2')
and order_no not in (select order_no from mcs_scan_turninout
where order_no in (select order_no from gdmch.v_ewell_operation@his_db a left join v_ewell_inpatient_info b on a.patient_no = b.admission_id 
where a.start_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.end_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.operation_type not like '%急诊%'
and a.ss_type = '手术'
and a.sss in ('1','2')
and b.ward_name like '%日间%'
and b.ward_name not like '%MH%')
and type in ('5') --出科
--and type in ('10') --回科
)

select * from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
and b.process_type = 'PATROL'
and ((b.record_time - a.sx_start_time)*24*60 > 30
or (b.record_time - a.sx_start_time)*24*60 < 10)
and ward_code in ('19')
and a.pack_no in ('441202303549051')
--group by ward_code

select * from v_ewell_blood_yh a
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
and ward_code like ('%脊柱骨科%')
and pack_no not in (select pack_no from mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
and b.process_type = 'PATROL'
--and b.process_type = 'FINISHED'
and ward_code in ('56'))

--输血巡视每日统计
select c.name 科室,j.sum 计划扫码执行,nvl(i.扫码执行总数,0) 实际扫码执行,nvl(i.有巡视,0) 有巡视,nvl(i.巡视时间合规,0) 巡视时间合规,nvl(i.有扫结束,0) 有扫结束 from 
(select count(distinct b.pack_no) sum,b.ward_code from v_ewell_blood_yh b
where b.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and b.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and b.blood_name not like '%冷沉淀%'
and b.blood_name not like '%手工分%'
and ward_code not like '%MH%'
and ward_code != 'ICU'
group by ward_code
) j left join
(
select h.name,g.扫码执行总数,g.有巡视,g.巡视时间合规,g.有扫结束 from
(select c.ward_code,c.sum 扫码执行总数,d.sum 有巡视,e.sum 巡视时间合规,f.sum 有扫结束 from 
(select count(a.ward_code) sum,ward_code from mcs_transf_blood a
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
group by ward_code) c
left join
(select count(distinct(b.blood_pack_no)) sum,ward_code from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
and b.process_type = 'PATROL'
group by ward_code) d on c.ward_code = d.ward_code
left join
(select count(distinct(b.blood_pack_no)) sum,ward_code from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
and b.process_type = 'PATROL'
and (b.record_time - a.sx_start_time)*24*60 >= 10
and (b.record_time - a.sx_start_time)*24 <= 2
group by ward_code) e on c.ward_code = e.ward_code
left join
(select count(a.ward_code) sum,ward_code from mcs_transf_blood a
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
and sx_end_time is not null
group by ward_code) f on c.ward_code = f.ward_code
) g left join MCS_MSYS_DEPT_WARD h on g.ward_code = h.code
) i on i.科室 = j.ward_code

select * from mcs_blood_patrol_info
where blood_pack_no in ('440112215945355E5441000','440112217684355D6073000','440112217624055D6073000')

--输血标本采集统计
select * from mcs_order_schedule
where bar_code like '0222%'
and plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
order by start_time desc

select * from gdmch.v_ewell_inpatient_lis_order_al@his_db
where start_date > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and start_date < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')



select * from gdmch.v_ewell_operation@his_db a left join v_ewell_inpatient_info b on a.patient_no = b.admission_id 
where a.start_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.end_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and b.ward_name like '%内分泌%'


select * from mcs_scan_turninout
where order_no in (select order_no from gdmch.v_ewell_operation@his_db a left join v_ewell_inpatient_info b on a.patient_no = b.admission_id 
where a.start_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.end_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and b.ward_name like '%内分泌%')
and type in ('10','5')




select count(distinct order_no) 手术总数,nvl(sum(out_flag),0) 出病房扫描数,nvl(sum(return_flag),0) 回病房扫描数 from
(select b.ward_name,a.order_no,case c.type when 5 then 1 end out_flag, case c.type when 10 then 1 end return_flag
from gdmch.v_ewell_operation@his_db a left join v_ewell_inpatient_info b on a.patient_no = b.admission_id left join mcs_scan_turninout c on a.order_no = c.order_no
where a.start_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.end_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and b.ward_name not like '%MH%'
and b.ward_name not like '%ICU%'
and b.ward_name like '%内分泌%'
)


--输血总体情况，按时间段统计
select a.time 时间, a.num 输血总数,b.num 输血扫码执行总数,c.num 输血巡视总数,d.num 输血巡视时间合规总数,e.num 输血扫结束总数 from 
(select substr(to_char(plan_time),1,5) time,count(distinct pack_no) num from v_ewell_blood_yh
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and blood_name not like '%冷沉淀%'
and blood_name not like '%手工分%'
group by substr(to_char(plan_time),1,5)) a join 
(select substr(to_char(plan_time),1,5) time,count(distinct pack_no) num from mcs_transf_blood
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and blood_name not like '%冷沉淀%'
and blood_name not like '%手工分%'
group by substr(to_char(plan_time),1,5)
) b on a.time = b.time join
(select substr(to_char(record_time),1,5) time,count(distinct a.pack_no) num from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
and b.process_type = 'PATROL'
group by substr(to_char(record_time),1,5)
) c on a.time = c.time join
(select substr(to_char(record_time),1,5) time,count(b.blood_pack_no) num from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%冷沉淀%'
and a.blood_name not like '%手工分%'
and b.process_type = 'PATROL'
and (b.record_time - a.sx_start_time)*24*60 >= 10
and (b.record_time - a.sx_start_time)*24 <= 2
group by substr(to_char(record_time),1,5)
) d on a.time = d.time join
(select substr(to_char(plan_time),1,5) time,count(distinct pack_no) num from mcs_transf_blood
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and blood_name not like '%冷沉淀%'
and blood_name not like '%手工分%'
and sx_end_time is not null
group by substr(to_char(plan_time),1,5)
) e on a.time = e.time

--患者流转数据
select count(*) from mcs_scan_turninout a
where record_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and record_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
where type in ('5','10')

-------------------------------------------------护理工作量统计------------------------------------
--护士PDA工作量统计
select b.user_name 姓名,b.user_code 工号,count(distinct a.id) pda扫描量 from MCS_ORDER_SCHEDULE_PROCESS a left join mcs_sys_users b on a.recorder_id = b.id
where b.user_code = '0369'
and record_time >= to_date('2020-05-01', 'yyyy-mm-dd')
and record_time < to_date('2022-12-31', 'yyyy-mm-dd')
group by b.user_name,b.user_code
--护士PDA工作量统计（按年份）
select b.user_name 姓名,b.user_code 工号,extract(year from record_time) 年份,count(distinct a.id) pda扫描量 from MCS_ORDER_SCHEDULE_PROCESS a left join mcs_sys_users b on a.recorder_id = b.id
where b.user_name = '周建群'
and record_time >= to_date('2019-09-01', 'yyyy-mm-dd')
and record_time < to_date('2019-12-31', 'yyyy-mm-dd') + 1
group by b.user_name,b.user_code,extract(year from record_time) 

select b.user_name 姓名,b.user_code 工号,count(distinct a.id) pda扫描量 from MCS_ORDER_SCHEDULE_PROCESS a left join mcs_sys_users b on a.recorder_id = b.id
where b.user_name = '容英'
and record_time >= to_date('2021-01-01', 'yyyy-mm-dd')
and record_time < to_date('2021-12-31', 'yyyy-mm-dd')
group by b.user_name,b.user_code
--文书节点统计
select * from MCS_DOC_FORM a right join MCS_DOC_FORM_RECORDS b on a.id = b.form_id
where a.template_code = '378'
and a.is_valid = '1'
and b.node_code = '17965'
and b.string = '苏娜'

select extract(year from form_time),count(*) from MCS_DOC_FORM_RECORDS a left join MCS_DOC_FORM b on b.id = a.form_id
where node_code in ('13560','26837','26838','30504')
and string_value like '%刘静雯%'
group by extract(year from form_time)

select extract(year from form_time),count(distinct b.mrn) from MCS_DOC_FORM_RECORDS a left join MCS_DOC_FORM b on b.id = a.form_id
where node_code in ('13560','26837','26838','30504')
and string_value like '%刘静雯%'
group by extract(year from form_time)
--
--护士护理签名统计
select * from ca_sign_info
order by sign_date desc

select '容英' 姓名,'0369' 工号,extract(year from sign_date) 年份,count(*) 护理文书签名数量 from ca_sign_info 
where instr(original_sign_data,'容英|0369')>=1
and sign_date >= to_date('2022-01-01', 'yyyy-mm-dd')
and sign_date < to_date('2022-12-31', 'yyyy-mm-dd') + 1
group by extract(year from sign_date)
--有这个人签名的病历
select '何晓丽' 姓名,'8671' 工号,extract(year from sign_date) 年份,count(distinct b.mrn) 有签名的病历的数量 from ca_sign_info a left join MCS_DOC_FORM b on a.form_id = b.id
where instr(original_sign_data,'何晓丽|8671')>=1
and sign_date >= to_date('2000-01-01', 'yyyy-mm-dd')
--and sign_date < to_date('2022-12-31', 'yyyy-mm-dd') + 1
group by extract(year from sign_date)
--护理文书创建统计
select created_by 工号,extract(year from created_date) 年份,count(*) 护理文书创建数量 from MCS_DOC_FORM
where created_by = '0526'
and is_valid = 1
and created_date >= to_date('2015-01-01', 'yyyy-mm-dd')
and created_date < to_date('2022-12-31', 'yyyy-mm-dd')
group by created_by,extract(year from created_date)

select extract(year from created_date) 年份,count(distinct mrn) 护理文书创建或修改数量 from MCS_DOC_FORM
where (created_by = '0526' or last_updated_by = '0526')
and is_valid = 1
and created_date >= to_date('2015-01-01', 'yyyy-mm-dd')
and created_date < to_date('2022-12-31', 'yyyy-mm-dd')
group by extract(year from created_date)
--在院人数
select dept.name 科室名称, doc.数量 在院人数 from
(select ward_code,count(*) 数量 from v_ewell_inpatient_info
where admission_ward_time < to_date('2023-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')--结束日期
and (discharge_time >= to_date('2022-11-26 00:00:00', 'yyyy-mm-dd hh24:mi:ss') or discharge_time is null)--开始日期
and patient_id not like '%B%'
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
where dept.name like '%2-8%'

select dept.name 科室名称,doc.years 年度, doc.数量 在院人数 from
(select ward_code,extract(year from admission_ward_time) years,count(*) 数量 from v_ewell_inpatient_info
where admission_ward_time < to_date('2023-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')--结束日期
and (discharge_time >= to_date('2016-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss') or discharge_time is null)--开始日期
and patient_id not like '%B%'
group by ward_code,extract(year from admission_ward_time)) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
where dept.name like '%关节%'

--在院人员列表
select patient_id 住院号,admission_id 流水号,name 姓名,sex 性别,dept_name 科室,ward_name 病区,bed_no 床号,age 年龄,admission_time 入院时间,discharge_time 出院时间 from v_ewell_inpatient_info
where admission_time < to_date('2022-12-07 00:00:00', 'yyyy-mm-dd hh24:mi:ss') + 1--结束日期
and (discharge_time >= to_date('2022-11-28 00:00:00', 'yyyy-mm-dd hh24:mi:ss') or discharge_time is null)--开始日期
and patient_id not like '%B%'
and ward_code in ('77')
--新入院人员名单
select patient_id 住院号,admission_id 流水号,name 姓名,sex 性别,dept_name 科室,ward_name 病区,bed_no 床号,age 年龄,admission_time 入院时间,discharge_time 出院时间 from v_ewell_inpatient_info
where admission_time < to_date('2022-11-15 00:00:00', 'yyyy-mm-dd hh24:mi:ss') + 1--结束日期
and admission_time > to_date('2022-11-08 00:00:00', 'yyyy-mm-dd hh24:mi:ss')
and patient_id not like '%B%'
and ward_code in ('0A','0B','0C','0D','0E','0F','0G','0H','0J','0K','0L','0M')
------------------------------------------------------------------
--输液情况统计
select b.name 科室,count(*) 总数,sum(exe_flag) 执行数 from
(select ward_code,case when (execute_time is null) then 0 else 1 end exe_flag from mcs_order_schedule
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and supply_name = '静脉滴注') a left join MCS_MSYS_DEPT_WARD b on a.ward_code = b.code
group by b.name
--输液全院总体情况
select count(*) 输液总数,sum(exe_flag) 执行数,sum(exe_flag)/count(*) 执行率  from
(select ward_code,case when (execute_time is null) then 0 else 1 end exe_flag from mcs_order_schedule
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and supply_name = '静脉滴注'
and ward_code != '01')

--口服药情况统计
select b.name 科室,count(*) 总数,sum(exe_flag) 执行数,sum(exe_flag)/count(*) 执行率 from
(select ward_code,case when (execute_time is null) then 0 else 1 end exe_flag from mcs_order_schedule
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and supply_name = '口服'
and bar_code  like '%inp%'
) a left join MCS_MSYS_DEPT_WARD b on a.ward_code = b.code
group by b.name

--口服药全院总体情况
select count(*) 口服药总数,sum(exe_flag) 执行数,sum(exe_flag)/count(*) 执行率  from
(select ward_code,case when (execute_time is null) then 0 else 1 end exe_flag from mcs_order_schedule
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and supply_name = '口服'
and ward_code != '01')

--cda文档检查
--481-c出入量记录单   482-c出院评估与指导   483-c护理计划   484-c生命体征测量记录
--433-产前待产记录   431-分娩记录   403-内科护理记录单   437-外科护理记录单   278-首次护理记录单
select * from MCS_DOC_FORM
where created_date > Sysdate - 1
and template_code = '481'
--营养风险筛查统计
select count(distinct mrn) from Mcs_Doc_Form
where created_date > to_date('2021-01-01', 'yyyy-mm-dd')
and created_date < to_date('2022-01-01', 'yyyy-mm-dd')
and template_code = '476'
and total_score >= '3'



--ca截图
select c.id,c.patient_id,c.patient_name,c.bed_no,c.form_time,c.nurse_name,c.display_name,d.sign_data,d.time_data,d.cert_sn
from
(select a.id,a.patient_id,a.patient_name,a.bed_no,a.form_time,a.created_name nurse_name,b.display_name from MCS_DOC_FORM a left join MCS_DOC_MENU b on a.template_code = b.template_code
where a.patient_id = '602195'
and a.template_code = '403'
and b.seq = '10'
and a.form_time < to_date('2022-08-14 10:00:00', 'yyyy-mm-dd hh24:mi:ss')) c
left join ca_sign_info d on c.id =  d.form_id

--cda文书统计
--481-c出入量记录单   482-c出院评估与指导   483-c护理计划   484-c生命体征测量记录
--433-产前待产记录   431-分娩记录   403-内科护理记录单   437-外科护理记录单   278-首次护理记录单('432','278','429','434')
select dept.name 科室名称, doc.数量 from
(select ward_code,count(*) 数量 from MCS_DOC_FORM doc
where created_date >= to_date('2022-08-31 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and created_date < to_date('2022-09-01 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and template_code in ('481')
and is_valid = '1'
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
--出院病人人数
select dept.name 科室名称, doc.数量 出院人数 from
(select ward_code,count(*) 数量 from v_ewell_inpatient_info
where discharge_time > to_date('2022-08-08 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and discharge_time < to_date('2022-08-09 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and patient_id not like '%B%'
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code

--新开记出入量医嘱的人数
select dept.name 科室名称, doc.数量 from
(select ward_code,count(distinct admission_id) 数量 from v_ewell_inpatient_order2@his_db
where start_time > to_date('2022-08-08 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and start_time < to_date('2022-08-09 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and order_name like '%记出入量%'
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
--入院病人人数
select dept.name 科室名称, doc.数量 from
(select ward_code,count(*) 数量 from v_ewell_inpatient_info
where admission_ward_time >= to_date('2022-11-26', 'yyyy-mm-dd')
and admission_ward_time <= to_date('2022-12-31', 'yyyy-mm-dd')
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
where dept.name like '%感染%'
--现有记出入量人数
select dept.name 科室名称, doc.数量 from
(select ward_code,count(distinct admission_id) 数量 from v_ewell_inpatient_order2@his_db
where order_name like '%记出入量%'
and order_status = '在用'
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
--现有已写出入量单人数
select dept.name 科室名称, doc.数量 from
(select a.ward_code, count(distinct a.admission_id) 数量, 
case when (select patient_id from MCS_DOC_FORM where template_code = '481') is null then 0 else 1 end  aa
from v_ewell_inpatient_order2@his_db a left join MCS_DOC_FORM b on a.admission_id = b.mrn 
where a.order_name like '%记出入量%'
and a.order_status = '在用'
and b.created_date is not null
group by a.ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code



select * from v_ewell_inpatient_order2@his_db
where discharge_time > to_date('2022-07-10 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and discharge_time < to_date('2022-07-11 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and ward_name like '%肿瘤一%'
and 

--出院人数名单
select dept.name 科室名称, doc.* from
(select * from v_ewell_inpatient_info
where discharge_time > to_date('2022-07-17 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and discharge_time < to_date('2022-07-18 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and patient_id not like '%B%') doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
where dept.name like '%介入%'


select dept.name 科室名称, doc.* from
(select a.ward_code, a.admission_id
 from v_ewell_inpatient_order2@his_db a left join MCS_DOC_FORM b on a.admission = b.mrn
where a.order_status = '在用'
and a.order_name like '%记出入量%') doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code


select * from v_ewell_inpatient_order2@his_db a left join MCS_DOC_FORM b on a.admission_id = b.mrn
where a.order_status = '在用'
and a.order_name like '%记出入量%'
--and b.template_id = '481'
and b.created_date is null
order by start_time desc


select * from MCS_DOC_FORM doc
where created_date >= to_date('2022-07-24 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and created_date < to_date('2022-07-25 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and template_code in ('481')
and is_valid = '1'
and ward_code in ('38','0084')

select * from MCS_DOC_FORM doc
where bed_no in ('63','49')
and template_code in ('483')
and is_valid = '1'
and ward_code = '10'

select b.patient_id,b.patient_name,a.number_value,a.string_value
  from MCS_DOC_FORM_RECORDS a ,MCS_DOC_FORM b 
 where a.form_id =b.id
      and b.template_id = '555'
           and b.created_date >= to_date('2021-01-01', 'yyyy-mm-dd')
           and b.created_date < to_date('2022-01-01', 'yyyy-mm-dd')
   and a.node_code in ('35661', '35841')



select dept.name 科室名称 from
(select ward_code from mcs_order_schedule 
where plan_time > to_date('2019-01-01', 'yyyy-mm-dd')
and plan_time < to_date('2019-12-31', 'yyyy-mm-dd')
--and executed_time is not null
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code



select * from ca_sign_info

--执行表
select ward_name,count(*) from  mcs_transf_blood a
where sx_start_time > to_date('2022-05-01', 'yyyy-mm-dd')
and sx_start_time <=  to_date('2022-08-01', 'yyyy-mm-dd')
group by ward_name

select ward_name,count(*) from  mcs_


select * from  mcs_transf_blood a
where sx_start_time > to_date('2021-06-01', 'yyyy-mm-dd')
and sx_start_time <=  to_date('2022-09-01', 'yyyy-mm-dd')


select count(distinct c.lsh)
from
(select * from gdmch.zy_t_zyzd a join gdmch.zy_t_yz b on a.lsh = b.lsh
where (a.value like '%肠息肉%' or a.value like '%胃息肉%')
and b.itemname like '%禁食%'
and a.rq > to_date('2021-06-01', 'yyyy-mm-dd')
and a.rq <=  to_date('2022-09-01', 'yyyy-mm-dd')
and b.dept = '0043') c join 


select * from mcs_doc_template
where name like '%失禁相关性皮炎风险会阴评估工具（IAD）%'


select distinct mrn from MCS_DOC_FORM a
where created_date < to_date('2023-01-01','yyyy-mm-dd')
and a.template_code = '602'
and is_valid = '1'
--and ward_code != '48'


--患者流转数据
select a.*,rowid from mcs_scan_turninout a

--护理计划
select count(distinct mrn)
from MCS_NURSING_PLAN_DETAILS a
left join v_ewell_inpatient_info b on a.patient_id=b.patient_id and a.series=b.series
where  a.ward_code not in (select code from mcs_msys_dept_ward where name not like'%MH')--过滤民航院区数据
and   discharge_time>= TO_DATE('2022-7-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss') 
AND discharge_time<TO_DATE('2023-01-01', 'yyyy-MM-dd hh24:mi:ss')
AND a.is_valid=1


select (select count(distinct a.bar_code) from mcs_order_schedule a inner join MCS_ORDER_SCHEDULE_PROCESS b on a.bar_code = b.bar_code
where b.record_time is not null
and execute_time is not null
and plan_time >= TO_DATE('2022-7-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and plan_time < TO_DATE('2023-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and b.process_type = 'PREPARE'
and abs(b.record_time - a.execute_time)*24 < 1)/(select count(distinct a.bar_code) from mcs_order_schedule a join MCS_ORDER_SCHEDULE_PROCESS b on a.bar_code = b.bar_code
where plan_time is not null
and execute_time is not null
and plan_time >= TO_DATE('2022-7-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and plan_time < TO_DATE('2023-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and b.process_type = 'PREPARE') from dual


--VTE统计
select count(*) from pat_vte a left join v_ewell_inpatient_info b on (a.patient_id = b.patient_id and a.visit_id = b.series)
where b.ward_code = '29'
and a.assess_date >= TO_DATE('2023-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and a.assess_date < TO_DATE('2023-02-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and a.grade_info in ('中危','高危')

--文书表单记录
select a.string_value,b.patient_name,b.form_time from MCS_DOC_FORM_RECORDS a join MCS_DOC_FORM b on a.form_id = b.id
--and (string_value like '%胃肠息肉术后%低血糖%' or string_value like '%低血糖%胃肠息肉术后%')
where string_value like '%患者%'
and b.ward_code = '10'
and a.node_code = '23553'
and b.template_code = '437'
and b.form_time >= TO_DATE('2020-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and b.form_time < TO_DATE('2023-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')


select a.string_value,b.patient_name,b.form_time from MCS_DOC_FORM_RECORDS a join MCS_DOC_FORM b on a.form_id = b.id
where (string_value like '%胃肠息肉术后%低血糖%' or string_value like '%低血糖%胃肠息肉术后%')
and b.ward_code = '10'
and a.node_code = '23553'
and b.template_id = '437'
and b.form_time >= TO_DATE('2020-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and b.form_time < TO_DATE('2023-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')

select a.string_value,b.patient_name,b.form_time from MCS_DOC_FORM_RECORDS a join MCS_DOC_FORM b on a.form_id = b.id
where instr(string_value, '胃肠息肉') > 0
--and instr(string_value, '低血糖') > 0
and b.ward_code = '10'
and a.node_code in ('23553','20152')
and b.template_id in ('437','403')
and b.form_time >= TO_DATE('2020-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and b.form_time < TO_DATE('2023-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')

--每月全院住院患者营养风险筛查
select count(distinct mrn) 总例数 from MCS_DOC_FORM
where ward_code not in ('01','99')--排除ICU和胸壁外科
and form_time >= TO_DATE('2023-12-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and form_time < TO_DATE('2024-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and template_code = '592'
and is_valid = '1'
and total_score >= 3--是否阳性

select b.dept_name,count(distinct mrn) 总例数 from MCS_DOC_FORM a left join v_ewell_inpatient_info b on a.mrn = b.admission_id
where a.ward_code not in ('01','99')--排除ICU和胸壁外科
and form_time >= TO_DATE('2023-12-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and form_time < TO_DATE('2024-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and template_code = '592'
and is_valid = '1'
and total_score >= 3--是否阳性
and a.patient_id not like '%B%'
group by b.dept_name


select count(mrn) 人次数 from MCS_DOC_FORM
where ward_code not in ('01','99')--排除ICU和胸壁外科
and form_time >= TO_DATE('2023-12-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and form_time < TO_DATE('2024-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and template_code = '592'
and is_valid = '1'
and total_score >= 3--是否阳性


select b.dept_name,count(mrn) 人次数 from MCS_DOC_FORM a left join v_ewell_inpatient_info b on a.mrn = b.admission_id
where a.ward_code not in ('01','99')--排除ICU和胸壁外科
and form_time >= TO_DATE('2023-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and form_time < TO_DATE('2023-02-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and template_code = '592'
and is_valid = '1'
and total_score >= 3--是否阳性
group by b.dept_name

--在院人数（营养每月统计）
select dept_name,count(distinct a.admission_id) from v_ewell_inpatient_info a 
where admission_time < to_date('2023-09-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')--结束日期
and (discharge_time >= to_date('2023-08-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss') or discharge_time is null)--开始日期
and patient_id not like '%B%'
and dept_code not in ('99')
group by dept_name

--电子病历要的孕周和评分
select a.patient_id, a.patient_name,a.series, b.string_value, case when b.node_code = '22813' then '孕周' when b.node_code = '22961' then '评分' else '产次' end 类型 from MCS_DOC_FORM a left join MCS_DOC_FORM_RECORDS b on a.id = b.form_id
where a.template_code = '431'
and b.node_code in ('22813','22961','22812')
and a.created_date > sysdate -2

select t.*,rowid from MCS_MSYS_DEPT_WARD t
where code in (select a.code from MCS_MSYS_DEPT_WARD a left join gdmch.bc_t_bqbh@his_db b on a.code = b.bqbh
where a.name != b.bqmc)

select * from MCS_MSYS_DEPT_WARD a left join gdmch.bc_t_bqbh@his_db b on a.code = b.bqbh
where a.name != b.bqmc

--血氧数据
select a.id measure_sn,
c.sex_id,
c.age,
c.icd_id,
a.number_value 血氧饱和度
 from MCS_DOC_FORM_RECORDS a left join MCS_DOC_FORM b on a.form_id = b.id left join v_ewell_inpatient_info c on b.mrn = c.admission_id
where node_code in ('20128','23529','40278')
and (b.form_time - c.birthday)/364 > 60
and number_value is not null
and b.form_time >= TO_DATE('2021-09-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and b.form_time < TO_DATE('2022-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')


select count(*) 
FROM luna_mcs_gzey.mcs_order_schedule s 
left join luna_mcs_gzey.mcs_msys_dept_ward c on s.ward_code=c.code
WHERE plan_time>= TO_DATE('2023-06-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss') 
AND plan_time<= TO_DATE('2023-08-31 23:59:59', 'yyyy-MM-dd hh24:mi:ss')
and s.order_class in ('a', 'b')
and s.ward_code <>'01'
and c.name not like'%MH'
and s.execute_time is not null

select b.order_name,a.* from MCS_ORDER_SCHEDULE_PROCESS a left join mcs_order_schedule b on a.bar_code = b.bar_code
where a.patient_id = '604878'
and a.record_time > to_date('2022-09-17', 'yyyy-mm-dd')
and a.record_time < to_date('2022-09-19', 'yyyy-mm-dd')
