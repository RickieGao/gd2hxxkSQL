--���߻�����Ϣ
select a.*,rowid from v_ewell_inpatient_info a
--where dept_name = '�ؽڹǿƶ���'
--and status = 'סԺ'
--and bed_no in ('136','137')
--order by admission_time desc
--where id_card = '440111196606193657'
where patient_id like '670514%'
where admission_id = '2024-07262'
where name = '���Ľ�'

--his����
select * from v_ewell_inpatient_info@his_db
where  patient_id = '273277'

--��סԺ��ִ�й��̣�1.ƽ̨����ȷ��Ϣ��2.ִ�������ִ�й��̣�3.ɾ��v_ewell_inpatient_info������ľɵ���Ϣ��4.������������Ļ���ȼ�ҽ��gdmch.zy_t_yz����v_ewell_inpatient_info�����滤��ȼ��ֶ�nursing_class
BEGIN
  V_MODIFY_PATIENT(NOW_PATIENT =>'269233',--����סԺ��
                   MRN => '2024-07262',--������ˮ��
                   NOW_SERIES =>2,--����סԺ����
                   NEW_PATIENT =>'480440',--��סԺ��
                   NEW_SERIES =>10);--��סԺ����
                   COMMIT;
END;
---------------------------------------------------ҽ�����----------------------------------------------
--his ԭʼ����
select * from v_ewell_inpatient_order2@his_db
where admission_id = '2024-07262'
and admission_id = '2024-07262'
--and order_no = '20240115436369'
and order_name like '%������ֽ���%'
--and inject_group = 'C-3'
and order_status = '����'

--his ҽ����ϸ
select * from v_ewell_inpatient_order3@his_db
where patient_id = '269233'
and inject_group = '1-3'
--and plan_time > to_date('2022-04-29', 'yyyy-mm-dd')
--and plan_time < to_date('2022-04-30', 'yyyy-mm-dd')
and order_name like '%ע���ø�ɳƥ̹˫%'
where order_no = '20231130392508'
--where xmbm = '1132000180'
order by start_time desc

--ҽ��ִ�мƻ�
select a.*, rowid from mcs_order_schedule a
where patient_id = '604878'
--and his_order_id= '20231229055959'
--where bar_code like '02239792606%'
--and inject_group = '1-3'
--where bar_code = '02239797397'
--and mrn = '2022-35842'
--and id = '9f34e293-5c25-4ba1-85e9-33f86a590daf'
and plan_time > to_date('2022-09-18', 'yyyy-mm-dd')
and plan_time < to_date('2022-09-19', 'yyyy-mm-dd')
--and supply_name = '������ע'
--and order_class = 'a'
and order_name like '%������ֽ���%'
order by plan_time desc

--ҽ��ִ�мƻ�_���̼�¼
select a.*,a.rowid from MCS_ORDER_SCHEDULE_PROCESS a
where patient_id = '604878'
and record_time > to_date('2022-09-18', 'yyyy-mm-dd')
and record_time < to_date('2022-09-19', 'yyyy-mm-dd')
--and series = '12'
where bar_code = '02230227161'
where record_time > sysdate -1

select * from MCS_ORDER_SCHEDULE_PROCESS a
where bar_code in (select bar_code from mcs_order_schedule a where his_order_id= '20230121742099')

--��ǩ��ӡʱ��
select * from mcs_order_schedule_print
where bar_code = 'inp_12023-7539612240523022023-7539620231028160000'
--����ҽ����Ų��ǩ��ӡʱ��
select * from mcs_order_schedule_print a
where bar_code in (select bar_code from mcs_order_schedule a where his_order_id= '20230121742099')

--����ҩ��
select * from mcs_order_detail
where group_no = '20230121742099'
where admission_id = '2022-54972'

--�걾�ɼ�ɨ��
select * from mcs_order_schedule
where apply_no = 'R2238893095'
--plan_time>=trunc(sysdate -2)
and patient_id = '609863'
--and his_order_id = '20220915907740'
--and plan_time>=trunc(sysdate -2)
and bar_code like '0222%'
and order_name like '%��������%'

--�걾�ɼ���ͼ
select * from gdmch.v_ewell_inpatient_lis_order_al@his_db
where patient_id = '601684'
and item_name like '%����%'

--lis��ͼ
select * from gdmch.v_ewell_inpatient_lis_order@his_db a
where a.start_date>trunc(sysdate)

--��ѯ����������е�����
select rowid,b.* from mcs_order_schedule b
where plan_time>=trunc(sysdate)
and (bar_code like '%'||chr(39)||'%' or bar_code like '%;||chr(39)||;%' )

