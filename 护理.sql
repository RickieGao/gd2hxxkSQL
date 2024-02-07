--患者基本信息
select a.*,rowid from v_ewell_inpatient_info a
--where dept_name = '关节骨科二科'
--and status = '住院'
--and bed_no in ('136','137')
--order by admission_time desc
--where id_card = '440111196606193657'
where patient_id like '670514%'
where admission_id = '2024-07262'
where name = '张文杰'

--his患者
select * from v_ewell_inpatient_info@his_db
where  patient_id = '273277'

--改住院号执行过程：1.平台推正确消息；2.执行下面的执行过程；3.删除v_ewell_inpatient_info表里面的旧的信息；4.根据粤科里面的护理等级医嘱gdmch.zy_t_yz更新v_ewell_inpatient_info表里面护理等级字段nursing_class
BEGIN
  V_MODIFY_PATIENT(NOW_PATIENT =>'269233',--现在住院号
                   MRN => '2024-07262',--现在流水号
                   NOW_SERIES =>2,--现在住院次数
                   NEW_PATIENT =>'480440',--新住院号
                   NEW_SERIES =>10);--新住院次数
                   COMMIT;
END;
---------------------------------------------------医嘱相关----------------------------------------------
--his 原始遗嘱
select * from v_ewell_inpatient_order2@his_db
where admission_id = '2024-07262'
and admission_id = '2024-07262'
--and order_no = '20240115436369'
and order_name like '%普瑞巴林胶囊%'
--and inject_group = 'C-3'
and order_status = '在用'

--his 医嘱明细
select * from v_ewell_inpatient_order3@his_db
where patient_id = '269233'
and inject_group = '1-3'
--and plan_time > to_date('2022-04-29', 'yyyy-mm-dd')
--and plan_time < to_date('2022-04-30', 'yyyy-mm-dd')
and order_name like '%注射用福沙匹坦双%'
where order_no = '20231130392508'
--where xmbm = '1132000180'
order by start_time desc

--医嘱执行计划
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
--and supply_name = '静脉滴注'
--and order_class = 'a'
and order_name like '%普瑞巴林胶囊%'
order by plan_time desc

--医嘱执行计划_流程记录
select a.*,a.rowid from MCS_ORDER_SCHEDULE_PROCESS a
where patient_id = '604878'
and record_time > to_date('2022-09-18', 'yyyy-mm-dd')
and record_time < to_date('2022-09-19', 'yyyy-mm-dd')
--and series = '12'
where bar_code = '02230227161'
where record_time > sysdate -1

select * from MCS_ORDER_SCHEDULE_PROCESS a
where bar_code in (select bar_code from mcs_order_schedule a where his_order_id= '20230121742099')

--标签打印时间
select * from mcs_order_schedule_print
where bar_code = 'inp_12023-7539612240523022023-7539620231028160000'
--根据医嘱编号查标签打印时间
select * from mcs_order_schedule_print a
where bar_code in (select bar_code from mcs_order_schedule a where his_order_id= '20230121742099')

--静配药物
select * from mcs_order_detail
where group_no = '20230121742099'
where admission_id = '2022-54972'

--标本采集扫描
select * from mcs_order_schedule
where apply_no = 'R2238893095'
--plan_time>=trunc(sysdate -2)
and patient_id = '609863'
--and his_order_id = '20220915907740'
--and plan_time>=trunc(sysdate -2)
and bar_code like '0222%'
and order_name like '%急诊生化%'

--标本采集视图
select * from gdmch.v_ewell_inpatient_lis_order_al@his_db
where patient_id = '601684'
and item_name like '%病毒%'

--lis视图
select * from gdmch.v_ewell_inpatient_lis_order@his_db a
where a.start_date>trunc(sysdate)

--查询条码号里面有单引号
select rowid,b.* from mcs_order_schedule b
where plan_time>=trunc(sysdate)
and (bar_code like '%'||chr(39)||'%' or bar_code like '%;||chr(39)||;%' )

