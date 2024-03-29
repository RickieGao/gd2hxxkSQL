
--清除字段中的空格
select trim(cwwzbs),cwwzbs from gdmch.bqcwxx
where bqbh = '29'
and ch = '091'

update gdmch.bqcwxx set cwwzbs = trim(cwwzbs)

select b.bqmc,a.* from gdmch.bqcwxx a left join gdmch.bc_t_bqbh b on a.bqbh = b.bqbh
where a.bqbh not in ('0A','0B','0C','0D','0E','0F','0G','0H','0J','0K','0L','0M','0N','34','53','54','55','60','61','62','63','64','65','66','67',
'69','70','71','72','73','74','75','76','77','78','79','80','81','98','Z1','Z2','Z4','Z3','Z5','Z6','Z7','Z8','ZA','ZB','ZC','ZD')
--清掉没有外借流水号的但是外借床的外借标志wjcw=0
select a.*,rowid from gdmch.bqcwxx a 
where ztbz <> '0' and wjcw = '1' and wjcw_lsh is null

--医保收费项目维护--
--第一步、收费项目表，根据给的新表手动更新name、bz字段
select * from gdmch.mz_t_codes where father = 'ZLXZ'
--第二步、sp开关关闭
select * from gdmch.mz_t_codes where name like '%总量%' for update

select * from gdmch.mz_t_ghxx
where blh = '0000222222'
select * from gdmch.mz_t_brjbxx



--科室现有人数
select distinct(lsh) from gdmch.zy_t_zyqk
where rysj > to_date('2023-02-09 07:30:00','yyyy-mm-dd hh24:mi:ss')
and  rysj < to_date('2023-02-10 07:30:00','yyyy-mm-dd hh24:mi:ss')
and rykb = '0105'

select distinct(a.lsh) from gdmch.zy_t_zyqk a left join gdmch.zy_t_brjbxx b on a.lsh = b.lsh
where a.cysj is null
and  a.rysj < to_date('2023-02-10 07:30:00','yyyy-mm-dd hh24:mi:ss')
and a.rykb = '0105'
and b.bah not like '%B%'

--申请查询自2020年4月至2021年4月期间，本人在我院门诊系统以“声带息肉”、“声带小结”、“声带任克氏水肿”、“声带肿物”、
--“声带沟”、“慢性喉炎”为诊断下开据所有门诊检查项目的汇总表，以便到庭做为证据材料。请协助查询，望审批为盼。
--病人姓名 性别 年龄   开的所有诊断，和检检检查处方--
select * from gdmch.mz_t_mzzd
where mzh = '200712100994'
where qmxx = '何萃'
select gdmch.f_nl_tostring(csrq,sysdate ) from gdmch.mz_t_brjbxx 
select * from gdmch.mz_t_jycf where sfbz =1 and zf = 0 


select e.开出医生, f.brxm 病人姓名, f.xb 性别, f.csrq 出生日期, f.blh 病历号, e.诊断, e.诊断开出时间,e.检验检查项目
from
(select c.开出医生, c.门诊号, d.blh, c.诊断, c.诊断开出时间,c.检验检查项目
from
(select a.qmxx 开出医生,a.mzh 门诊号, a.zd 诊断, a.created_date 诊断开出时间, b.xmmc 检验检查项目 from 
gdmch.mz_t_mzzd a
full join
gdmch.mz_t_jycf b
on a.mzh = b.mzh
where (a.zd like '%声带息肉%' or a.zd like '%声带小结%' or a.zd like '%声带任克氏水肿%' or a.zd like '%声带肿物%' or a.zd like '%声带沟%' or a.zd like '%慢性喉炎%')
and a.qmxx = '何萃'
and a.created_date >= to_date(&s_date1,'yyyy-mm-dd') and a.created_date < to_date(&s_date2,'yyyy-mm-dd') + 1
and b.sfbz =1
and b.zf = 0) c
left join
gdmch.mz_t_ghxx d
on c.门诊号 = d.mzh) e
left join
gdmch.mz_t_brjbxx f
on e.blh = f.blh

gdmch.f_nl_tostring(d.csrq,sysdate ) 年龄,

select e.qmxx , f.brxm 病人姓名, f.xb 性别, f.csrq 出生日期, f.blh 病历号, e.zd 诊断, e.created_date 诊断开出时间,e.xmmc 检验检查项目
from
(select c.qmxx, c.mzh, d.blh, c.zd, c.created_date,c.xmmc
from
(select a.qmxx, a.mzh, a.created_date, a.zd, b.xmmc
from
(select mzh, zd, qmxx, created_date
from gdmch.mz_t_mzzd
where 
mzh in(select distinct mzh from 
gdmch.mz_t_mzzd
where (zd like '%声带息肉%' or zd like '%声带小结%' or zd like '%声带任克氏水肿%' or zd like '%声带肿物%' or zd like '%声带沟%' or zd like '%慢性喉炎%')
and qmxx = '何萃'
and created_date >= to_date(&s_date1,'yyyy-mm-dd') and created_date < to_date(&s_date2,'yyyy-mm-dd') + 1)
) a
left join
(select mzh, xmmc 
from gdmch.mz_t_jycf
where mzh in(select distinct mzh from 
gdmch.mz_t_mzzd
where (zd like '%声带息肉%' or zd like '%声带小结%' or zd like '%声带任克氏水肿%' or zd like '%声带肿物%' or zd like '%声带沟%' or zd like '%慢性喉炎%')
and qmxx = '何萃'
and created_date >= to_date(&s_date1,'yyyy-mm-dd') and created_date < to_date(&s_date2,'yyyy-mm-dd') + 1)
) b
on a.mzh = b.mzh
) c
left join
gdmch.mz_t_ghxx d
on c.mzh = d.mzh) e
left join
gdmch.mz_t_brjbxx f
on e.blh = f.blh

