select  /*+ USE_HASH (t,q) */  Case When h.zxsj Is Null Then to_date( to_char(t.start_date,'yyyy-mm-dd hh24:mi'),'yyyy-mm-dd hh24:mi') ---20180412 增加指定hash执行计划 信息科大罗
       Else to_date(to_char(rq,'yyyy-mm-dd ')||h.zxsj,'yyyy-mm-dd hh24:mi')  End  plan_time,--执行时间
       t.lsh||t.yz_sn||to_char(rq,'yymmdd')||h.cs order_executed_id,--医嘱执行ID，旧系统为空
       t.yz_sn as order_no, --医嘱号  每条医嘱的内部唯一编号
       case when t.inject_group is null then t.yz_sn else t.yz_base_type||t.lsh||t.inject_group||t.direction||nvl(t.timeeveryday,'') end  as group_no, --医嘱组号  代表一组药，组号相同的药是一起使用的,相对于其他组来说,数据唯一.
       '' as order_code, --医嘱码
       decode(t.itemname,'记事',t.remark, t.itemname) as order_name, --医嘱名称
       q.xmbm as xmbm,   ---项目编码
       decode(y.zwmc2,'','','('||y.zwmc2||')')  as drug_name, --药品名称
       a.bah as patient_id, --病人ID
       --decode(nvl(t.babysn,'0'),'0',a.bah,'N'||replace(replace(trim(Replace(trim(a.bah)||'@!@!@!','0',' ')),' ','0'),'@!@!@!')||'Z'||a.zycs||'B'||t.babysn) as patient_id, --病人ID
       a.zycs as series, --住院次数
       t.lsh as admission_id, --住院号
       --nvl((select bqbh from bc_t_cwjl where zyh = t.lsh and bz = '占用' and rownum =1),(select bqbh from bc_T_bqbh where bqmc = t.ward)) as  ward_code, --病区代码 龙武改2017-3-31
       --(select bqbh from bc_T_bqbh where bqmc = t.ward)  as ward_code, --病区代码
       (Select bqbh From gdmch.bqcwxx Where zyzyh = t.lsh And ztbz = '1') as ward_code, --病区代码  lily 2017-04-14
       null as dept_id, --科室ID 小冯要求增加 2017-10-30
       t.dept as dept_code, --科室代码
       t.specification as drug_spec, --规格
       (select name from gdmch.mz_T_codes where bm =t.timeeveryday) as frequency_code, --频次代码  频次（ST、ONCE、BID、QD等）  nvarchar
       t.dose as dosage, --剂量    numeric  dosage
       t.dose_unit as dosage_unit, --剂量单位    nvarchar
       t.direction as supply_code, --给药方式代码    nvarchar
       c.name as supply_name, --给药方式    nvarchar
       decode(t.doctoradvise_status,'1','在用','2','停止','3','撤销') as order_status, --医嘱状态  在用/撤销/停止  nvarchar
       case when t.yz_type in('20','22','24','32') then 'a' when t.yz_type in ('30','34') then 'b' when t.yz_type in ('02') then 'c'
            when t.yz_type in ('03','04') then 'd' when t.yz_type in ('05') then 'f' when t.yz_type in ('06') then 'h'
            when t.yz_type in('00') then '00' when t.yz_type in('08') then '08' when t.yz_type in('36') then '36' when t.yz_type in('40') then '40' end as order_class, --医嘱类别  a,b,c,d,e,f,g,h,i，说明见下  nvarchar
       case when t.yz_type in('20','22','24','32') then '西药、中成药' when t.yz_type in ('30','34') then '中药' when t.yz_type in ('02') then '检验'
            when t.yz_type in ('03','04') then '检查' when t.yz_type in ('05') then '手术' when t.yz_type in ('06') then '护理'
            when t.yz_type in('00') then '其它' when t.yz_type in('08') then '记事' when t.yz_type in('36') then '协议处方' when t.yz_type in('40') then '物品' end as order_class_name, --医嘱类别名  医嘱类别：a 西药 、中成药  b 中药 c 检验 d 检查  e 治疗 f 手术 g 麻醉  h 护理 i 膳食 j 输血  nvarchar
       decode(t.yz_base_type,'0','其它','1','长期医嘱','2','临时医嘱') as long_once_flag, --长期/临时标记  长期医嘱/临时医嘱  nvarchar
       y.gjsyp as high_risk, --是否高危药品  1，是；0，否  numeric  --2021-11-05 null改为yk_T_ypzl.gjsyp
       t.firstdaydosage as today_times, --首日次数  开嘱当日的用药次数  numeric
       null as skin_test, --是否需要先做皮试  1，需要；0，不需要。  numeric
       null as provide_by_self, --自备药标志  1,是自备药；0，不是自备药  numeric
       0 as is_aux, --副药标志  是否副药,0表示主药,1表示副药  numeric
       t.start_date as start_time, --开始时间    datetime  start_time
       t.nurse_startdate as enter_time, --开嘱时间    datetime  enter_time
       (select e.xm from gdmch.rl_t_ygk e where e.lsh=t.initial_doctor) as doctor_name, --开嘱医生名    nvarchar
       t.cease_date as stop_time, --停止时间    datetime
       t.cease_doctor as stop_doctor_id, --停止医生代码  可选  nvarchar
       (select e.xm from gdmch.rl_t_ygk e where e.lsh=t.cease_doctor) as stop_doctor_name, --停止医生姓名  可选  nvarchar
       '' as exhortation, --嘱托  医生下达医嘱时，对该医嘱使用的说明，可选。  nvarchar
       t.PSJG||t.remark as remark, --备注  可选  nvarchar
       t.lastdaydosage as end_times, --末日次数  开嘱当日的用药次数  numeric
       t.marker as marker,   --标注
       substr(t.inject_group,1,1)||'-'|| substr(t.inject_group,2,1) inject_group,
        nvl(y.sfbyj,'N') drug_machine,  ---是否包药机
        case when (t.direction in('2487','2488')   --静配用法
       or t.dept in('0053') and t.yz_base_type='1' and t.direction  in('2405','2447')) --肿瘤静滴长嘱
       then 'Y' else 'N' end pivas_flag
from gdmch.zy_t_yz t, gdmch.zy_t_brjbxx a, gdmch.mz_t_codes c,gdmch.zy_t_zyqk f,gdmch.yk_T_ypzl y,gdmch.zy_T_qdjl q,gdmch.Zy_t_Hstemp_hl h
where t.lsh=a.lsh and t.direction=c.bm(+)
and t.lsh=f.lsh
--and f.cysj is null
and t.doctoradvise_status in('1','2')
and t.encode = y.ypbm(+)
And t.lsh = q.lsh
And t.yz_sn = q.zfybm
And nvl(q.sypl,'2301') = h.plbm
And h.cs <= nvl(q.cishu,1)
And q.zt In ( '0','1')
And q.rq > Sysdate - 1
And q.by_group = '1'
--2017-06-12  只显示大人医嘱
and nvl(q.bbbh,'0') = '0'
--and t.dept<>0075
and t.yz_type not in('02','03','04')
--and (y.sfbyj<>'Y'or y.sfbyj is null) ----冯剑锋20171225等平台上了再想包药机数据互联问题
and t.itemname not like '%静脉输液%'
and a.bah = '598968'
--and inject_group = 4-6
--and t.yz_sn = '20220331824182'
