Select fr.DBOID_DOCUMENTO DBOID, ex.dboid as expdboid, 
to_char(fr.FECHA,'dd/mm/yyyy'), 
fr.NOMBRE_DOC, fr.CATEGORIA, fr.ASUNTO, fr.ORIGEN, fr.INTERESADO, 
ac.fullname as Firmado_Por
from fwk_frealizv fr, til_exp_expedientes ex, actor ac 
where 
fr.ESTADO=4 and ac.dboid = fr.actor_id and
ex.ejercicio||'/'||ex.numero||'-'||ex.identificador=trim((CASE WHEN INSTR(fr.origen, ' ') = 0 THEN fr.origen ELSE SUBSTR(fr.origen,1,INSTR(fr.origen,' ')) END))
and fr.fecha > add_months(sysdate,-2)
and
fr.PROPIETARIO= (SELECT FULLNAME  FROM ACTOR WHERE DBOID= [%#V#SC_ACTORDBOID%])
group by fr.DBOID_DOCUMENTO, ex.dboid,to_char(fr.FECHA,'dd/mm/yyyy') , fr.NOMBRE_DOC, fr.CATEGORIA, fr.ASUNTO, fr.ORIGEN, fr.INTERESADO, ac.fullname