--神经内科2018.12.1至2019.11.30、2019.12.1至
--2020.11.30、2020.12.1至2021.11.30三个年度分别的门诊总收入及药占比、住院总收入及药占比、门诊+住院总收入及药占比
select yf 药费,zje 总收入 ,yf/zje 药比
from
(
Select sum(case when cwdm in (1, 2, 3) then
                               nvl(a.YSJE, 0)
                              Else
                               0
                            End ) yf,
                          Sum(a.ysje) zje
From ( Select * From gdmch.zy_t_qdjl where rq > to_date(&startdate,'yyyy-mm-dd')  And  rq <to_date(&enddate,'yyyy-mm-dd')+1 and brdqks='0051'
Union All
Select * From gdmch.zy_t_cyqdjl where rq  >to_date(&startdate,'yyyy-mm-dd')  And  rq <to_date(&enddate,'yyyy-mm-dd')+1 and brdqks='0051'
) a
where a.zt In (0,1)
And zxrq is not null
)

select yf 药费,zje 总收入 ,yf/zje 药比
from
(
Select sum(case when cwdm in (1, 2, 3) then
                               nvl(YSJE, 0)
                              Else
                               0
                            End ) yf,
                          Sum(ysje) zje
From gdmch.mz_t_sfjl
where rq >=to_date(&startdate,'yyyy-mm-dd')
and rq < to_date(&enddate,'yyyy-mm-dd')
and kcfks='0051'
and zt = '1'
)


--神经内科
select b.bah,b.brxm,sum(a.ysje),c.xm,k.ksmc,a.rq,a.xmbm,a.sfmc
 from (select * from gdmch.zy_T_qdjl union all select * from gdmch.zy_T_cyqdjl ) a ,gdmch.zy_T_brjbxx b ,gdmch.rl_T_ygk c,gdmch.Rl_t_Keshiku k
where a.xmbm in('320200002',
'320600001',
'320200003',
'320600005',
'320100008-1',
'320600012s',
'320200016s',
'320200010',
'320600004',
'320200009',
'320600003','320600008')
and a.brdqks='0051'
and a.zt in('0','1') and a.zxrq is not null
and a.lsh=b.lsh
and a.kcys=c.lsh
and a.brdqks=k.ksbm
and a.rq>=to_Date('2020-12-01','yyyy-mm-dd')
and a.rq<to_Date('2021-11-01','yyyy-mm-dd')
group by  b.bah,b.brxm,c.xm,k.ksmc,a.rq,a.xmbm,a.sfmc
order by rq

--统计风湿免疫科2018.1.1-2021.11.30期间：幼年型关节炎、幼年型关节炎伴全身性发病、强直性脊柱炎、关节痛18岁以下门诊病例人数
select count(*) from
(select a.mzh,a.zd, b.ghrqsj, b.blh from
gdmch.mz_t_mzzd a join gdmch.mz_t_ghxx b
on a.mzh = b.mzh
where b.ghks = '0256'
and b.ghrqsj >=to_Date('2018-01-01','yyyy-mm-dd')
and b.ghrqsj <to_Date('2021-11-30','yyyy-mm-dd')
and (a.zd like '%幼年型关节炎%' or a.zd like '%幼年型关节炎伴全身性发病%' or a.zd like '%强直性脊柱炎%' or a.zd like '%关节痛%')
) c join gdmch.mz_t_brjbxx d
on c.blh = d.blh
where (extract(year from c.ghrqsj)-extract(year from d.csrq)) < 18

select count(*) from
(select a.mzh,a.zd, b.ghrqsj, b.blh from
gdmch.mz_t_mzzd a join gdmch.mz_t_ghxx b
on a.mzh = b.mzh
where b.ghks = '0256'
and b.ghrqsj >=to_Date('2018-01-01','yyyy-mm-dd')
and b.ghrqsj <to_Date('2021-11-30','yyyy-mm-dd')
and a.zd in('幼年型关节炎','幼年型关节炎伴全身性发病','强直性脊柱炎','关节痛')
) c join gdmch.mz_t_brjbxx d
on c.blh = d.blh
where (extract(year from c.ghrqsj)-extract(year from d.csrq)) < 18

