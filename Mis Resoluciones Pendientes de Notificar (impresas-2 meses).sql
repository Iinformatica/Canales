select r.dboid, r.EXTERN_STRING, exp.informacion_adicional,  r.DESCRIPTION_PRC,  r.OBSERVATIONS, exp.dboid EXP_DBOID,rol_id 
from til_exp_actuaciones act, fwk_ad_resolution r, til_exp_act_notif ntf, notif nt, fwk_ad_propresolution prop, til_exp_expedientes exp
where act.dboid=r.exp_actuacion_id and ntf.exp_actuaciones_id=act.dboid and ntf.notif_id=nt.dboid and prop.dboid=r.propresol_id
and r.resolution_date >  add_months(sysdate,-2)
and exp.dboid=act.exp_expedientes_id and sendbypaper='T' and cancelled='F'
AND (R.STATUS=4 or r.status=14)
And ((select rol_id from til_exp_actuaciones where dboid=(select exp_actuacion_id from fwk_ad_propresolution where 
dboid=(select propresol_id from fwk_ad_resolution where dboid=r.dboid))) = (select DBOID from rolebw where holder=[%#V#SC_ACTORDBOID%]))
and rownum <= 15
order by r.extern_string

Cambio a:

select r.dboid, r.EXTERN_STRING, exp.informacion_adicional,  r.DESCRIPTION_PRC,  r.OBSERVATIONS, exp.dboid EXP_DBOID,rol_id 
from til_exp_actuaciones act, fwk_ad_resolution r, til_exp_act_notif ntf, notif nt, fwk_ad_propresolution prop, til_exp_expedientes exp
where act.dboid=r.exp_actuacion_id and ntf.exp_actuaciones_id=act.dboid and ntf.notif_id=nt.dboid and prop.dboid=r.propresol_id
and exp.dboid=act.exp_expedientes_id and sendbypaper='T' and cancelled='F'  and hasregout = 'T'  AND NOTIFIED ='F'
And ((select rol_id from til_exp_actuaciones where dboid=(select exp_actuacion_id from fwk_ad_propresolution where 
dboid=(select propresol_id from fwk_ad_resolution where dboid=r.dboid))) = (select DBOID from rolebw where holder=[%#V#SC_ACTORDBOID%]))
order by r.extern_string
