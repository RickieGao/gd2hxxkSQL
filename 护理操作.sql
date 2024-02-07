--�������
--�����ֵ�
select a.*,rowid from MCS_MSYS_DEPT_WARD a
--where abb = '3'
where name like '%����%'
where code in ('92')

select a.*,rowid from mcs_sys_user_wards a
where user_id in (select id from mcs_sys_users where user_code in (
'0350'))

update mcs_sys_users
set user_type = 'NURSE'
WHERE user_type is null

select * from mcs_sys_users
where user_type is null
---------------------------------------------------��ʿȨ�޷���---------------------------------------------------
--���ݹ�����������û�
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

--���ݿ��ҷ���Ȩ��
insert into mcs_sys_user_wards
select id,
'55'--����Ȩ�޲���
from mcs_sys_users
where user_code in 
(select lsh from gdmch.rl_t_ygk@his_db where 
ksbm='0338'--������Ȩ�޿���
and nvl(zwdm,'δ��ְ��') in 
('4053',--��ʦ
'4013',--�����λ�ʦ
'4033',--���ܻ�ʦ
'4062',--��ʿ
'4097'--����ʿ
) and lsh in 
(select yhbm from gdmch.zt_t_user@his_db where yhmm is not null and yhzt='1' and (jslb is not null or mklb is not null)))

--ͬ��his��ʿ����վȨ��
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

--���ݿ���ɾ�����ض��������Ȩ��
delete from mcs_sys_user_wards
where user_id in (select id from mcs_sys_users where user_code in 
(select lsh from gdmch.rl_t_ygk@his_db where 
ksbm='0045'--������Ȩ�޿���
and nvl(zwdm,'δ��ְ��') in 
('4053',--��ʦ
'4013',--�����λ�ʦ
'4033',--���ܻ�ʦ
'4062',--��ʿ
'4097'--����ʿ
) and lsh in 
(select yhbm from gdmch.zt_t_user@his_db where yhmm is not null and yhzt='1' and (jslb is not null or mklb is not null))))
and ward_code not in ('04','9N')


--ɾ��������ظ�����
delete from mcs_sys_user_wards where (user_id,ward_code) in (select user_id,ward_code from mcs_sys_user_wards a
group by user_id,ward_code having count(*)>1)
and rowid not in
(select max(rowid) from mcs_sys_user_wards a
group by user_id,ward_code having count(*)>1)

select count(*) from mcs_sys_user_wards a
group by user_id,ward_code having count(*)>1

select count(*) from mcs_sys_user_wards a

--���ݹ��ŷ���Ȩ��
insert into mcs_sys_user_wards
select id,
('57')--����Ȩ�޲���
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

--���ݹ��ſ���ca
update mcs_sys_users a
set a.isopen_ca = 1
where user_code in 
('Q205'
)

select a.*,rowid from mcs_sys_users a
where user_code in 
('T967','T742','S175','R721','T987','S096','S091','R219','R483'
)

--���ݹ��ŷ���ȫԺ����Ȩ��
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
--���ݹ���ɾ��Ȩ��
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

--ɾ�������˵ĸò���Ȩ��
delete from mcs_sys_user_wards
where ward_code in ('72','80','79','73','74','75','76','77','78','67','66','65','64','63','62','61','60','53','54','55','71','70','69')

--������������Ȩ��
insert into mcs_sys_user_wards
select id,
('74')--����Ȩ�޲���
from mcs_sys_users
where user_name in 
('������','������','�����','��Ӿ��','����','Ԭ��','������','������','������','��С��','��ѩ��','���෼','���ɷ�','�����',
'������','���ǵ�','����','�����','������','л��','����','����Զ','������')

--�����������Ȩ�޵������˷�����һ������Ȩ��
insert into mcs_sys_user_wards
select user_id,'9P' from mcs_sys_user_wards
where ward_code = '15'