--标本采集数据统计
SELECT lx, dh, jydh, brxm, ch, kdks, kdys, kcfrq, xmmc, bqdysj, bbjsr_qmxx 标本接收人, nvl(rq,to_date('1900-01-01','yyyy-mm-dd')) smrq , csr, bbjssj 送检到达时间, rq, cxf
--select ksmc 科室名称, 数量 为空量
--from (
--select kdks ,count(*) 数量
from (select substr(m.dh, 1, 1) lx,
               m.dh,
               m.jyjcdh jydh,
               m.csr,
               m.rq,
               j.kcfks kdks,
               j.kcfys kdys,
               j.xmmc,  
               b.brxm,
          j.bqdysj,  /*2014-10-11 应张颖要求 显示标签打印时间*/
          j.kcfrq,
          m.bbjsr_qmxx, m.bbjssj, '' ch,j.cxf
          from (Select a.jyjcdh, c.dh, c.csr, c.rq, a.bbjsr_qmxx, a.bbjssj
                  From gdmch.jy_T_cyxx a, gdmch.jy_T_qsxx c
                 Where a.Cydh = c.Dh
                   and c.rq >= to_date(&kssj,'yyyy-mm-dd hh24:mi:ss')
                   and c.rq < to_date(&jssj,'yyyy-mm-dd hh24:mi:ss')
                Union All
                Select a.jyjcdh, c.dh, c.csr, rq, a.bbjsr_qmxx, a.bbjssj
                  From gdmch.jy_T_cyxx a, gdmch.jy_T_qsxx c
                 Where a.Cs_Jyy_Dh = c.Dh
                   and c.rq >= to_date(&kssj,'yyyy-mm-dd hh24:mi:ss')
                   and c.rq < to_date(&jssj,'yyyy-mm-dd hh24:mi:ss')
                Union All
                Select a.jyjcdh, c.dh, c.csr, c.rq, a.bbjsr_qmxx, a.bbjssj
                  From gdmch.jy_T_cyxx a, gdmch.jy_T_qsxx c
                 Where a.lcqsdh = c.Dh
                   and c.rq >= to_date(&kssj,'yyyy-mm-dd hh24:mi:ss')
                   and c.rq < to_date(&jssj,'yyyy-mm-dd hh24:mi:ss')) m,
               gdmch.mz_t_jycf j,
               gdmch.mz_t_brjbxx b,
               gdmch.mz_t_ghxx xx
         where m.jyjcdh = j.jyjcdh
           and j.mzh = xx.mzh
           and b.blh = xx.blh
        union all
        select substr(m.dh, 1, 1) lx,
               m.dh,
               m.jyjcdh,
               m.csr,
               m.rq,
               z.writer_dept,
               z.initial_doctor,
               z.itemname,
               decode(z.babysn, '0', b.brxm, b.brxm || '之婴' || z.babysn),
          z.bqdysj /*2014-10-11 应张颖要求 显示标签打印时间*/,
          z.start_date kcfrq,
          m.bbjsr_qmxx, m.bbjssj, ch, cxf
          from (Select a.jyjcdh, c.dh, c.csr, c.rq, a.bbjsr_qmxx, a.bbjssj ,case when 
                     a.Cydh is not null and a.Cs_Jyy_Dh is null and a.lcqsdh is null then '1' else  '0'  end xh,d.ch,d.cxf
                  From gdmch.jy_T_cyxx a, gdmch.jy_T_qsxx c  ,gdmch.cy_v_zy_jyxmcyxx d 
                 Where a.Cydh = c.Dh(+)
                   and d.jydh=a.jyjcdh(+)
                   and c.rq >= to_date(&kssj,'yyyy-mm-dd hh24:mi:ss')
                   and c.rq < to_date(&jssj,'yyyy-mm-dd hh24:mi:ss')
                   union 
                   
            Select a.jyjcdh, c.dh, c.csr, c.rq, a.bbjsr_qmxx, a.bbjssj ,case when 
                     a.Cydh is  null and a.Cs_Jyy_Dh is not null and a.lcqsdh is null then '1' else  '0'  end xh,d.ch,d.cxf
                    From gdmch.jy_T_cyxx a, gdmch.jy_T_qsxx c ,gdmch.cy_v_zy_jyxmcyxx d
                 Where a.Cs_Jyy_Dh = c.Dh(+) 
                   and d.jydh=a.jyjcdh(+)
                   and c.rq >= to_date(&kssj,'yyyy-mm-dd hh24:mi:ss')
                   and c.rq < to_date(&jssj,'yyyy-mm-dd hh24:mi:ss')      
                   union  

           Select a.jyjcdh, c.dh, c.csr, c.rq, a.bbjsr_qmxx, a.bbjssj ,case when 
                     a.Cydh is  null and a.lcqsdh is not null then '1' else '0' end xh,d.ch,d.cxf
                  From gdmch.jy_T_cyxx a, gdmch.jy_T_qsxx c ,gdmch.cy_v_zy_jyxmcyxx d 
                 Where a.lcqsdh = c.Dh(+)
                   and d.jydh=a.jyjcdh(+)
                   and c.rq >= to_date(&kssj,'yyyy-mm-dd hh24:mi:ss')
                   and c.rq < to_date(&jssj,'yyyy-mm-dd hh24:mi:ss')      
                   union
          Select a.jyjcdh, c.dh, c.csr, c.rq, a.bbjsr_qmxx, a.bbjssj ,case when 
                     a.Cydh is  null and a.Cs_Jyy_Dh is  null and a.lcqsdh is  null then '1' else  '0'  end xh,d.ch,d.cxf
                  From gdmch.jy_T_cyxx a, gdmch.jy_T_qsxx c ,gdmch.cy_v_zy_jyxmcyxx d 
                 Where a.lcqsdh = c.Dh(+)
                   and d.jydh=a.jyjcdh(+)
                   and c.rq >= to_date(&kssj,'yyyy-mm-dd hh24:mi:ss')
                   and c.rq < to_date(&jssj,'yyyy-mm-dd hh24:mi:ss')     
                 ) m,
               gdmch.zy_t_yz z,
               gdmch.zy_t_brjbxx b
         where m.jyjcdh = z.addiencode and m.xh='1'
           and z.lsh = b.lsh)
           where cxf = '1' and kdks = '0245'
           and bbjsr_qmxx is null
 group by kdks 
) a
join gdmch.rl_T_keshiku b on a.kdks = b.ksbm

--标本采集统计
select ksmc 科室名称,ksbm 科室编码,count(*) 应执行数,sum(aa) 实际执行数
from (
select k.ksmc,k.ksbm ,case when b.patient_id is null then 0 else 1 end  aa
from mcs_order_schedule b right join
gdmch.v_ewell_inpatient_lis_order_al@his_db d on  d.bar_code=b.bar_code -- and d.patient_id=b.patient_id and d.admission_id=b.mrn
left join gdmch.rl_t_keshiku@his_db k on k.ksbm=d.kcks
where d.start_date>=To_date('2022-06-01 00:00:01','YYYY-MM-DD Hh24:Mi:SS')
and d.start_date<To_date('2022-09-20 00:00:01','YYYY-MM-DD Hh24:Mi:SS')
and (d.kcks<>'0075' and d.kcks<>'0094')
and d.cxf = '0'
--and d.bar_code like '0222%'
)
group  by ksmc,ksbm

