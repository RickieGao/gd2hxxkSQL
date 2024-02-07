--cdr�ĵ�
select PatientID,
       VisitID,
       patientid      AS InpNo,
       OrderNo        as ORDER_NO,
       UniqueID,
       ReportDateTime,
       ReportTitle,
       ReportContent,
       LastModifyTime as LAST_MODIFY_DATE_TIME,
       CA_Cert,
       CA_SignDate    as CA_SignData,
       CA_Org,
       ReportCount,
       UniqueID       as REQUEST_NO
  from luna_mcs_gzey.v_mcs_cdas_jh t
 where t.PatientID is not null
   and t.UniqueID is not null
      --and t.ReportDateTime >sysdate -1
   and T.patientID like '%566133%'
 order by last_modify_date_time desc
