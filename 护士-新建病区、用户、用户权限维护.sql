---------------------------------------------------新建病区流程---------------------------------------------------
--his数据库操作：

--1.his添加病区字典添加病区
select a.*,rowid from gdmch.bc_t_bqbh a
--2.his维护病区科室对应
select a.*,rowid from gdmch.ksbqdy a
where keshi  in ('0041','0524','0362')
where bqbh = '9S'

select a.*,b.bqmc from
(select a.*,b.ksmc from gdmch.ksbqdy a left join gdmch.rl_t_keshiku b on a.keshi = b.ksbm) a left join gdmch.bc_t_bqbh b on a.bqbh = b.bqbh
--3.his维护科室病区一对一对应
select a.*,rowid from gdmch.ksbqydydy a
where bqbh in ('90')
where ksbm in ('0041','0524','0362')

select distinct(bqbh) from gdmch.ksbqydydy a
--4.his维护共用护理单元（如有）
select a.*,rowid from gyhldy a
where zks = '0042'
--5.新建病区日报加一条数据
select t.*,t.rowid from gdmch.Zy_t_Bfgzrb_t t 
where ksbm = '0041'
--where bqbh = '9N'
--and bqbh = '9O'
and sbc ='2024-01-10';

insert into gdmch.Zy_t_Bfgzrb_t
select '2024-01-16',bqbh,ksbm,'0','0','0','0','0','0','0','0','0','0',sysdate - 1,'','','0','0','0','0','0','0','' from gdmch.ksbqydydy
where ksbm in ('0525','0526')
--移动护理数据库操作：

--1.病区科室字典添加病区
select a.*,rowid from MCS_MSYS_DEPT_WARD a
where name like '%眼科%'
where code in ('0041','0524','0362')
--1.或直接同步his未添加的病区
insert into mcs_msys_dept_ward
select bqbh,bqmc,'','','','','0','','','' from gdmch.bc_t_bqbh@his_db
where bqbh not in (select code from mcs_msys_dept_ward)

--批量添加科室
insert into mcs_msys_dept_ward
select ksbm,ksmc,'','','','','1','','','' from gdmch.rl_t_keshiku@his_db
where ksbm in ('0524','0525','0526')
--2.授权病区相关权限，jsp界面授权


---------------------------------------------------新建用户与权限分配流程---------------------------------------------------
--护理管理系统：1.人员按模板导入；2.开通菜单权限

--his数据库操作：
--his权限分配（维护好病区权限、共用护理单元和病区科室一对一后）
insert into gdmch.Ks_t_bqqx t
select a.lsh,a.fks,b.bqbh,'HS','0593',sysdate from 
(select lsh,b.fks from gdmch.rl_t_ygk a left join gyhldy b on a.ksbm = b.zks
where a.ksbm in (select keshi from gdmch.ksbqdy) 
and a.lsh in (
'T372'
)
--and a.ksbm  = '0339'
) a
left join gdmch.ksbqydydy b on a.fks = b.ksbm
where fks is not null
and bqbh is not null 
and (a.lsh,a.fks,b.bqbh) not in (select ygh,ksbm,bqbh from gdmch.Ks_t_bqqx)

--移动护理数据库操作：
--1.根据工号批量添加用户
insert into mcs_sys_users
select mcs_sys_user_id.nextval,lsh,xm,'c4ca4238a0b923820dcc509a6f75849b','','NURSE','','1','0','' from gdmch.rl_t_ygk@his_db 
where lsh in (
'Q830',
'Q832',
'Q829',
'R742',
'Q827',
'Q081',
'S165'
)
--2.为用户分配“普通护士”角色
insert into mcs_sys_user_roles
select id,'4' from mcs_sys_users
where user_code in (
'Q830',
'Q832',
'Q829',
'R742',
'Q827',
'Q081',
'S165'
)
--3.同步his护士工作站权限
insert into mcs_sys_user_wards
select b.id,
a.bqbh
from gdmch.Ks_t_bqqx@his_db a left join mcs_sys_users b on a.ygh = b.user_code
where a.ygh in (
'T372'
)
--4.验证护士病区权限
select b.user_name,b.user_code,c.name from mcs_sys_user_wards a join mcs_sys_users b on a.user_id = b.id left join MCS_MSYS_DEPT_WARD c on a.ward_code = c.code
where b.user_code in (
'T372')

---------------------------------------------------其他相关操作---------------------------------------------------
--其他相关操作-his数据库：
--护士病区权限
select a.*,b.bqmc from gdmch.Ks_t_bqqx a left join gdmch.bc_t_bqbh b on a.bqbh = b.bqbh
where YGH in ('T372')

select a.*,rowid from gdmch.Ks_t_bqqx a
where YGH = '0350'

--删除护士科室病区权限
delete from gdmch.Ks_t_bqqx
where ygh not in ('0167',
'0347',
'0350',
'T781',
'T103',
'T619',
'T937',
'T946',
'R069','0593')
and ksbm = '0496'

--根据科室名称添加科室对应的病区权限
insert into gdmch.Ks_t_bqqx t
select 'T372',a.ksbm,bqbh,'HS','0593',sysdate from gdmch.ksbqydydy a left join gdmch.rl_t_keshiku b on a.ksbm = b.ksbm 
where b.ksmc like '%消化内%'