--标本采集具体项目未执行
select k.ksmc, d.item_name,count(d.item_name)
from gdmch.v_ewell_inpatient_lis_order_al@his_db d left join gdmch.rl_t_keshiku@his_db k on k.ksbm=d.kcks
where bar_code not in(select bar_code from mcs_order_schedule)
and d.start_date>=To_date('2022-06-01 00:00:01','YYYY-MM-DD Hh24:Mi:SS')
and d.start_date<To_date('2022-09-20 00:00:01','YYYY-MM-DD Hh24:Mi:SS')
and (d.kcks<>'0075' and d.kcks<>'0094')
and d.cxf = '0'
and item_name not like '%粪%'
and item_name not like '%尿%'
group by d.item_name,k.ksmc
order by k.ksmc

--------------------------------------------------------------
--门诊
Select a.xmbm 项目编码,a.sfmc 收费名称 ,b.ksmc 科室名称,sum(a.ysje) 金额,sum(a.shuliang) 数量
From gdmch.mz_T_sfjl  a,gdmch.rl_T_keshiku  b
Where  a.zt = '1'
and a.kcfks=b.ksbm
--and a.kcfks = '0089'
and a.xmbm in(
'310100016',
'310100016E',
'310100020-1'
)
And a.rq >= to_date('2022-01-01', 'yyyy-mm-dd')
And a.rq < to_date('2022-12-31', 'yyyy-mm-dd') + 1
group by  a.xmbm,a.sfmc,b.ksmc
order by b.ksmc,a.xmbm



