select  /*+ USE_HASH (t,q) */  Case When h.zxsj Is Null Then to_date( to_char(t.start_date,'yyyy-mm-dd hh24:mi'),'yyyy-mm-dd hh24:mi') ---20180412 ����ָ��hashִ�мƻ� ��Ϣ�ƴ���
       Else to_date(to_char(rq,'yyyy-mm-dd ')||h.zxsj,'yyyy-mm-dd hh24:mi')  End  plan_time,--ִ��ʱ��
       t.lsh||t.yz_sn||to_char(rq,'yymmdd')||h.cs order_executed_id,--ҽ��ִ��ID����ϵͳΪ��
       t.yz_sn as order_no, --ҽ����  ÿ��ҽ�����ڲ�Ψһ���
       case when t.inject_group is null then t.yz_sn else t.yz_base_type||t.lsh||t.inject_group||t.direction||nvl(t.timeeveryday,'') end  as group_no, --ҽ�����  ����һ��ҩ�������ͬ��ҩ��һ��ʹ�õ�,�������������˵,����Ψһ.
       '' as order_code, --ҽ����
       decode(t.itemname,'����',t.remark, t.itemname) as order_name, --ҽ������
       q.xmbm as xmbm,   ---��Ŀ����
       decode(y.zwmc2,'','','('||y.zwmc2||')')  as drug_name, --ҩƷ����
       a.bah as patient_id, --����ID
       --decode(nvl(t.babysn,'0'),'0',a.bah,'N'||replace(replace(trim(Replace(trim(a.bah)||'@!@!@!','0',' ')),' ','0'),'@!@!@!')||'Z'||a.zycs||'B'||t.babysn) as patient_id, --����ID
       a.zycs as series, --סԺ����
       t.lsh as admission_id, --סԺ��
       --nvl((select bqbh from bc_t_cwjl where zyh = t.lsh and bz = 'ռ��' and rownum =1),(select bqbh from bc_T_bqbh where bqmc = t.ward)) as  ward_code, --�������� �����2017-3-31
       --(select bqbh from bc_T_bqbh where bqmc = t.ward)  as ward_code, --��������
       (Select bqbh From gdmch.bqcwxx Where zyzyh = t.lsh And ztbz = '1') as ward_code, --��������  lily 2017-04-14
       null as dept_id, --����ID С��Ҫ������ 2017-10-30
       t.dept as dept_code, --���Ҵ���
       t.specification as drug_spec, --���
       (select name from gdmch.mz_T_codes where bm =t.timeeveryday) as frequency_code, --Ƶ�δ���  Ƶ�Σ�ST��ONCE��BID��QD�ȣ�  nvarchar
       t.dose as dosage, --����    numeric  dosage
       t.dose_unit as dosage_unit, --������λ    nvarchar
       t.direction as supply_code, --��ҩ��ʽ����    nvarchar
       c.name as supply_name, --��ҩ��ʽ    nvarchar
       decode(t.doctoradvise_status,'1','����','2','ֹͣ','3','����') as order_status, --ҽ��״̬  ����/����/ֹͣ  nvarchar
       case when t.yz_type in('20','22','24','32') then 'a' when t.yz_type in ('30','34') then 'b' when t.yz_type in ('02') then 'c'
            when t.yz_type in ('03','04') then 'd' when t.yz_type in ('05') then 'f' when t.yz_type in ('06') then 'h'
            when t.yz_type in('00') then '00' when t.yz_type in('08') then '08' when t.yz_type in('36') then '36' when t.yz_type in('40') then '40' end as order_class, --ҽ�����  a,b,c,d,e,f,g,h,i��˵������  nvarchar
       case when t.yz_type in('20','22','24','32') then '��ҩ���г�ҩ' when t.yz_type in ('30','34') then '��ҩ' when t.yz_type in ('02') then '����'
            when t.yz_type in ('03','04') then '���' when t.yz_type in ('05') then '����' when t.yz_type in ('06') then '����'
            when t.yz_type in('00') then '����' when t.yz_type in('08') then '����' when t.yz_type in('36') then 'Э�鴦��' when t.yz_type in('40') then '��Ʒ' end as order_class_name, --ҽ�������  ҽ�����a ��ҩ ���г�ҩ  b ��ҩ c ���� d ���  e ���� f ���� g ����  h ���� i ��ʳ j ��Ѫ  nvarchar
       decode(t.yz_base_type,'0','����','1','����ҽ��','2','��ʱҽ��') as long_once_flag, --����/��ʱ���  ����ҽ��/��ʱҽ��  nvarchar
       y.gjsyp as high_risk, --�Ƿ��ΣҩƷ  1���ǣ�0����  numeric  --2021-11-05 null��Ϊyk_T_ypzl.gjsyp
       t.firstdaydosage as today_times, --���մ���  �������յ���ҩ����  numeric
       null as skin_test, --�Ƿ���Ҫ����Ƥ��  1����Ҫ��0������Ҫ��  numeric
       null as provide_by_self, --�Ա�ҩ��־  1,���Ա�ҩ��0�������Ա�ҩ  numeric
       0 as is_aux, --��ҩ��־  �Ƿ�ҩ,0��ʾ��ҩ,1��ʾ��ҩ  numeric
       t.start_date as start_time, --��ʼʱ��    datetime  start_time
       t.nurse_startdate as enter_time, --����ʱ��    datetime  enter_time
       (select e.xm from gdmch.rl_t_ygk e where e.lsh=t.initial_doctor) as doctor_name, --����ҽ����    nvarchar
       t.cease_date as stop_time, --ֹͣʱ��    datetime
       t.cease_doctor as stop_doctor_id, --ֹͣҽ������  ��ѡ  nvarchar
       (select e.xm from gdmch.rl_t_ygk e where e.lsh=t.cease_doctor) as stop_doctor_name, --ֹͣҽ������  ��ѡ  nvarchar
       '' as exhortation, --����  ҽ���´�ҽ��ʱ���Ը�ҽ��ʹ�õ�˵������ѡ��  nvarchar
       t.PSJG||t.remark as remark, --��ע  ��ѡ  nvarchar
       t.lastdaydosage as end_times, --ĩ�մ���  �������յ���ҩ����  numeric
       t.marker as marker,   --��ע
       substr(t.inject_group,1,1)||'-'|| substr(t.inject_group,2,1) inject_group,
        nvl(y.sfbyj,'N') drug_machine,  ---�Ƿ��ҩ��
        case when (t.direction in('2487','2488')   --�����÷�
       or t.dept in('0053') and t.yz_base_type='1' and t.direction  in('2405','2447')) --�������γ���
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
--2017-06-12  ֻ��ʾ����ҽ��
and nvl(q.bbbh,'0') = '0'
--and t.dept<>0075
and t.yz_type not in('02','03','04')
--and (y.sfbyj<>'Y'or y.sfbyj is null) ----�뽣��20171225��ƽ̨���������ҩ�����ݻ�������
and t.itemname not like '%������Һ%'
and a.bah = '598968'
--and inject_group = 4-6
--and t.yz_sn = '20220331824182'