insert into gdmch.Ks_t_bqqx t
select ygh,'0045','04','HS','0593',sysdate from 
(select ygh from gdmch.Ks_t_bqqx where bqbh = '03')

--给科室人员批量添加病区权限
insert into gdmch.Ks_t_bqqx t
select lsh,'0496','9L','HS','0593',sysdate from gdmch.rl_t_ygk
where lsh in ('0167',
'T619',
'T937',
'T946',
'R069')
where ksbm = '0045'

--给一个病区的人员添加另一个病区的权限
insert into gdmch.Ks_t_bqqx
select ygh,'0007','9P','HS','0593',sysdate from gdmch.Ks_t_bqqx
where ksbm = '0007'
and bqbh = '15'

--根据工号批量修改科室
update  gdmch.Rl_t_ygk set ksbm='0025'
where lsh in
('0593'
)
--根据姓名批量修改科室
update  gdmch.Rl_t_ygk set ksbm='0025'
where xm in
('余宏霞'
)

--删除护士科室病区权限
delete from gdmch.Ks_t_bqqx
where ygh in ('0167',
'0347',
'0350',
'T781',
'T103',
'T619',
'T937',
'T946',
'R069')
and ksbm = '0432'

--根据科室名称添加科室对应的病区权限
insert into gdmch.Ks_t_bqqx t
select '0593',keshi,bqbh,'HS','0593',sysdate from gdmch.ksbqydydy a left join gdmch.rl_t_keshiku b on a.keshi = b.ksbm 
where b.ksmc like '%神经外%'

insert into gdmch.Ks_t_bqqx t
select ygh,'0045','04','HS','0593',sysdate from 
(select ygh from gdmch.Ks_t_bqqx where bqbh = '03')

--给科室人员批量添加病区权限
insert into gdmch.Ks_t_bqqx t
select lsh,'0348','57','HS','0593',sysdate from gdmch.rl_t_ygk
where lsh in ('0228',
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
'0242')
where ksbm = '0045'

--给一个病区的人员添加另一个病区的权限
insert into gdmch.Ks_t_bqqx
select 'T372','0043','10','HS','0593',sysdate from gdmch.Ks_t_bqqx
where ksbm = '0007'
and bqbh = '15'

--护士权限批量添加
insert into gdmch.Ks_t_bqqx t
select a.lsh,a.fks,b.bqbh,'HS','0593',sysdate from 
(select lsh,b.fks from gdmch.rl_t_ygk a left join gyhldy b on a.ksbm = b.zks
where a.ksbm in (select keshi from gdmch.ksbqdy) 
and a.lsh in (
'Q427',
'Q440',
'Q441',
'Q430',
'Q492',
'Q490',
'Q443',
'R596'
)
--and a.ksbm  = '0339'
) a
left join ksbqydydy b on a.fks = b.ksbm
where fks is not null
and bqbh is not null
and (a.lsh,a.fks,b.bqbh) not in (select ygh,ksbm,bqbh from gdmch.Ks_t_bqqx)

--根据工号批量修改科室
update  gdmch.Rl_t_ygk set ksbm='0025'
where lsh in
('0593'
)
--根据姓名批量修改科室
update  gdmch.Rl_t_ygk set ksbm='0025'
where xm in
('余宏霞'
)

--报表查询
select distinct decode(jl.xmbm,
                          '120100002',
                          'TJ',
                          '120100003',
                          'YJ',
                          '120100004',
                          'EJ') lx,
                   jl.xmbm,
                   jl.lsh
  from bc_T_cwjl, zy_T_brjbxx,(select * from zy_T_qdjl union select * from zy_T_cyqdjl ) jl
 where bc_T_cwjl.zrrq <= :s_date2 and nvl(bc_T_cwjl.tcrq, sysdate) >= :s_date2
   and bc_T_cwjl.bqbh = :s_bqbh
   and bc_T_cwjl.bz in('转床','占用')
   and bc_T_cwjl.zyh = zy_T_brjbxx.lsh
   and jl.lsh = zy_T_brjbxx.lsh
   and substr(zy_T_brjbxx.bah,1,1) <> 'B'
   and jl.xmbm in ('120100002', '120100003', '120100004')
   and jl.rq >= trunc(:s_date2)
   and jl.rq < trunc(:s_date2) +1
   and jl.zt in ('0', '1')
   and jl.bqbh = :s_bqbh


select a.*,rowid from gdmch.Ks_t_bqqx a
where ksbm = '0347'
and bqbh = '58'

--其他相关操作-移动护理：
--护士病区权限
select a.*,rowid from mcs_sys_user_wards a
where user_id = 'Q141'
and ward_code = '0N'

--护士病区权限查询
select b.user_name,b.user_code,c.name from mcs_sys_user_wards a join mcs_sys_users b on a.user_id = b.id left join MCS_MSYS_DEPT_WARD c on a.ward_code = c.code
where b.user_code = 'Q766'

select a.*,rowid from mcs_sys_users a
where user_code  in (
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

--删除表里的重复数据
delete from mcs_sys_user_wards where (user_id,ward_code) in (select user_id,ward_code from mcs_sys_user_wards a
group by user_id,ward_code having count(*)>1)
and rowid not in
(select max(rowid) from mcs_sys_user_wards a
group by user_id,ward_code having count(*)>1)