--医嘱用药流程_用法MCS_ORDER_PROCESS_DEF
select * from MCS_ORDER_PROCESS_DEF
--医嘱用药流程_操作项MCS_ORDER_PROCESS_ITEM
select * from MCS_ORDER_PROCESS_ITEM
--医嘱用药流程_流程项参数MCS_ORDER_PROCESS_PARAM
select * from MCS_ORDER_PROCESS_PARAM
--医嘱用药流程_执行状态MCS_ORDER_PROCESS_STATUS
select * from MCS_ORDER_PROCESS_STATUS
--医嘱执行计划频率拆分规则MCS_ORDER_SCHEDULE_FREQUENCE
select * from MCS_ORDER_SCHEDULE_FREQUENCE
--标签打印日志(废弃)
select * from mcs_print_log

-------------------------------------------------文书、体温单、护理记录、归档相关------------------------------------
--文书表单
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

--文书表单记录
select a.*,rowid from MCS_DOC_FORM_RECORDS a
where form_id = 'e99fe445-cd68-4b6e-959a-3da7aacf5656'
and node_id = '23530'
and series = '3'
and template_code = '403';

--签名值
select * from  ca_sign_info e
where e.sign_date>=sysdate-10

--文书字典
select * from MCS_DOC_MENU
where display_name like '%营养%'
where template_code in ('476')

--文书图片对应
select e.*,rowid from mcs_doc_record_sign e 
where form_id in (select id from MCS_DOC_FORM
where patient_id = '599146'
and template_code = '558'
)

--体温单
select a.*,rowid from mcs_vital_info a
where mrn = '2023-81227'
where patient_id = '633703'
where vitalsign_type = '1001'
and vitalsign_nval2 > '0.00'

--事件表
select a.*,rowid from MCS_EVENT_INFO a
where patient_id = 'B014650'

select distinct event_name from MCS_EVENT_INFO
where record_time > to_date('2023-01-01','yyyy-mm-dd')

--患者归档
select rowid,a.* from mcs_archived_patient a
where patient_id='700000'
--文书归档PDF
select * from MCS_ARCHIVE_DOC
where patient_id = '494548'

--病历封存
select rowid,a.* from mcs_doc_status a

--根据条件查电子病历观图JHCDAS.JHCDAS_INVOK_VIEW_INFO是否存记录，(1) 如果不在则可以修改，修改后存挡: (2) 如果上述视图存在记录，则再根条件查JHCDAS.JHCDAS_ARCHIVE_VIEW_INFO是否存在记录，如存在则可修改，不存在则不许修改
--电子病历视图
select * FROM JHCDAS.JHCDAS_INVOK_VIEW_INFO@EMR_DIAG_DB
where patient_no not like '%-%'
--电子病历归档视图
select * FROM JHCDAS.JHCDAS_ARCHIVE_VIEW_INFO@EMR_DIAG_DB
where patient_id like '%214764%'

--文书需不需要归档
select a.*,rowid from mcs_msys_init a
where display_name like '%归档%'

--vte数据
select a.*,rowid from pat_vte a
--order by assess_date desc
where patient_id like '%637402%'

--护理计划
select rowid,a.* from MCS_nursing_plan a
--护理计划模板
select rowid,a.* from MCS_nursing_plan_TEMPLATE a

--文书模版节点
select * from MCS_DOC_NODES
where display_name like '%vte%'
--护理记录模板
select rowid,a.* from mcs_dict_nurs_record_template a
where ward_code in ('0000','9999')

--体征字典表
select * from MCS_DICT_VITALSIGN_TYPE;
--事件字典表
select * from MCS_DICT_EVENT_TYPE;
--文书节点关联的动作描述
select * from MCS_DOC_NODES_ACTION;
--文书节点数据源
select * from MCS_DOC_NODES_DATA_SOURCE;
--文书报表配置
select * from MCS_DOC_REPORT_XML_CONF
--出入量字典表
select * from MCS_DICT_INOUT;
select * from MCS_DICT_WORKLOAD_ITEM;
select * from MCS_DICT_WORKLOAD_WARD;
--出入量记录单--
select * from MCS_DOC_INOUT;
--出入量小结--
select * from MCS_DOC_INOUT_STATISTICS;
--护理记录单模版
select * from MCS_DOC_TEMPLATE
--模板科室对应
select * from MCS_DOC_TEMPLATE_DEPT 