--ҽ����ҩ����_�÷�MCS_ORDER_PROCESS_DEF
select * from MCS_ORDER_PROCESS_DEF
--ҽ����ҩ����_������MCS_ORDER_PROCESS_ITEM
select * from MCS_ORDER_PROCESS_ITEM
--ҽ����ҩ����_���������MCS_ORDER_PROCESS_PARAM
select * from MCS_ORDER_PROCESS_PARAM
--ҽ����ҩ����_ִ��״̬MCS_ORDER_PROCESS_STATUS
select * from MCS_ORDER_PROCESS_STATUS
--ҽ��ִ�мƻ�Ƶ�ʲ�ֹ���MCS_ORDER_SCHEDULE_FREQUENCE
select * from MCS_ORDER_SCHEDULE_FREQUENCE
--��ǩ��ӡ��־(����)
select * from mcs_print_log

-------------------------------------------------���顢���µ��������¼���鵵���------------------------------------
--�����
select a.*,rowid from MCS_DOC_FORM a
--where template_code in ('592')
--where created_by  = 'mr'
--where id = 'd8984820-acb5-44b9-9b3b-200ad9968976'
--where mrn = '2023-86083'
--where dept_code = '0010'
where patient_id = '372888'
and template_code in ('403')
order by last_updated_date desc
and created_by is null
and is_valid = '0'

update MCS_DOC_FORM 
set is_valid = '0'
--select a.*,rowid from MCS_DOC_FORM a
--delete from MCS_DOC_FORM
where form_time > to_date('2023-01-28 00:00:00', 'yyyy-mm-dd hh24:mi:ss')
and form_time < to_date('2023-12-20 00:00:00', 'yyyy-mm-dd hh24:mi:ss')
and created_by is null
and last_updated_by is null
and ward_code in ('17','29')
--and is_valid = '0'
and patient_id in ('432562','663417','663332','372888','406269','663325','339647')
--and id not in (select form_id from ca_sign_info)

--�������¼
select a.*,rowid from MCS_DOC_FORM_RECORDS a
where form_id = 'e99fe445-cd68-4b6e-959a-3da7aacf5656'
and node_id = '23530'
and series = '3'
and template_code = '403';

--ǩ��ֵ
select * from  ca_sign_info e
where e.sign_date>=sysdate-10

--�����ֵ�
select * from MCS_DOC_MENU
where display_name like '%Ӫ��%'
where template_code in ('476')

--����ͼƬ��Ӧ
select e.*,rowid from mcs_doc_record_sign e 
where form_id in (select id from MCS_DOC_FORM
where patient_id = '599146'
and template_code = '558'
)

--���µ�
select a.*,rowid from mcs_vital_info a
where mrn = '2023-81227'
where patient_id = '633703'
where vitalsign_type = '1001'
and vitalsign_nval2 > '0.00'

--�¼���
select a.*,rowid from MCS_EVENT_INFO a
where patient_id = 'B014650'

select distinct event_name from MCS_EVENT_INFO
where record_time > to_date('2023-01-01','yyyy-mm-dd')

--���߹鵵
select rowid,a.* from mcs_archived_patient a
where patient_id='700000'
--����鵵PDF
select * from MCS_ARCHIVE_DOC
where patient_id = '494548'

--�������
select rowid,a.* from mcs_doc_status a

--������������Ӳ�����ͼJHCDAS.JHCDAS_INVOK_VIEW_INFO�Ƿ���¼��(1) �������������޸ģ��޸ĺ�浲: (2) ���������ͼ���ڼ�¼�����ٸ�������JHCDAS.JHCDAS_ARCHIVE_VIEW_INFO�Ƿ���ڼ�¼�����������޸ģ������������޸�
--���Ӳ�����ͼ
select * FROM JHCDAS.JHCDAS_INVOK_VIEW_INFO@EMR_DIAG_DB
where patient_no not like '%-%'
--���Ӳ����鵵��ͼ
select * FROM JHCDAS.JHCDAS_ARCHIVE_VIEW_INFO@EMR_DIAG_DB
where patient_id like '%214764%'

--�����費��Ҫ�鵵
select a.*,rowid from mcs_msys_init a
where display_name like '%�鵵%'

--vte����
select a.*,rowid from pat_vte a
--order by assess_date desc
where patient_id like '%637402%'

--����ƻ�
select rowid,a.* from MCS_nursing_plan a
--����ƻ�ģ��
select rowid,a.* from MCS_nursing_plan_TEMPLATE a

--����ģ��ڵ�
select * from MCS_DOC_NODES
where display_name like '%vte%'
--�����¼ģ��
select rowid,a.* from mcs_dict_nurs_record_template a
where ward_code in ('0000','9999')

