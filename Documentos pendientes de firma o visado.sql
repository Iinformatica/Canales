SELECT ex.dboid as expdboid,fs.DBOID,fs.NOMBRE_DOCUMENTO,fs.FECHA_INICIO,
fs.ASUNTO,fs.ORIGEN, fs.INTERESADO, fs.CATEGORIA, fs.ASIGNADO_A
from fwk_fsolicv fs, til_exp_expedientes ex
WHERE fs.ESTADO=2 and
ex.ejercicio||'/'||ex.numero||'-'||ex.identificador=trim((CASE WHEN INSTR(fs.origen, ' ') = 0 THEN fs.origen ELSE SUBSTR(fs.origen,1,INSTR(fs.origen,' ')) END))
//and rownum <= 15
//and fs.dboid_propietario = [%#V#SC_ACTORDBOID%]