-------------------------------------------------科室、病区、护士相关------------------------------------
--护士密码
select a.*,rowid from mcs_sys_users a
--where ca_id is not NULL
--where user_name like '%林想红%'
where user_code LIKE 'Q813%'

--护士身份
select a.*,rowid from mcs_sys_user_roles a
where user_id = '30358'
--护士身份字典
select a.*,rowid from mcs_sys_roles a
--id序列
create sequence mcs_sys_user_id
start with 30236
increment by 1

--科室字典
select a.*,rowid from MCS_MSYS_DEPT_WARD a
where name like '%急诊%'
where code in ('0009')

--护士病区权限
select a.*,rowid from mcs_sys_user_wards a
where user_id = '6400'
and ward_code = '0N'

--床位视图
select * from v_ewell_cwsz@his_db
where bqbh = '18'

-------------------------------------------------其他功能------------------------------------
--患者流转数据
select a.*,rowid from mcs_scan_turninout a
--where type = '10'
where patient_id = '608630'
and type in ('5','10')
and order_no like '%473%'

comment on column mcs_scan_turninout.type is '1-入科，3-转入，4-转出，5-去手术，6-回病房，8-去检查，9-出病房，10-手术回病房';

--his手术视图
select * from gdmch.v_ewell_operation@his_db
--order by upload_time desc
where patient_id = '583880'
where patient_no='2023-63627'

--手术文书完整性检查，文书信息表
select * from gdmch.ss_v_beforoperfile@his_db
where bah = '661551'
where lsh='2023-63115'

--巡视医嘱表
select a.*,rowid from mcs_msys_init a
where display_name like '%巡视%'

--护理巡视功能间隔配置表
select a.*,rowid from dict_patrol_time a

--护理巡视执行明细表
select * from mcs_patrol_process

--巡视医嘱表
select a.*,rowid from mcs_patient_order_patrol a
--order by start_time desc
where patient_id = '670875'

--病房巡视生成记录配置表
select a.*,rowid from dict_oper_doc_info a

--pda特殊药品执行弹框提醒
select a.*, rowid from special_drug_tip a
where order_name like '%奥氮平片%'

--分组功能
select a.*,rowid from MCS_MY_BED_PATIENTS a

--护理计划导入文书表
select a.*,rowid from mcs_msys_init a
where display_name like '%护理计划%'

--执行率统计存储过程
select * from p_stat_impl_rate

--系统操作日志
select a.*,rowid from mcs_sys_log a

--病房巡视记录
select * from  MCS_PATROL_INFO
where patient_id = '604878'
-------------------------------------------------检验检测相关------------------------------------
--lis报告
select a.*,rowid from lis_report a 
--where patient_id = '644772'
where report_name like '%细菌报告%'
order by report_date desc
and report_id  = '02238727569'
--lis报告详情
select * from lis_report_detail
where id = '772d3843-f176-4e7d-9f63-fa0600f081b2'

select * from gdmch.v_ewell_inpatient_lis_order@his_db
where patient_id = '648140'

--PACS、心电报告
select a.rowid, a.* from pacs_report a
--where pacs_report_date is not null
--order by pacs_report_date desc
where patient_id = '660004'
and series  = '3'

--心电视图
select * from zlyw_hl_new
where patient_id = '2023-86047'
-------------------------------------------------临床路径------------------------------------
--临床路径先查总表
select * from nurse_and_cps_info where record_no='660383' and visit_id='2023-70819' and noh='2' and status='1'
--不为空 继续查 明细表
select * from nurse_and_cps_work_notice where record_no='660383' and visit_id='2023-70819' and templet_code='380.3'
--不为空继续查 执行明细表
select a.*,rowid from mcs_nursecps_notice a
where patient_id='660383'
and mrn = '2023-70819'
patient_uid='5590552021-263241'