--�����ֵ��
select * from MCS_DICT_VITALSIGN_TYPE;
--�¼��ֵ��
select * from MCS_DICT_EVENT_TYPE;
--����ڵ�����Ķ�������
select * from MCS_DOC_NODES_ACTION;
--����ڵ�����Դ
select * from MCS_DOC_NODES_DATA_SOURCE;
--���鱨������
select * from MCS_DOC_REPORT_XML_CONF
--�������ֵ��
select * from MCS_DICT_INOUT;
select * from MCS_DICT_WORKLOAD_ITEM;
select * from MCS_DICT_WORKLOAD_WARD;
--��������¼��--
select * from MCS_DOC_INOUT;
--������С��--
select * from MCS_DOC_INOUT_STATISTICS;
--�����¼��ģ��
select * from MCS_DOC_TEMPLATE
--ģ����Ҷ�Ӧ
select * from MCS_DOC_TEMPLATE_DEPT 

-------------------------------------------------���ҡ���������ʿ���------------------------------------
--��ʿ����
select a.*,rowid from mcs_sys_users a
--where ca_id is not NULL
--where user_name like '%�����%'
where user_code LIKE 'Q813%'

--��ʿ���
select a.*,rowid from mcs_sys_user_roles a
where user_id = '30358'
--��ʿ����ֵ�
select a.*,rowid from mcs_sys_roles a
--id����
create sequence mcs_sys_user_id
start with 30236
increment by 1

--�����ֵ�
select a.*,rowid from MCS_MSYS_DEPT_WARD a
where name like '%����%'
where code in ('0009')

--��ʿ����Ȩ��
select a.*,rowid from mcs_sys_user_wards a
where user_id = '6400'
and ward_code = '0N'

--��λ��ͼ
select * from v_ewell_cwsz@his_db
where bqbh = '18'

-------------------------------------------------��������------------------------------------
--������ת����
select a.*,rowid from mcs_scan_turninout a
--where type = '10'
where patient_id = '608630'
and type in ('5','10')
and order_no like '%473%'

comment on column mcs_scan_turninout.type is '1-��ƣ�3-ת�룬4-ת����5-ȥ������6-�ز�����8-ȥ��飬9-��������10-�����ز���';

--his������ͼ
select * from gdmch.v_ewell_operation@his_db
--order by upload_time desc
where patient_id = '583880'
where patient_no='2023-63627'

--�������������Լ�飬������Ϣ��
select * from gdmch.ss_v_beforoperfile@his_db
where bah = '661551'
where lsh='2023-63115'

--Ѳ��ҽ����
select a.*,rowid from mcs_msys_init a
where display_name like '%Ѳ��%'

--����Ѳ�ӹ��ܼ�����ñ�
select a.*,rowid from dict_patrol_time a

--����Ѳ��ִ����ϸ��
select * from mcs_patrol_process

--Ѳ��ҽ����
select a.*,rowid from mcs_patient_order_patrol a
--order by start_time desc
where patient_id = '670875'

--����Ѳ�����ɼ�¼���ñ�
select a.*,rowid from dict_oper_doc_info a

--pda����ҩƷִ�е�������
select a.*, rowid from special_drug_tip a
where order_name like '%�µ�ƽƬ%'

--���鹦��
select a.*,rowid from MCS_MY_BED_PATIENTS a

--����ƻ����������
select a.*,rowid from mcs_msys_init a
where display_name like '%����ƻ�%'

--ִ����ͳ�ƴ洢����
select * from p_stat_impl_rate

--ϵͳ������־
select a.*,rowid from mcs_sys_log a

--����Ѳ�Ӽ�¼
select * from  MCS_PATROL_INFO
where patient_id = '604878'
-------------------------------------------------���������------------------------------------
--lis����
select a.*,rowid from lis_report a 
--where patient_id = '644772'
where report_name like '%ϸ������%'
order by report_date desc
and report_id  = '02238727569'
--lis��������
select * from lis_report_detail
where id = '772d3843-f176-4e7d-9f63-fa0600f081b2'

select * from gdmch.v_ewell_inpatient_lis_order@his_db
where patient_id = '648140'

--PACS���ĵ籨��
select a.rowid, a.* from pacs_report a
--where pacs_report_date is not null
--order by pacs_report_date desc
where patient_id = '660004'
and series  = '3'

--�ĵ���ͼ
select * from zlyw_hl_new
where patient_id = '2023-86047'
-------------------------------------------------�ٴ�·��------------------------------------
--�ٴ�·���Ȳ��ܱ�
select * from nurse_and_cps_info where record_no='660383' and visit_id='2023-70819' and noh='2' and status='1'
--��Ϊ�� ������ ��ϸ��
select * from nurse_and_cps_work_notice where record_no='660383' and visit_id='2023-70819' and templet_code='380.3'
--��Ϊ�ռ����� ִ����ϸ��
select a.*,rowid from mcs_nursecps_notice a
where patient_id='660383'
and mrn = '2023-70819'
patient_uid='5590552021-263241'