--�����ض����ҵ����л�ʿ
select xm,ksmc from gdmch.rl_t_ygk@his_db a left join gdmch.rl_t_keshiku@his_db b on b.ksbm = a.ksbm 
where ksmc like '%MH%'
and nvl(zwdm,'δ��ְ��') in 
('4053',--��ʦ
'4013',--�����λ�ʦ
'4033',--���ܻ�ʦ
'4062',--��ʿ
'4097'--����ʿ
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

--��û�н�ɫ���û�������ͨ��ʿ��ɫ
insert into mcs_sys_user_roles
select id,'4' from mcs_sys_users
where id not in (select distinct user_id from mcs_sys_user_roles)

--����ȡ���鵵
update mcs_archived_patient a
set status = '0'
where patient_id in (
'566133'
)

--���߹鵵
select rowid,a.* from mcs_archived_patient a
where patient_id='700000'
-------------------------------------------------ͳ��------------------------------------
--��ѪѲ��ÿ��ͳ��
select h.name ����,g.ɨ��ִ������,nvl(g.��Ѳ��,0) ��Ѳ��,nvl(g.Ѳ��ʱ��Ϲ�,0) Ѳ��ʱ��Ϲ�,nvl(g.��ɨ����,0) ��ɨ���� from
(select c.ward_code,c.sum ɨ��ִ������,d.sum ��Ѳ��,e.sum Ѳ��ʱ��Ϲ�,f.sum ��ɨ���� from 
(select count(a.ward_code) sum,ward_code from mcs_transf_blood a
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
group by ward_code) c
left join
(select count(distinct(b.blood_pack_no)) sum,ward_code from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
and b.process_type = 'PATROL'
group by ward_code) d on c.ward_code = d.ward_code
left join
(select count(distinct(b.blood_pack_no)) sum,ward_code from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
and b.process_type = 'PATROL'
and (b.record_time - a.sx_start_time)*24*60 >= 5
and (b.record_time - a.sx_start_time)*24*60 <= 35
group by ward_code) e on c.ward_code = e.ward_code
left join
(select count(a.ward_code) sum,ward_code from mcs_transf_blood a
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
and sx_end_time is not null
group by ward_code) f on c.ward_code = f.ward_code
) g left join MCS_MSYS_DEPT_WARD h on g.ward_code = h.code

--�����������ɨ��ͳ��
select t.ward_name ��������, count(distinct order_no) ��������,nvl(sum(out_flag),0) ������ɨ����,count(distinct order_no)-nvl(sum(out_flag),0) ������δɨ��,nvl(sum(return_flag),0) �ز���ɨ����,count(distinct order_no)-nvl(sum(return_flag),0) �ز���δɨ�� from
(select b.ward_name,a.order_no,case c.type when 5 then 1 end out_flag, case c.type when 10 then 1 end return_flag
from gdmch.v_ewell_operation@his_db a left join v_ewell_inpatient_info b on a.patient_no = b.admission_id left join mcs_scan_turninout c on a.order_no = c.order_no
where a.start_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.end_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and b.ward_name not like '%MH%'
and b.ward_name not like '%ICU%'
and a.operation_type not like '%����%'
and a.ss_type = '����'
and a.sss in ('1','2')
--and b.ward_name like '%ȫ��%'
) t
group by ward_name

--���������©ɨ����
select * from gdmch.v_ewell_operation@his_db a left join v_ewell_inpatient_info b on a.patient_no = b.admission_id 
where a.start_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.end_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and b.ward_name like '%�ռ�%'
and b.ward_name not like '%MH%'
and a.operation_type not like '%����%'
and a.ss_type = '����'
and a.sss in ('1','2')
and order_no not in (select order_no from mcs_scan_turninout
where order_no in (select order_no from gdmch.v_ewell_operation@his_db a left join v_ewell_inpatient_info b on a.patient_no = b.admission_id 
where a.start_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.end_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.operation_type not like '%����%'
and a.ss_type = '����'
and a.sss in ('1','2')
and b.ward_name like '%�ռ�%'
and b.ward_name not like '%MH%')
and type in ('5') --����
--and type in ('10') --�ؿ�
)

select * from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
and b.process_type = 'PATROL'
and ((b.record_time - a.sx_start_time)*24*60 > 30
or (b.record_time - a.sx_start_time)*24*60 < 10)
and ward_code in ('19')
and a.pack_no in ('441202303549051')
--group by ward_code

select * from v_ewell_blood_yh a
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
and ward_code like ('%�����ǿ�%')
and pack_no not in (select pack_no from mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
and b.process_type = 'PATROL'
--and b.process_type = 'FINISHED'
and ward_code in ('56'))

--��ѪѲ��ÿ��ͳ��
select c.name ����,j.sum �ƻ�ɨ��ִ��,nvl(i.ɨ��ִ������,0) ʵ��ɨ��ִ��,nvl(i.��Ѳ��,0) ��Ѳ��,nvl(i.Ѳ��ʱ��Ϲ�,0) Ѳ��ʱ��Ϲ�,nvl(i.��ɨ����,0) ��ɨ���� from 
(select count(distinct b.pack_no) sum,b.ward_code from v_ewell_blood_yh b
where b.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and b.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and b.blood_name not like '%�����%'
and b.blood_name not like '%�ֹ���%'
and ward_code not like '%MH%'
and ward_code != 'ICU'
group by ward_code
) j left join
(
select h.name,g.ɨ��ִ������,g.��Ѳ��,g.Ѳ��ʱ��Ϲ�,g.��ɨ���� from
(select c.ward_code,c.sum ɨ��ִ������,d.sum ��Ѳ��,e.sum Ѳ��ʱ��Ϲ�,f.sum ��ɨ���� from 
(select count(a.ward_code) sum,ward_code from mcs_transf_blood a
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
group by ward_code) c
left join
(select count(distinct(b.blood_pack_no)) sum,ward_code from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
and b.process_type = 'PATROL'
group by ward_code) d on c.ward_code = d.ward_code
left join
(select count(distinct(b.blood_pack_no)) sum,ward_code from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
and b.process_type = 'PATROL'
and (b.record_time - a.sx_start_time)*24*60 >= 10
and (b.record_time - a.sx_start_time)*24 <= 2
group by ward_code) e on c.ward_code = e.ward_code
left join
(select count(a.ward_code) sum,ward_code from mcs_transf_blood a
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
and sx_end_time is not null
group by ward_code) f on c.ward_code = f.ward_code
) g left join MCS_MSYS_DEPT_WARD h on g.ward_code = h.code
) i on i.���� = j.ward_code

select * from mcs_blood_patrol_info
where blood_pack_no in ('440112215945355E5441000','440112217684355D6073000','440112217624055D6073000')

--��Ѫ�걾�ɼ�ͳ��
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
and b.ward_name like '%�ڷ���%'


select * from mcs_scan_turninout
where order_no in (select order_no from gdmch.v_ewell_operation@his_db a left join v_ewell_inpatient_info b on a.patient_no = b.admission_id 
where a.start_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.end_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and b.ward_name like '%�ڷ���%')
and type in ('10','5')




select count(distinct order_no) ��������,nvl(sum(out_flag),0) ������ɨ����,nvl(sum(return_flag),0) �ز���ɨ���� from
(select b.ward_name,a.order_no,case c.type when 5 then 1 end out_flag, case c.type when 10 then 1 end return_flag
from gdmch.v_ewell_operation@his_db a left join v_ewell_inpatient_info b on a.patient_no = b.admission_id left join mcs_scan_turninout c on a.order_no = c.order_no
where a.start_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.end_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and b.ward_name not like '%MH%'
and b.ward_name not like '%ICU%'
and b.ward_name like '%�ڷ���%'
)


--��Ѫ�����������ʱ���ͳ��
select a.time ʱ��, a.num ��Ѫ����,b.num ��Ѫɨ��ִ������,c.num ��ѪѲ������,d.num ��ѪѲ��ʱ��Ϲ�����,e.num ��Ѫɨ�������� from 
(select substr(to_char(plan_time),1,5) time,count(distinct pack_no) num from v_ewell_blood_yh
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and blood_name not like '%�����%'
and blood_name not like '%�ֹ���%'
group by substr(to_char(plan_time),1,5)) a join 
(select substr(to_char(plan_time),1,5) time,count(distinct pack_no) num from mcs_transf_blood
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and blood_name not like '%�����%'
and blood_name not like '%�ֹ���%'
group by substr(to_char(plan_time),1,5)
) b on a.time = b.time join
(select substr(to_char(record_time),1,5) time,count(distinct a.pack_no) num from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
and b.process_type = 'PATROL'
group by substr(to_char(record_time),1,5)
) c on a.time = c.time join
(select substr(to_char(record_time),1,5) time,count(b.blood_pack_no) num from
mcs_transf_blood a left join mcs_blood_patrol_info b on a.pack_no = b.blood_pack_no and a.patient_id = b.patient_id and a.mrn = b.mrn
where a.plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and a.plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and a.blood_name not like '%�����%'
and a.blood_name not like '%�ֹ���%'
and b.process_type = 'PATROL'
and (b.record_time - a.sx_start_time)*24*60 >= 10
and (b.record_time - a.sx_start_time)*24 <= 2
group by substr(to_char(record_time),1,5)
) d on a.time = d.time join
(select substr(to_char(plan_time),1,5) time,count(distinct pack_no) num from mcs_transf_blood
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and blood_name not like '%�����%'
and blood_name not like '%�ֹ���%'
and sx_end_time is not null
group by substr(to_char(plan_time),1,5)
) e on a.time = e.time

--������ת����
select count(*) from mcs_scan_turninout a
where record_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and record_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
where type in ('5','10')

-------------------------------------------------��������ͳ��------------------------------------
--��ʿPDA������ͳ��
select b.user_name ����,b.user_code ����,count(distinct a.id) pdaɨ���� from MCS_ORDER_SCHEDULE_PROCESS a left join mcs_sys_users b on a.recorder_id = b.id
where b.user_code = '0369'
and record_time >= to_date('2020-05-01', 'yyyy-mm-dd')
and record_time < to_date('2022-12-31', 'yyyy-mm-dd')
group by b.user_name,b.user_code
--��ʿPDA������ͳ�ƣ�����ݣ�
select b.user_name ����,b.user_code ����,extract(year from record_time) ���,count(distinct a.id) pdaɨ���� from MCS_ORDER_SCHEDULE_PROCESS a left join mcs_sys_users b on a.recorder_id = b.id
where b.user_name = '�ܽ�Ⱥ'
and record_time >= to_date('2019-09-01', 'yyyy-mm-dd')
and record_time < to_date('2019-12-31', 'yyyy-mm-dd') + 1
group by b.user_name,b.user_code,extract(year from record_time) 

select b.user_name ����,b.user_code ����,count(distinct a.id) pdaɨ���� from MCS_ORDER_SCHEDULE_PROCESS a left join mcs_sys_users b on a.recorder_id = b.id
where b.user_name = '��Ӣ'
and record_time >= to_date('2021-01-01', 'yyyy-mm-dd')
and record_time < to_date('2021-12-31', 'yyyy-mm-dd')
group by b.user_name,b.user_code
--����ڵ�ͳ��
select * from MCS_DOC_FORM a right join MCS_DOC_FORM_RECORDS b on a.id = b.form_id
where a.template_code = '378'
and a.is_valid = '1'
and b.node_code = '17965'
and b.string = '����'

select extract(year from form_time),count(*) from MCS_DOC_FORM_RECORDS a left join MCS_DOC_FORM b on b.id = a.form_id
where node_code in ('13560','26837','26838','30504')
and string_value like '%������%'
group by extract(year from form_time)

select extract(year from form_time),count(distinct b.mrn) from MCS_DOC_FORM_RECORDS a left join MCS_DOC_FORM b on b.id = a.form_id
where node_code in ('13560','26837','26838','30504')
and string_value like '%������%'
group by extract(year from form_time)
--
--��ʿ����ǩ��ͳ��
select * from ca_sign_info
order by sign_date desc

select '��Ӣ' ����,'0369' ����,extract(year from sign_date) ���,count(*) ��������ǩ������ from ca_sign_info 
where instr(original_sign_data,'��Ӣ|0369')>=1
and sign_date >= to_date('2022-01-01', 'yyyy-mm-dd')
and sign_date < to_date('2022-12-31', 'yyyy-mm-dd') + 1
group by extract(year from sign_date)
--�������ǩ���Ĳ���
select '������' ����,'8671' ����,extract(year from sign_date) ���,count(distinct b.mrn) ��ǩ���Ĳ��������� from ca_sign_info a left join MCS_DOC_FORM b on a.form_id = b.id
where instr(original_sign_data,'������|8671')>=1
and sign_date >= to_date('2000-01-01', 'yyyy-mm-dd')
--and sign_date < to_date('2022-12-31', 'yyyy-mm-dd') + 1
group by extract(year from sign_date)
--�������鴴��ͳ��
select created_by ����,extract(year from created_date) ���,count(*) �������鴴������ from MCS_DOC_FORM
where created_by = '0526'
and is_valid = 1
and created_date >= to_date('2015-01-01', 'yyyy-mm-dd')
and created_date < to_date('2022-12-31', 'yyyy-mm-dd')
group by created_by,extract(year from created_date)

select extract(year from created_date) ���,count(distinct mrn) �������鴴�����޸����� from MCS_DOC_FORM
where (created_by = '0526' or last_updated_by = '0526')
and is_valid = 1
and created_date >= to_date('2015-01-01', 'yyyy-mm-dd')
and created_date < to_date('2022-12-31', 'yyyy-mm-dd')
group by extract(year from created_date)
--��Ժ����
select dept.name ��������, doc.���� ��Ժ���� from
(select ward_code,count(*) ���� from v_ewell_inpatient_info
where admission_ward_time < to_date('2023-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')--��������
and (discharge_time >= to_date('2022-11-26 00:00:00', 'yyyy-mm-dd hh24:mi:ss') or discharge_time is null)--��ʼ����
and patient_id not like '%B%'
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
where dept.name like '%2-8%'

select dept.name ��������,doc.years ���, doc.���� ��Ժ���� from
(select ward_code,extract(year from admission_ward_time) years,count(*) ���� from v_ewell_inpatient_info
where admission_ward_time < to_date('2023-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')--��������
and (discharge_time >= to_date('2016-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss') or discharge_time is null)--��ʼ����
and patient_id not like '%B%'
group by ward_code,extract(year from admission_ward_time)) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
where dept.name like '%�ؽ�%'

--��Ժ��Ա�б�
select patient_id סԺ��,admission_id ��ˮ��,name ����,sex �Ա�,dept_name ����,ward_name ����,bed_no ����,age ����,admission_time ��Ժʱ��,discharge_time ��Ժʱ�� from v_ewell_inpatient_info
where admission_time < to_date('2022-12-07 00:00:00', 'yyyy-mm-dd hh24:mi:ss') + 1--��������
and (discharge_time >= to_date('2022-11-28 00:00:00', 'yyyy-mm-dd hh24:mi:ss') or discharge_time is null)--��ʼ����
and patient_id not like '%B%'
and ward_code in ('77')
--����Ժ��Ա����
select patient_id סԺ��,admission_id ��ˮ��,name ����,sex �Ա�,dept_name ����,ward_name ����,bed_no ����,age ����,admission_time ��Ժʱ��,discharge_time ��Ժʱ�� from v_ewell_inpatient_info
where admission_time < to_date('2022-11-15 00:00:00', 'yyyy-mm-dd hh24:mi:ss') + 1--��������
and admission_time > to_date('2022-11-08 00:00:00', 'yyyy-mm-dd hh24:mi:ss')
and patient_id not like '%B%'
and ward_code in ('0A','0B','0C','0D','0E','0F','0G','0H','0J','0K','0L','0M')
------------------------------------------------------------------
--��Һ���ͳ��
select b.name ����,count(*) ����,sum(exe_flag) ִ���� from
(select ward_code,case when (execute_time is null) then 0 else 1 end exe_flag from mcs_order_schedule
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and supply_name = '������ע') a left join MCS_MSYS_DEPT_WARD b on a.ward_code = b.code
group by b.name
--��ҺȫԺ�������
select count(*) ��Һ����,sum(exe_flag) ִ����,sum(exe_flag)/count(*) ִ����  from
(select ward_code,case when (execute_time is null) then 0 else 1 end exe_flag from mcs_order_schedule
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and supply_name = '������ע'
and ward_code != '01')

--�ڷ�ҩ���ͳ��
select b.name ����,count(*) ����,sum(exe_flag) ִ����,sum(exe_flag)/count(*) ִ���� from
(select ward_code,case when (execute_time is null) then 0 else 1 end exe_flag from mcs_order_schedule
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and supply_name = '�ڷ�'
and bar_code  like '%inp%'
) a left join MCS_MSYS_DEPT_WARD b on a.ward_code = b.code
group by b.name

--�ڷ�ҩȫԺ�������
select count(*) �ڷ�ҩ����,sum(exe_flag) ִ����,sum(exe_flag)/count(*) ִ����  from
(select ward_code,case when (execute_time is null) then 0 else 1 end exe_flag from mcs_order_schedule
where plan_time > to_date(&kssj, 'yyyy-mm-dd hh24:mi:ss')
and plan_time < to_date(&jssj, 'yyyy-mm-dd hh24:mi:ss')
and supply_name = '�ڷ�'
and ward_code != '01')

--cda�ĵ����
--481-c��������¼��   482-c��Ժ������ָ��   483-c����ƻ�   484-c��������������¼
--433-��ǰ������¼   431-�����¼   403-�ڿƻ����¼��   437-��ƻ����¼��   278-�״λ����¼��
select * from MCS_DOC_FORM
where created_date > Sysdate - 1
and template_code = '481'
--Ӫ������ɸ��ͳ��
select count(distinct mrn) from Mcs_Doc_Form
where created_date > to_date('2021-01-01', 'yyyy-mm-dd')
and created_date < to_date('2022-01-01', 'yyyy-mm-dd')
and template_code = '476'
and total_score >= '3'



--ca��ͼ
select c.id,c.patient_id,c.patient_name,c.bed_no,c.form_time,c.nurse_name,c.display_name,d.sign_data,d.time_data,d.cert_sn
from
(select a.id,a.patient_id,a.patient_name,a.bed_no,a.form_time,a.created_name nurse_name,b.display_name from MCS_DOC_FORM a left join MCS_DOC_MENU b on a.template_code = b.template_code
where a.patient_id = '602195'
and a.template_code = '403'
and b.seq = '10'
and a.form_time < to_date('2022-08-14 10:00:00', 'yyyy-mm-dd hh24:mi:ss')) c
left join ca_sign_info d on c.id =  d.form_id

--cda����ͳ��
--481-c��������¼��   482-c��Ժ������ָ��   483-c����ƻ�   484-c��������������¼
--433-��ǰ������¼   431-�����¼   403-�ڿƻ����¼��   437-��ƻ����¼��   278-�״λ����¼��('432','278','429','434')
select dept.name ��������, doc.���� from
(select ward_code,count(*) ���� from MCS_DOC_FORM doc
where created_date >= to_date('2022-08-31 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and created_date < to_date('2022-09-01 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and template_code in ('481')
and is_valid = '1'
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
--��Ժ��������
select dept.name ��������, doc.���� ��Ժ���� from
(select ward_code,count(*) ���� from v_ewell_inpatient_info
where discharge_time > to_date('2022-08-08 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and discharge_time < to_date('2022-08-09 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and patient_id not like '%B%'
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code

--�¿��ǳ�����ҽ��������
select dept.name ��������, doc.���� from
(select ward_code,count(distinct admission_id) ���� from v_ewell_inpatient_order2@his_db
where start_time > to_date('2022-08-08 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and start_time < to_date('2022-08-09 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and order_name like '%�ǳ�����%'
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
--��Ժ��������
select dept.name ��������, doc.���� from
(select ward_code,count(*) ���� from v_ewell_inpatient_info
where admission_ward_time >= to_date('2022-11-26', 'yyyy-mm-dd')
and admission_ward_time <= to_date('2022-12-31', 'yyyy-mm-dd')
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
where dept.name like '%��Ⱦ%'
--���мǳ���������
select dept.name ��������, doc.���� from
(select ward_code,count(distinct admission_id) ���� from v_ewell_inpatient_order2@his_db
where order_name like '%�ǳ�����%'
and order_status = '����'
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
--������д������������
select dept.name ��������, doc.���� from
(select a.ward_code, count(distinct a.admission_id) ����, 
case when (select patient_id from MCS_DOC_FORM where template_code = '481') is null then 0 else 1 end  aa
from v_ewell_inpatient_order2@his_db a left join MCS_DOC_FORM b on a.admission_id = b.mrn 
where a.order_name like '%�ǳ�����%'
and a.order_status = '����'
and b.created_date is not null
group by a.ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code



select * from v_ewell_inpatient_order2@his_db
where discharge_time > to_date('2022-07-10 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and discharge_time < to_date('2022-07-11 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and ward_name like '%����һ%'
and 

--��Ժ��������
select dept.name ��������, doc.* from
(select * from v_ewell_inpatient_info
where discharge_time > to_date('2022-07-17 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and discharge_time < to_date('2022-07-18 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
and patient_id not like '%B%') doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code
where dept.name like '%����%'


select dept.name ��������, doc.* from
(select a.ward_code, a.admission_id
 from v_ewell_inpatient_order2@his_db a left join MCS_DOC_FORM b on a.admission = b.mrn
where a.order_status = '����'
and a.order_name like '%�ǳ�����%') doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code


select * from v_ewell_inpatient_order2@his_db a left join MCS_DOC_FORM b on a.admission_id = b.mrn
where a.order_status = '����'
and a.order_name like '%�ǳ�����%'
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



select dept.name �������� from
(select ward_code from mcs_order_schedule 
where plan_time > to_date('2019-01-01', 'yyyy-mm-dd')
and plan_time < to_date('2019-12-31', 'yyyy-mm-dd')
--and executed_time is not null
group by ward_code) doc
left join MCS_MSYS_DEPT_WARD dept on doc.ward_code = dept.code



select * from ca_sign_info

--ִ�б�
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
where (a.value like '%��Ϣ��%' or a.value like '%θϢ��%')
and b.itemname like '%��ʳ%'
and a.rq > to_date('2021-06-01', 'yyyy-mm-dd')
and a.rq <=  to_date('2022-09-01', 'yyyy-mm-dd')
and b.dept = '0043') c join 


select * from mcs_doc_template
where name like '%ʧ�������Ƥ�׷��ջ����������ߣ�IAD��%'


select distinct mrn from MCS_DOC_FORM a
where created_date < to_date('2023-01-01','yyyy-mm-dd')
and a.template_code = '602'
and is_valid = '1'
--and ward_code != '48'


--������ת����
select a.*,rowid from mcs_scan_turninout a

--����ƻ�
select count(distinct mrn)
from MCS_NURSING_PLAN_DETAILS a
left join v_ewell_inpatient_info b on a.patient_id=b.patient_id and a.series=b.series
where  a.ward_code not in (select code from mcs_msys_dept_ward where name not like'%MH')--������Ժ������
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


--VTEͳ��
select count(*) from pat_vte a left join v_ewell_inpatient_info b on (a.patient_id = b.patient_id and a.visit_id = b.series)
where b.ward_code = '29'
and a.assess_date >= TO_DATE('2023-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and a.assess_date < TO_DATE('2023-02-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and a.grade_info in ('��Σ','��Σ')

--�������¼
select a.string_value,b.patient_name,b.form_time from MCS_DOC_FORM_RECORDS a join MCS_DOC_FORM b on a.form_id = b.id
--and (string_value like '%θ��Ϣ������%��Ѫ��%' or string_value like '%��Ѫ��%θ��Ϣ������%')
where string_value like '%����%'
and b.ward_code = '10'
and a.node_code = '23553'
and b.template_code = '437'
and b.form_time >= TO_DATE('2020-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and b.form_time < TO_DATE('2023-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')


select a.string_value,b.patient_name,b.form_time from MCS_DOC_FORM_RECORDS a join MCS_DOC_FORM b on a.form_id = b.id
where (string_value like '%θ��Ϣ������%��Ѫ��%' or string_value like '%��Ѫ��%θ��Ϣ������%')
and b.ward_code = '10'
and a.node_code = '23553'
and b.template_id = '437'
and b.form_time >= TO_DATE('2020-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and b.form_time < TO_DATE('2023-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')

select a.string_value,b.patient_name,b.form_time from MCS_DOC_FORM_RECORDS a join MCS_DOC_FORM b on a.form_id = b.id
where instr(string_value, 'θ��Ϣ��') > 0
--and instr(string_value, '��Ѫ��') > 0
and b.ward_code = '10'
and a.node_code in ('23553','20152')
and b.template_id in ('437','403')
and b.form_time >= TO_DATE('2020-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and b.form_time < TO_DATE('2023-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')

--ÿ��ȫԺסԺ����Ӫ������ɸ��
select count(distinct mrn) ������ from MCS_DOC_FORM
where ward_code not in ('01','99')--�ų�ICU���ر����
and form_time >= TO_DATE('2023-12-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and form_time < TO_DATE('2024-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and template_code = '592'
and is_valid = '1'
and total_score >= 3--�Ƿ�����

select b.dept_name,count(distinct mrn) ������ from MCS_DOC_FORM a left join v_ewell_inpatient_info b on a.mrn = b.admission_id
where a.ward_code not in ('01','99')--�ų�ICU���ر����
and form_time >= TO_DATE('2023-12-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and form_time < TO_DATE('2024-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and template_code = '592'
and is_valid = '1'
and total_score >= 3--�Ƿ�����
and a.patient_id not like '%B%'
group by b.dept_name


select count(mrn) �˴��� from MCS_DOC_FORM
where ward_code not in ('01','99')--�ų�ICU���ر����
and form_time >= TO_DATE('2023-12-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and form_time < TO_DATE('2024-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and template_code = '592'
and is_valid = '1'
and total_score >= 3--�Ƿ�����


select b.dept_name,count(mrn) �˴��� from MCS_DOC_FORM a left join v_ewell_inpatient_info b on a.mrn = b.admission_id
where a.ward_code not in ('01','99')--�ų�ICU���ر����
and form_time >= TO_DATE('2023-01-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and form_time < TO_DATE('2023-02-01 00:00:00', 'yyyy-MM-dd hh24:mi:ss')
and template_code = '592'
and is_valid = '1'
and total_score >= 3--�Ƿ�����
group by b.dept_name

--��Ժ������Ӫ��ÿ��ͳ�ƣ�
select dept_name,count(distinct a.admission_id) from v_ewell_inpatient_info a 
where admission_time < to_date('2023-09-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')--��������
and (discharge_time >= to_date('2023-08-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss') or discharge_time is null)--��ʼ����
and patient_id not like '%B%'
and dept_code not in ('99')
group by dept_name

--���Ӳ���Ҫ�����ܺ�����
select a.patient_id, a.patient_name,a.series, b.string_value, case when b.node_code = '22813' then '����' when b.node_code = '22961' then '����' else '����' end ���� from MCS_DOC_FORM a left join MCS_DOC_FORM_RECORDS b on a.id = b.form_id
where a.template_code = '431'
and b.node_code in ('22813','22961','22812')
and a.created_date > sysdate -2

select t.*,rowid from MCS_MSYS_DEPT_WARD t
where code in (select a.code from MCS_MSYS_DEPT_WARD a left join gdmch.bc_t_bqbh@his_db b on a.code = b.bqbh
where a.name != b.bqmc)

select * from MCS_MSYS_DEPT_WARD a left join gdmch.bc_t_bqbh@his_db b on a.code = b.bqbh
where a.name != b.bqmc

--Ѫ������
select a.id measure_sn,
c.sex_id,
c.age,
c.icd_id,
a.number_value Ѫ�����Ͷ�
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
