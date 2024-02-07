--病历列表
select a.*, rowid
  from pats_in_hospital a
 where patient_id = 'N622201'

select * from pat_visit where patient_id = 'N622201'
--病案首页
select a.*, rowid from pat_master_index a where a.patient_id = 'N661568'

--电子住院证视图
select * from V_ZYZ_TO_HIS
where 
where web_url is null
--之一缺少问题
select a.*, rowid
  from jhcdas_record_question_log a
 where a.patient_id = 'N619721'
--草稿审签状态问题
select a.*, rowid
  from jhemr.jhmr_file_index a
 where patient_id = 'N584194'
   and topic like '%手术%'
--手术文书
select a.*, rowid from jhemr.HLHT_V_OPERFILE

select a.*, rowid from jhmr_file_index a
where patient_id like 'N648452%'

--电子病历体征视图
select * from vital_signs_rec
--抗疫统计
select distinct p.patient_no          流水号,
                p.inp_no              病案号,
                p.visit_id            就诊次数,
                p.discharge_date_time
  from r_diagnosis_doct a, pat_visit p, jhmr_file_index c
 where a.diagnosis_code like 'U07.1%'
   and c.creator_id = '8135'
   and a.patient_id = p.patient_id
   and a.visit_id = p.visit_id
   and a.patient_id = c.patient_id
   and a.visit_id = c.visit_id
                                        
--抢救记录
select distinct p.patient_no, p.inp_no, p.visit_id, p.discharge_date_time
  from jhmr_file_index t, jhmr_file_content_text te, pat_visit p
 where te.file_unique_id = t.file_unique_id
   and blob_to_varchar(te.mr_content) like '%吴珍%'
   and t.delete_flag = '0'
   and t.patient_id = p.patient_id
   and t.visit_id = p.visit_id
   and t.mr_code = 'EMR10.00.08_1'
   and t.create_date_time >= to_date('2015-07-01', 'yyyy-mm-dd')
   and t.create_date_time < to_date('2023-05-01', 'yyyy-mm-dd') + 1
 order by p.discharge_date_time




select a.*, rowid
  from jhemr.jhmr_file_index a
 where topic like '%心理%会诊%'
   and (patient_id, visit_id) in
       (('N608527', '1'),
        ('N608342', '1'),
        ('N608411', '1'),
        ('N608012', '1'),
        ('N592927', '2'),
        ('N608174', '1'),
        ('N609290', '1'),
        ('N609102', '1'),
        ('N608907', '1'),
        ('N609102', '1'),
        ('N608907', '1'),
        ('N608974', '1'),
        ('N608907', '1'),
        ('N609404', '1'),
        ('N609102', '1'),
        ('N577732', '2'),
        ('N609404', '1'),
        ('N609102', '1'),
        ('N609013', '1'),
        ('N609484', '1'),
        ('N609628', '1'),
        ('N608907', '1'),
        ('N609693', '1'),
        ('N608907', '1'),
        ('N609102', '1'),
        ('N609290', '1'),
        ('N608907', '1'),
        ('N608907', '1'),
        ('N612008', '1'),
        ('N609507', '1'),
        ('N609013', '1'),
        ('N608974', '1'),
        ('N609770', '1'),
        ('N616928', '1'),
        ('N606785', '2'),
        ('N621740', '1'),
        ('N621740', '1'),
        ('N622210', '1'),
        ('N621756', '1'),
        ('N622419', '1'),
        ('N527820', '4'),
        ('N621743', '1'),
        ('N621756', '1'),
        ('N621743', '1'),
        ('N527820', '4'),
        ('N621743', '1'),
        ('N590519', '4'),
        ('N606785', '2'))

--病历完成状态
select * from emr_finish_state 
where patient_id = '513428'