select * from nurse_and_cps_work_notice
where record_no='585642'
and content_name not in(select content_name from mcs_nursecps_notice where patient_id='585642')

select * from v_ewell_inpatient_info

-------------------------------------------------输血信息------------------------------------
--输血基本表
select kk.*,rowid from v_ewell_blood_yh kk
--where ward_code = '血液科'
--order by plan_time desc
--where patient_id = '624445'
--order by plan_time desc
where pack_no like '%050448%'
where apply_no = 'R2238767608'

--输血执行表
select ddd.*,rowid from  mcs_transf_blood ddd
--where sx_time is not null
--order by sx_time desc
--where blood_name like '%手工分%'
--and a.blood_name not like 
where pack_no like '%440112300236355D6611000%'

--动作表
select a.*,rowid from mcs_blood_patrol_info a
--order by record_time desc
where blood_pack_no like '%440112300236355D6611000%'

-------------------------------------------------其他------------------------------------
--his床位视图
select * from gdmch.bqcwxx@his_db
where cwwzbs is not null

--肿瘤视图
select * from luna_mcs_gzey.zlyw_hl_new

--血糖视图
select * from v_xuetang
where patient_id = '604443'

--连帆视图
select * from v_lianfan_inp_asmt

select  *  from v_bh_ywzx t where close_time>sysdate-10
--血糖患者视图
select * from HIS_PATIENT

--理邦心电视图
select * from v_libang_nursing_class

CREATE OR REPLACE VIEW v_libang_nursing_class AS
(select patient_id,nursing_class from v_ewell_inpatient_info);

grant create session to libang;
create user libang identified by libang123;
alter user libang identified by libang123;
grant select on v_libang_nursing_class to libang;
--身高体重视图
select * from V_SGTZ
order by record_time desc

grant select on V_SGTZ to ewell;

--文书评分视图
select * from v_ewell_evaluation

--疼痛评分视图
select * from v_ewell_painScore
grant select on v_ewell_painScore to ewell

select * from luna_mcs_gzey.v_mcs_vital_info where plan_time >=trunc(sysdate-2)
--院感视图
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

--营养评分给科研
select * from V_yypf_keyan

select * from zlyw_hl

--护理评估明细
select * from v_hlpgmx

--给电子病历的体征视图
select * from v_mcs_vital_infoemr
where patient_id like '%N%'
--给电子病历的vte体征视图
select * from vte_tizhengshuju
--重症系统
create user us_jhicu identified by jhicu123;
grant select on v_mcs_vital_infoemr to us_jhicu;
grant select on MCS_DICT_VITALSIGN_TYPE to us_jhicu;
--神经系统体征视图
select * from luna_mcs_gzey.v_mcs_vital_info
select * from luna_mcs_gzey.v_mcs_vital_info_doc
select * from luna_mcs_gzey.v_mcs_blood_glucose
select * from luna_mcs_gzey.v_mcs_nutritional_score

grant select on luna_mcs_gzey.v_mcs_nutritional_score to sjxt
--设备保养视图
create user us_gykj identified by gykj1234;
GRANT CREATE SESSION TO us_gykj
select * from luna_mcs_gzey.v_dept_ward
grant select on v_dept_ward to us_gykj;
--闭环视图
select * from v_bh_ywzx

select * from v_bh_bbcj

select * from v_bh_ywpz
--5.10.1待产记录
select * from t_mark_delivery_records
--5.10.2阴道分娩记录
select * from t_mark_yindaofengmian
--5.13.1一般护理记录
select * from t_mark_general_nursing_records
--5.13.3生命体征测量记录
select * from t_mark_measurement_records
--5.13.5出入量记录
select * from t_mark_entry_exit_record

--5.14.1入院评估记录
select * from t_mark_rypg