--住院
Select  a.xmbm 项目编码,a.sfmc 项目名称,b.ksmc 科室,sum(a.ysje) 总金额,sum(a.shuliang) 数量
From (Select *
From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a,gdmch.Rl_t_Keshiku b
Where (a.zt = '0' Or a.zt = '1')
and a.zxrq is not null
and  a.kcks=b.ksbm
--and a.kcks = '0075'
and a.xmbm in(
'310100016',
'310100016E',
'310100020-1'
)
And a.rq >= to_date('2022-01-01', 'yyyy-mm-dd')
And a.rq < to_date('2022-12-31', 'yyyy-mm-dd') + 1
group by  a.xmbm,a.sfmc,b.ksmc
order by b.ksmc,a.xmbm


--门诊人次
Select a.xmbm 项目编码,a.sfmc 收费名称,count(distinct a.mzh) 人次
From gdmch.mz_T_sfjl  a,gdmch.rl_T_keshiku  b
Where  a.zt = '1'
and a.kcfks=b.ksbm
--and a.kcfks = '0089'
and a.xmbm in(
'1263000018',
'1263000024',
'1333000017',
'1102000047',
'1000000014',
'1102000136'
)
And a.rq >= to_date('2022-01-01', 'yyyy-mm-dd')
And a.rq < to_date('2022-12-31', 'yyyy-mm-dd') + 1
group by  a.xmbm,a.sfmc
order by a.xmbm

--出入院病人统计
select (select bqmc from gdmch.bc_T_bqbh where bqbh = t.bqbh) bq,
       sum(ryrs)
  from gdmch.Zy_t_Bfgzrb_t t
 where sbc >= '2022-06-13'
	and sbc <= '2022-06-19'
  group by bqbh

--消化内科202106-202209息肉诊断禁食医嘱病人列表
select d.brxm 姓名,d.bah 病案号,c.lsh 流水号,c.rq 日期,c.value 诊断,c.itemname 医嘱,c.ward 科室
from
(select a.lsh,a.rq,a.value,b.itemname,b.ward from gdmch.zy_t_zyzd a join gdmch.zy_t_yz b on a.lsh = b.lsh
where (a.value like '%肠息肉%' or a.value like '%胃息肉%')
and b.itemname like '%禁食%'
and a.rq > to_date('2021-06-01', 'yyyy-mm-dd')
and a.rq <=  to_date('2022-09-01', 'yyyy-mm-dd')
and b.dept = '0043'
order by a.rq desc) c join gdmch.zy_t_brjbxx d on c.lsh = d.lsh


--粪常规
select count(*) from gdmch.zy_T_cyqdjl a
where a.rq >= to_date('2022-01-01', 'yyyy-mm-dd')
and a.rq <  to_date('2022-09-01', 'yyyy-mm-dd')
and sfmc like '%粪%'
and (zxks = '0024' or kcks = '0024')
and zt = 1

--口腔科2022年全年14岁以下的门诊病人的人次
select count(distinct mzh) from gdmch.mz_t_ghxx a left join gdmch.mz_t_brjbxx b on a.blh = b.blh
where a.jzrqsj >= to_date('2022-01-01', 'yyyy-mm-dd')
and a.jzrqsj <  to_date('2023-01-01', 'yyyy-mm-dd')
and ghks = '0059'
and (a.jzrqsj - b.csrq)/356 < 14


select (a.jzrqsj - b.csrq)/365 from gdmch.mz_t_ghxx a left join gdmch.mz_t_brjbxx b on a.blh = b.blh
where a.jzrqsj >= to_date('2022-01-01', 'yyyy-mm-dd')
and a.jzrqsj <  to_date('2023-01-01', 'yyyy-mm-dd')
--and ghks = '0059'
and a.blh = '2001072427'

--每月统计出院床位数
select count(distinct lsh) from gdmch.zy_T_cyqdjl a
where a.rq >= to_date('2023-02-01', 'yyyy-mm-dd')
and a.rq <  to_date('2023-03-01', 'yyyy-mm-dd')
and xmbm = '110900003'

select distinct(sfxmbm),t.xmmc,t.sfbz from gdmch.bqcwxx a left join gdmch.cw_t_sfxm t on a.sfxmbm = t.xmbm

--每月统计ICU人数
select sum(b.tcrq - zrrq) from gdmch.zy_t_zyqk a left join gdmch.bc_t_cwjl b on a.lsh = b.zyh
where a.cykb != '0075'
and a.cysj >= to_date('2023-03-01', 'yyyy-mm-dd')
and a.cysj <  to_date('2023-04-01', 'yyyy-mm-dd')
and b.bqbh = '01'

--住院诊断
select * from gdmch.zy_t_zyzd
where value like '%帕金森%'
order by rq desc

--申请查询2021年、2022年、2023年每年1月、2月静疗专科护理门诊接诊量，出诊人员包括:吴军、陈梦瑾、李海香、罗红梅、崔伟燕、袁小英、姚孟冬。
select x.xm 姓名,y.num 一月与二月总接诊量 from gdmch.rl_t_ygk x right join 
(select ysgh,count(distinct mzh) num from gdmch.mz_t_ghxx a
where ghks = '0319'
and a.jzrqsj >= to_date('2023-01-01', 'yyyy-mm-dd')
and a.jzrqsj <  to_date('2023-03-01', 'yyyy-mm-dd')
and ysgh in (select lsh from gdmch.rl_t_ygk where xm in (
'吴军',
'陈梦瑾',
'李海香',
'罗红梅',
'崔伟燕',
'袁小英',
'姚孟冬'
))
group by ysgh) y on y.ysgh = x.lsh

--2018-2022执行科室为内分泌的特定医嘱
select extract(year from zxrq) 年份,count(*) 收费数量 from (Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl)
where zxrq >= to_date('2018-01-01', 'yyyy-mm-dd')
and zxrq <= to_date('2022-12-31', 'yyyy-mm-dd')
and zt = '1'
and zxks = '4000'
and xmbm in ('120600004',
'120600003',
'120600002',
'120600001',
'121800001S-2',
'121800001S-3',
'121800001S-4',
'120500004S',
'311400027',
'220400002',
'310100015',
'121800002F/1',
'121800002F/2',
'121800002F/3',
'121800003F/1',
'121800003F/2',
'121800003F/3',
'121800003F/4',
'120500001-2',
'120500002-2',
'120500003-2'
)
group by extract(year from zxrq)

--除ICU以外，收了重症床位的总天数，2022年全年的
select count(*) from (Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl)
where xmbm = '110900002-1'
and zt in ('1','0')
and rq >= to_date('2022-01-01', 'yyyy-mm-dd')
and rq < to_date('2023-01-01', 'yyyy-mm-dd')
and kcks != '0075'

--2021.05.01-2022.06.01脊柱骨科医保患者：预冲式导管冲洗器5ml、会阴冲洗统计费用。查询理由：因飞检医保检查，需要统计科室收费含有预冲式导管冲洗器5ml、会阴冲洗2个项目的患者明细。
select b.brxm 姓名,b.sfzh 证件号码,b.bah 住院号,b.name 人员类别,b.place_dic_val_name 参保地,case b.ybbrlx when '0' then '居民' else '职工' end 险种,b.rysj 入院时间,b.cysj 出院时间,'住院' 医疗类别,a.sfmc 扣款项目,a.sfje 减扣金额 from 
(Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a left join 
(select ttt.*,c.rysj,c.cysj from (select tt.*,e.place_dic_val_name from (select t.*,d.name from gdmch.zy_t_brjbxx t left join gdmch.mz_t_codes d on t.brlb2 = d.bm) tt left join gdmch.gzyb_t_mb e on tt.ybcbd = e.place_dic_val_code) ttt left join gdmch.zy_t_zyqk c on ttt.lsh = c.lsh) b
on a.lsh = b.lsh 
where a.rq >= to_date('2021-01-01', 'yyyy-mm-dd')
and a.rq < to_date('2023-07-31', 'yyyy-mm-dd') + 1
and a.zt in ('0','1')
and a.zxks = '0041'
and a.xmbm in ('300000000F-4')

select b.brxm 姓名,a.lsh 住院流水号,b.bah 住院号,a.rq 时间,a.kcks 开出科室,a.zxks 执行科室,a.sfmc 项目,a.sfje 金额,case a.zt when '0' then '未收费' when '1' then '已收费' end 收费情况 from 
(Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a left join gdmch.zy_t_brjbxx b on a.lsh = b.lsh
where a.rq >= to_date('2020-01-01', 'yyyy-mm-dd')
--and a.rq < to_date('2022-12-31', 'yyyy-mm-dd') + 1
and a.kcks = '0338'
and a.xmbm in ('121800001S-4')
and a.zt in ('0','1')

select * from (Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a left join gdmch.zy_t_brjbxx b on a.lsh = b.lsh
where a.rq >= to_date('2019-01-01', 'yyyy-mm-dd')
and a.rq < to_date('2022-12-31', 'yyyy-mm-dd') + 1
and a.zxks = '0338'
and a.xmbm in ('A4320107')
and a.zt in ('0','1')

--是否包药机
select count(*) from (Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a left join gdmch.yk_t_ypzl b on a.xmbm = b.ypbm
where b.sfbyj = 'N'
and zt in ('1','0')
and rq >= to_date('2023-01-01', 'yyyy-mm-dd')
and rq < to_date('2023-03-12', 'yyyy-mm-dd')

--开医嘱当日
select * from gdmch.zy_T_qdjl e join gdmch.Zy_t_Hstemp_hl f on e.sypl=f.plbm
join gdmch.zy_t_yz g on e.lsh=g.lsh and e.zfybm=g.yz_sn
where  e.lsh='2023-14316' and sfmc='盐酸氨溴索分散片'
and trunc(rq)=trunc(g.start_date)
and substr(f.zxsj,1,2)>=to_char(g.start_date,'hh24')
select sysdate,to_char(sysdate,'hh24') from dual

--其他日期
select 
count(*)
from gdmch.zy_T_qdjl e join gdmch.Zy_t_Hstemp_hl f on e.sypl=f.plbm
join gdmch.zy_t_yz g on e.lsh=g.lsh and e.zfybm=g.yz_sn
join gdmch.zy_t_brjbxx n on e.lsh=n.lsh
left join gdmch.yk_t_ypzl b on e.xmbm = b.ypbm
--left join mcs_order_schedule@ewell m on n.bah=m.patient_id and n.zycs=m.series and e.zfybm=m.his_order_id
where 
--e.lsh='2023-14316' and sfmc='盐酸氨溴索分散片'
 trunc(rq)!=trunc(g.start_date)
and b.sfbyj != 'Y'
and g.direction in ('2501','2502','2411')
and e.rq >= to_date('2023-01-01', 'yyyy-mm-dd')
and e.rq < to_date('2023-03-12', 'yyyy-mm-dd')

--儿科在院期间借床病人的耗材费用统计

--住院医生职称的统计
select extract(year from a.start_date) 年份,count(distinct a.lsh) 数量 from gdmch.zy_T_yz a left join gdmch.rl_t_ygk b on a.initial_doctor = b.lsh
where b.xm = '何萃' 
and a.start_date >= to_date('2019-01-01','yyyy-mm-dd')
and a.start_date < to_date('2023-06-30','yyyy-mm-dd')+1
group by extract(year from a.start_date)

select a.*,rowid from gdmch.bc_t_bqbh a

select * from gdmch.ksbqdy a left join gdmch.rl_t_keshiku b 

--现我科存在同时收取“后路腰椎间盘镜椎间盘髓核摘除术”＋“术中使用显微镜加收”的情况，此两项为冲突收费，不可同时收取，现想请您协助查询2020.12.15之今，同时存在此两项手术收费的病例。
select b.brxm,a.lsh,a.rq from (Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a left join gdmch.zy_t_brjbxx b on a.lsh = b.lsh
where a.rq >= to_date('2020-12-15', 'yyyy-mm-dd')
and a.kcks = '0338'
and a.zt in ('0','1')
and a.xmbm = '330000000-12'
and a.zfyxbm in (select zfyxbm from (Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a
where a.rq >= to_date('2020-12-15', 'yyyy-mm-dd')
and a.kcks = '0338'
and a.zt in ('0','1')
and a.xmbm = '331501040'
)

--在院人数（营养每月统计）
select count(distinct a.lsh) from gdmch.zy_t_brjbxx a left join gdmch.zy_t_zyqk b on a.lsh = b.lsh
where rysj < to_date('2024-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')--结束日期
and (cysj >= to_date('2023-12-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss') or cysj is null)--开始日期
and bah not like '%B%'
and rykb not in ('99')
group by 

--按月统计心理精神科门诊量


--科室字典
select a.*,rowid from gdmch.rl_t_keshiku a
where ksmc like '%小儿%'

select a.xmbm,count(*) from (Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a
where a.rq >= to_date('2022-01-01', 'yyyy-mm-dd')
and a.rq < to_date('2023-01-01','yyyy-mm-dd')
and a.zt in ('0','1')
and kcks != '0094'
and a.xmbm in ('310603004',
'310603001',
'310100001-2',
'310100014',
'330803023',
'311000011-1',
'121800003F/3',
'121800003F/2',
'121800003F/1',
'340200037',
'121900002S',
'121801127',
'120100012-1',
'310702001-2',
'340100030F',
'S0006354')
group by a.xmbm

--数据实战群里的门诊统计
select count(distinct a.mzh),a.zd,d.ksmc,a.zdcode from gdmch.mz_T_mzzd a,gdmch.rl_T_ygk c ,gdmch.Rl_t_Keshiku d
where a.created_date>=to_date('2022-12-01','yyyy-mm-dd')
and a.created_date<to_date('2023-11-30','yyyy-mm-dd')+1
and a.ysgh=c.lsh
and c.ksbm=d.ksbm
group by a.zd,d.ksmc,a.zdcode
order by d.ksmc

Select a.xmbm 项目编码,a.sfmc 收费名称 ,b.ksmc 科室名称,sum(a.shuliang) 数量
From gdmch.mz_T_sfjl  a,gdmch.rl_T_keshiku  b
Where  a.zt = '1'
and a.kcfks=b.ksbm
and a.kcfks = '0009'
and a.xmbm in(
'270300005',
'270300006',
'270800004',
'270800005',
'270800006',
'330201001',
'330605025',
'331305005',
'331602004',
'331602004'
)
And a.rq >= to_date('2022-12-01', 'yyyy-mm-dd')
And a.rq < to_date('2023-11-30', 'yyyy-mm-dd') + 1
group by  a.xmbm,a.sfmc,b.ksmc
order by b.ksmc,a.xmbm

Select  a.xmbm 项目编码,a.sfmc 项目名称,b.ksmc 科室,sum(a.shuliang) 数量
From (Select *
From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a,gdmch.Rl_t_Keshiku b
Where (a.zt = '0' Or a.zt = '1')
and a.zxrq is not null
and  a.kcks=b.ksbm
and a.kcks = '0075'
and a.xmbm in(
'330100013',
'310702016',
'310702017',
'310603001',
'310603002',
'310604005',
'120400004-1',
'120400010',
'12040011-3',
'120400012',
'310702002',
'310702002',
'310605003',
'310605006',
'311000011',
'311000011-1',
'120700001',
'120100015',
'121100002',
'121100002-1',
'120100011',
'310603004',
'120100010-1',
'120100010',
'330701005',
'310905035S',
'120300002',
'330100012',
'120200001',
'330803025',
'310601009-1'
)
And a.rq >= to_date('2022-12-01', 'yyyy-mm-dd')
And a.rq < to_date('2023-11-30', 'yyyy-mm-dd') + 1
group by  a.xmbm,a.sfmc,b.ksmc
order by b.ksmc
--门诊护士工作量统计
select max(c.xm) 姓名, a.ysgh 工号,count(distinct a.mzh) 门诊接诊量 from gdmch.mz_t_ghxx a left join gdmch.mz_t_ghsfjl b on a.mzh = b.mzh left join gdmch.Rl_t_ygk c on a.ysgh = c.lsh
where a.clbz != '1'
and b.sszj > 0
and c.xm in ('吴军','陈梦瑾','李海香','崔伟燕','罗红梅','袁小英')
and a.ghrqsj >= to_date('2022-12-01', 'yyyy-mm-dd')
and a.ghrqsj < to_date('2023-12-01', 'yyyy-mm-dd')
group by a.ysgh

select max(c.xm) 姓名, a.ysgh 工号,sum(a.ysje) 直接经济收入 from gdmch.mz_t_sfjl a left join gdmch.Rl_t_ygk c on a.ysgh = c.lsh
where a.zt = '1'
and c.xm in ('吴军','陈梦瑾','李海香','崔伟燕','罗红梅','袁小英')
and a.rq >= to_date('2022-12-01', 'yyyy-mm-dd')
and a.rq < to_date('2023-12-01', 'yyyy-mm-dd')
group by a.ysgh

select * from  gdmch.Rl_t_ygk
where xm in ('吴军','陈梦瑾','李海香','崔伟燕','罗红梅','袁小英')

--我要统计11月份，消化医学部的医生，在门诊跟住院部开的碳13呼气试验的单，按照各个医生来统计开单数量，门诊住院都要的哈
--门诊：
select b.xm,a.ysgh,count(*) from gdmch.mz_t_sfjl a left join gdmch.Rl_t_ygk b on a.ysgh = b.lsh
where a.xmbm in ('250700010-2','250700031F')
and a.zt in ('0','1')
and b.ksbm in ('0043','0513','0101','0115','0114','0454')
and a.rq >= to_date('2023-11-01', 'yyyy-mm-dd')
and a.rq < to_date('2023-12-31', 'yyyy-mm-dd') + 1
group by b.xm,a.ysgh
--住院：
select  b.xm 姓名,a.kcys 工号,count(*) 住院开单量 from
(Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a left join gdmch.Rl_t_ygk b on a.kcys = b.lsh
where a.xmbm = '250403079'
and a.zt in ('0','1')
and b.ksbm in ('0043','0513','0101','0115','0114','0454')
and a.rq >= to_date('2023-11-01', 'yyyy-mm-dd')
and a.rq < to_date('2023-12-01', 'yyyy-mm-dd') + 1
group by b.xm,a.kcys

--统计2022-6-1-2023-11-30胎儿医学中心 '250700010-2','250700031F'两项收费的数量及金额
select a.sfmc 收费名称,a.xmbm 项目编码,count(*) 数量,sum(a.ysje) 金额 from gdmch.mz_t_sfjl a left join gdmch.Rl_t_ygk b on a.ysgh = b.lsh
where a.xmbm in ('250700010-2','250700031F')
and a.zt in ('0','1')
and b.ksbm in ('0343')
and a.rq >= to_date('2022-06-01', 'yyyy-mm-dd')
and a.rq < to_date('2023-11-30', 'yyyy-mm-dd') + 1
group by a.sfmc,a.xmbm

--2022.12.1-2023.11-30统计呼吸内科住院的操作，谢谢
select sfmc 收费名称,xmbm 项目编码,count(*) 住院开单量 from
(Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a
where a.xmbm in (
'330100013',
'310702017',
'310603001',
'310603002',
'120300002',
'310604005',
'120400011-1',
'311000011',
'310605002'
)
and a.zt in ('0','1')
and a.kcks = '0092'
and a.rq >= to_date('2022-12-01', 'yyyy-mm-dd')
and a.rq < to_date('2023-11-30', 'yyyy-mm-dd') + 1
group by xmbm,sfmc


--心胸外科2022年1月1日至2023年7月31日个性化3D可视手术模型收费详情
select b.brxm 姓名,b.sfzh 证件号码,b.bah 住院号,b.name 人员类别,b.place_dic_val_name 参保地,case b.ybbrlx when '0' then '居民' else '职工' end 险种,b.rysj 入院时间,b.cysj 出院时间,'住院' 医疗类别,a.rq 收费时间,a.kcks 开出科室,a.kcys 开出医生工号,a.zxks 执行科室,a.sfmc 扣款项目,a.sfje 减扣金额 from 
(Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a left join 
(select ttt.*,c.rysj,c.cysj from (select tt.*,e.place_dic_val_name from (select t.*,d.name from gdmch.zy_t_brjbxx t left join gdmch.mz_t_codes d on t.brlb2 = d.bm) tt left join gdmch.gzyb_t_mb e on tt.ybcbd = e.place_dic_val_code) ttt left join gdmch.zy_t_zyqk c on ttt.lsh = c.lsh) b
on a.lsh = b.lsh
where a.rq >= to_date('2013-01-01', 'yyyy-mm-dd')
and a.rq < to_date('2023-12-07', 'yyyy-mm-dd') + 1
and a.zt in ('0','1')
and ((a.zxks in ('0046')) or (a.kcks in ('0046')))
and a.xmbm in ('110900001-4d','250203076')

select b.brxm 姓名,b.sfzh 证件号码,b.bah 住院号,b.name 人员类别,b.place_dic_val_name 参保地,case b.ybbrlx when '0' then '居民' else '职工' end 险种,b.rysj 入院时间,b.cysj 出院时间,'住院' 医疗类别,a.rq 收费时间,a.kcks 开出科室,a.kcys 开出医生工号,a.zxks 执行科室,a.sfmc 扣款项目,a.xmbm 项目编码,a.sfje 减扣金额 from 
(Select * From gdmch.zy_t_qdjl
Union All
Select * From gdmch.zy_t_cyqdjl) a left join 
(select ttt.*,c.rysj,c.cysj from (select tt.*,e.place_dic_val_name from (select t.*,d.name from gdmch.zy_t_brjbxx t left join gdmch.mz_t_codes d on t.brlb2 = d.bm) tt left join gdmch.gzyb_t_mb e on tt.ybcbd = e.place_dic_val_code) ttt left join gdmch.zy_t_zyqk c on ttt.lsh = c.lsh) b
on a.lsh = b.lsh
where a.rq >= to_date('2013-01-01', 'yyyy-mm-dd')
and a.rq < to_date('2023-12-07', 'yyyy-mm-dd') + 1
and a.zt in ('0','1')
and ((a.zxks in ('0046')) or (a.kcks in ('0046')))
and a.xmbm in ('110900001-4d','250203076')

--血培养送检统计
select h.*,i.start_time pda采样时间,i.executer_name PDA采样人员from
(select distinct f.yz_sn, c.bah 住院号,c.brxm 患者姓名,e.kcks 开出科室,a.jyjcdh 条码号,e.jcmc 检验项目,f.YBPS 出科扫描人员,f.psrq 出科扫描时间,
a.bbjsr_qmxx 检验科签收人员,a.bbjssj 检验科签收时间,b.bbjsr_qmxx 微生物室确认人员,b.bbjssj 微生物室确认时间
from gdmch.JY_T_CYXX a, gdmch.JY_T_CYXX_LOG b,gdmch.jy_t_detail d,gdmch.pacs_t_jc e,gdmch.jy_v_bb f,
(select * from gdmch.zy_t_qdjl union all select * from gdmch.zy_t_cyqdjl ) g,gdmch.zy_t_brjbxx c
where a.jyjcdh=b.jyjcdh  
and d.jyjcdh=e.jcdh
and e.jcdh=f.jyjcdh 
and a.jyjcdh=g.zfyxbm
and g.lsh=c.lsh 
and a.jyjcdh=d.jyjcdh
and d.rq>to_date ('2023-07-01','yyyy-mm-dd') 
and  d.rq<to_date ('2023-08-01','yyyy-mm-dd')
and d.bm in ('051108','051110','051111')) h  left join luna_mcs_gzey.mcs_order_schedule@ewell i on h.yz_sn = i.his_order_id
order by h.条码号

select distinct h.yz_sn ,c.bah 病案号，c.brxm 病人姓名, e.kcks 开出科室， a.jyjcdh 条码号 ,e.jcmc 项目,f.YBPS 出科扫描人员 ,f.psrq 出科扫描时间,
a.bbjsr_qmxx 检验科签收人员 ,a.bbjssj 检验科签收时间 ,
b.bbjsr_qmxx 微生物室确认人员 ,b.bbjssj  微生物室确认时间
from gdmch.JY_T_CYXX  a, gdmch.JY_T_CYXX_LOG b ,gdmch.jy_t_detail d,gdmch.pacs_t_jc e,gdmch.jy_v_bb f ,
(select * from gdmch.zy_t_qdjl union all select * from gdmch.zy_t_cyqdjl ) g,gdmch.zy_t_brjbxx c,gdmch.zy_t_yz h
where a.jyjcdh=b.jyjcdh  and  d.jyjcdh=e.jcdh
and e.jcdh=f.jyjcdh  and  h.addiencode=g.zfyxbm and 
a.jyjcdh=g.zfyxbm and g.lsh=c.lsh and 
a.jyjcdh=d.jyjcdh and d.rq>to_date ('2023-07-01','yyyy-mm-dd') and  d.rq<to_date ('2023-08-01','yyyy-mm-dd') 
and d.bm in ('051108','051110','051111') order by a.jyjcdh

  SELECT "ZY_T_QDJL"."SFMC",
         "ZY_T_QDJL"."SHULIANG",
         "ZY_T_QDJL"."GG",
         "ZY_T_QDJL"."LINGSHOUJ",
         "ZY_T_BRJBXX"."BRXM",
         "ZY_T_BRJBXX"."BAH",
         "ZY_T_QDJL"."RQ",
         '' A
    FROM (select * from zy_T_qdjl union select * from zy_T_cyqdjl) "ZY_T_QDJL","ZY_T_BRJBXX"
   WHERE ( "ZY_T_QDJL"."ZT" in ('0','1') ) AND  
			( "ZY_T_QDJL"."ITEMTYPE" ='XHP' ) AND  
         ( "ZY_T_QDJL"."BQBH" = ( '9L' ) ) AND  
         ( "ZY_T_QDJL"."BRDQKS" = decode('0496','99',"ZY_T_QDJL"."BRDQKS",'0496') ) AND  
         ( "ZY_T_QDJL"."ZXRQ" is not null ) AND
         ( "ZY_T_QDJL"."LINGSHOUJ" >='0' ) AND  
         ( "ZY_T_QDJL"."RQ" >= TO_DATE('2023.10.01','YYYY-MM-DD') ) AND  
			( "ZY_T_QDJL"."RQ" <= TO_DATE('2023.10.31','YYYY-MM-DD')+1 ) AND  
         ( "ZY_T_QDJL"."LSH" = "ZY_T_BRJBXX"."LSH" ) 
 
