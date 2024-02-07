--病人转科的相关处理
/*医生开了条转科医嘱 zy_t_brzkxx中就会有相关的一条记录，如果zcsj是填了
则说明护士完成转出操作， 同时zy_t_zkjl增加一条记录；如果zrsj填了则转入科室护士完成了操作，同时bqcwxx
中该流水号的的床位记录中的病区bqbh是改为转入科室编号 ，床位号也是转入科室床位号；

如果zy_t_brzkxx 中的zcsj 未填，且在原科室的床位未分配中能看见该病人，则说明该护士是直接停床而未转科
*/
--首先要在转入科室停床
select * from gdmch.zy_t_brjbxx where bah='640654';
/*查询流水号*/

select b.*,b.rowid from gdmch.Zy_t_Zyqk b where lsh in ('2023-92294');
--出院科室CYKB改为前住院科室编码或当前科室

select z.lsh,z.itemname,z.start_date,z.remark,z.rowid from gdmch.zy_t_yz  z where z.lsh in ('2023-92294') and z.Itemname='记事' and z.remark like '%转%'  
/*删除转科记事医嘱*/

select b.*,b.rowid from gdmch.zy_t_brzkxx b where lsh in ('2023-92294')order by zrsj;-- for update --转科信息表
/*删除转科信息*/

select b.*,b.rowid from gdmch.Zy_t_Zkjl b where lsh  in ('2023-92294'); --for update  --转科记录
/*删除转科记录表的ZYKS为转入科室的记录 并把ZYKS为转出科室的记录中ZCSJ清空*/  如果是没分配床位的，清除ZCSJ即可。

select k2.*,k2.rowid from gdmch.zy_t_zyqk k2 where k2.lsh  in ('2023-92294') ; --for update
/*把出院科室改为转科前科室编码*/ FPCWBZ要改为1，1=已经分配

select b.*,rowid from gdmch.bqcwxx B where B.ZYZYH='2023-92294'
--从Select * From  gdmch.bc_t_cwjl  Where zyh='2017-28303' 中找出之前的床位是多少，然后在gdmch.bqcwxx补上ZYZYH，并把ZTBZ改为1。



--以上步骤完成即可

select * from gdmch.bqcwxx B where B.ZYZYH='2023-68141'

select * from gdmch.bqcwxx where/* zyzyh is null and*/ ztbz=0 and bqbh=29 and mrdj =43 ;--for update--病区床位信息 ，ztbz =1 为占用


select * from gdmch.bc_t_bqbh where bqbh='48';  --病区于科室对应表

select * from gdmch.rl_T_keshiku where ksbm='0350';  48