select * from nurse_and_cps_work_notice
where record_no='585642'
and content_name not in(select content_name from mcs_nursecps_notice where patient_id='585642')

select * from v_ewell_inpatient_info

-------------------------------------------------��Ѫ��Ϣ------------------------------------
--��Ѫ������
select kk.*,rowid from v_ewell_blood_yh kk
--where ward_code = 'ѪҺ��'
--order by plan_time desc
--where patient_id = '624445'
--order by plan_time desc
where pack_no like '%050448%'
where apply_no = 'R2238767608'

--��Ѫִ�б�
select ddd.*,rowid from  mcs_transf_blood ddd
--where sx_time is not null
--order by sx_time desc
--where blood_name like '%�ֹ���%'
--and a.blood_name not like 
where pack_no like '%440112300236355D6611000%'

--������
select a.*,rowid from mcs_blood_patrol_info a
--order by record_time desc
where blood_pack_no like '%440112300236355D6611000%'

-------------------------------------------------����------------------------------------
--his��λ��ͼ
select * from gdmch.bqcwxx@his_db
where cwwzbs is not null

--������ͼ
select * from luna_mcs_gzey.zlyw_hl_new

--Ѫ����ͼ
select * from v_xuetang
where patient_id = '604443'

--������ͼ
select * from v_lianfan_inp_asmt

select  *  from v_bh_ywzx t where close_time>sysdate-10
--Ѫ�ǻ�����ͼ
select * from HIS_PATIENT

--����ĵ���ͼ
select * from v_libang_nursing_class

CREATE OR REPLACE VIEW v_libang_nursing_class AS
(select patient_id,nursing_class from v_ewell_inpatient_info);

grant create session to libang;
create user libang identified by libang123;
alter user libang identified by libang123;
grant select on v_libang_nursing_class to libang;
--���������ͼ
select * from V_SGTZ
order by record_time desc

grant select on V_SGTZ to ewell;

--����������ͼ
select * from v_ewell_evaluation

--��ʹ������ͼ
select * from v_ewell_painScore
grant select on v_ewell_painScore to ewell

select * from luna_mcs_gzey.v_mcs_vital_info where plan_time >=trunc(sysdate-2)
--Ժ����ͼ
select * from v_hais_neonate_body_weight
where patient_id = '653548'
select * from if_inpatient_temperature
select * from if_inpatient_defecation

alter user movesigned identified by movesigned123;

select * from luna_mcs_gzey.v_order_execute_time
WHERE his_order_id='20221219205795'
where execute_time > to_date('2023-02-01','yyyy-mm-dd')
order by execute_time desc

grant select on v_order_execute_time to AI_YG

create user movesigned identified by movesigned123;
grant select on lis_report to movesigned;

--Ӫ�����ָ�����
select * from V_yypf_keyan

select * from zlyw_hl

--����������ϸ
select * from v_hlpgmx

--�����Ӳ�����������ͼ
select * from v_mcs_vital_infoemr
where patient_id like '%N%'
--�����Ӳ�����vte������ͼ
select * from vte_tizhengshuju
--��֢ϵͳ
create user us_jhicu identified by jhicu123;
grant select on v_mcs_vital_infoemr to us_jhicu;
grant select on MCS_DICT_VITALSIGN_TYPE to us_jhicu;
--��ϵͳ������ͼ
select * from luna_mcs_gzey.v_mcs_vital_info
select * from luna_mcs_gzey.v_mcs_vital_info_doc
select * from luna_mcs_gzey.v_mcs_blood_glucose
select * from luna_mcs_gzey.v_mcs_nutritional_score

grant select on luna_mcs_gzey.v_mcs_nutritional_score to sjxt
--�豸������ͼ
create user us_gykj identified by gykj1234;
GRANT CREATE SESSION TO us_gykj
select * from luna_mcs_gzey.v_dept_ward
grant select on v_dept_ward to us_gykj;
--�ջ���ͼ
select * from v_bh_ywzx

select * from v_bh_bbcj

select * from v_bh_ywpz
--5.10.1������¼
select * from t_mark_delivery_records
--5.10.2���������¼
select * from t_mark_yindaofengmian
--5.13.1һ�㻤���¼
select * from t_mark_general_nursing_records
--5.13.3��������������¼
select * from t_mark_measurement_records
--5.13.5��������¼
select * from t_mark_entry_exit_record

--5.14.1��Ժ������¼
select * from t_mark_rypg
