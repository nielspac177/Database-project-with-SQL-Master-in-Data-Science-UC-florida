----RESPUESTAS A PREGUNTAS (CODIGO SQL)

---PREGUNTA 01        ¿Cuántas incidencias han sido registradas en el año 2023?
select count(Id_Incidencia) as Cant_Incidencia from grupo03.incidencia where year(Fecha_Hora_Registro) = '2023'

---PREGUNTA 02        ¿Qué secciones de registros de mantenimiento se han reportado con mayor incidencia en todo el año 2023?
select
count(T3.Id_Reg_Mantenimiento) as Cant_Registro,
T2.Seccion
from grupo03.Detalle_Reg_Mantenimiento T0
-----------------------------------
inner join grupo03.Categoria T1 on 
T0.Id_Categoria = T1.Id_Categoria
-----------------------------------
inner join grupo03.Seccion T2 on 
T1.Id_Seccion = T2.Id_Seccion
-----------------------------------
inner join grupo03.Reg_Mantenimiento T3 on
T0.Id_Reg_Mantenimiento = T3.Id_Reg_Mantenimiento
-----------------------------------
inner join grupo03.Incidencia T4 on
T3.Id_Incidencia = T4.Id_Incidencia
-----------------------------------
where 
year(Fecha_Hora_Registro) = '2023'
group by
T2.Seccion
order by Cant_Registro desc

---PREGUNTA 03        ¿Qué categorías han sido más frecuentes en el registro de mantenimiento del año 2023?
select
T1.Categoria,
count(T3.Id_Reg_Mantenimiento) as Cant_Registro
from grupo03.Detalle_Reg_Mantenimiento T0
-----------------------------------
inner join grupo03.Categoria T1 on 
T0.Id_Categoria = T1.Id_Categoria
-----------------------------------
inner join grupo03.Reg_Mantenimiento T3 on
T0.Id_Reg_Mantenimiento = T3.Id_Reg_Mantenimiento
-----------------------------------
where 
year(T3.Fecha_Hora_Inicial_Reparacion) = '2023'
group by
T1.Categoria

---PREGUNTA 04        ¿Cual es el tiempo max. en minutos, entre el registro incidencia y la hora inicial del mantenimiento,por tecnico en el año 2023?
select top 1
T2.Nombre + ' ' + T2.Apellido 'Tecnico',
Max(DATEDIFF(MINUTE, Fecha_Hora_Registro, Fecha_Hora_Final_Reparacion)) AS tiempo_minimo_reparacion
from grupo03.Reg_Mantenimiento T0
-----------------------------------
inner join grupo03.Incidencia T1 on
T0.Id_Incidencia = T1.Id_Incidencia
-----------------------------------
inner join grupo03.Tecnico T2 on 
T1.Id_Tecnico = T2.Id_Tecnico
-----------------------------------
where 
YEAR(Fecha_Hora_Inicial_Reparacion) = 2023
group by 
T2.Nombre, T2.Apellido

---PREGUNTA 05        ¿Cuál ha sido el repuesto más caro en la reparación de mantenimiento en todo el año 2023?
select top 1
T1.Nombre,
Max(T1.Precio) As Mas_Caro,
count(T0.Id_Reg_Mantenimiento) Veces
from grupo03.Detalle_Reg_Mantenimiento T0
-----------------------------------
inner join grupo03.Repuestos T1 on 
T0.Id_Repuesto = T1.Id_Repuesto
-----------------------------------
inner join grupo03.Reg_Mantenimiento T3 on
T0.Id_Reg_Mantenimiento = T3.Id_Reg_Mantenimiento
-----------------------------------
where 
year(Fecha_Hora_Inicial_Reparacion) = '2023'
group by
T1.Nombre,
T1.Precio,
T0.Id_Reg_Mantenimiento
order by 
T1.Precio desc

---PREGUNTA 06        ¿Cuánto tiempo mínimo se demora en realizar la reparación de una maquina en el registro de mantenimiento expresado en minutos en el año 2023?
select top 1
T2.Maquina,
DATEDIFF(MINUTE, Fecha_Hora_Inicial_Reparacion, Fecha_Hora_Final_Reparacion) AS tiempo_minimo_reparacion
from grupo03.Reg_Mantenimiento T0
-----------------------------------
inner join grupo03.Incidencia T1 on
T0.Id_Incidencia = T1.Id_Incidencia
-----------------------------------
inner join grupo03.Maquina T2 on 
T1.Id_Maquina = T2.Id_Maquina
-----------------------------------
where 
YEAR(Fecha_Hora_Inicial_Reparacion) = 2023
ORDER BY
DATEDIFF(MINUTE, Fecha_Hora_Inicial_Reparacion, Fecha_Hora_Final_Reparacion) 

---PREGUNTA 07        ¿Cuales son las 3 máquinas que han generado más reportes de incidencias en el año 2023?
select top 3 
T1.Maquina,
counT(distinct T0.Id_Incidencia) as Cant_Registro
from grupo03.Incidencia T0
inner join grupo03.Maquina T1 on 
T0.Id_Maquina = T1.Id_Maquina
where 
year(Fecha_Hora_Registro) = '2023'
group by
T1.Maquina
order by 
Cant_Registro desc

---PREGUNTA 08        ¿Cuales son las 3 máquinas que han generado menos reportes de incidencias en el año 2023?
select top 3
T1.Maquina,
counT(T0.Id_Incidencia) as Cant_Registro
from grupo03.Incidencia T0
---------------------------------
inner join grupo03.Maquina T1 on 
T0.Id_Maquina = T1.Id_Maquina
---------------------------------
where 
year(Fecha_Hora_Registro) = '2023'
group by
T1.Maquina
order by 
Cant_Registro asc

---PREGUNTA 09        ¿Cuales son los 3 respuestos que mas se han utilizado en los mantenimientos en el primer trimestre del año 2023?
select top 3
T1.Nombre,
counT(T0.Id_Detalle_Reg_Mantenimiento) as Cant_Utilizada
from grupo03.Detalle_Reg_Mantenimiento T0
-----------------------------------
inner join grupo03.Repuestos T1 on 
T0.Id_Repuesto = T1.Id_Repuesto
-----------------------------------
inner join grupo03.Reg_Mantenimiento T2 on
T0.Id_Reg_Mantenimiento = T2.Id_Reg_Mantenimiento
-----------------------------------
inner join grupo03.Incidencia T3 on
T2.Id_Incidencia = T3.Id_Incidencia
-----------------------------------
where 
year(Fecha_Hora_Inicial_Reparacion) = '2023' and
DATEPART(QUARTER, T2.Fecha_Hora_Inicial_Reparacion) = '1'
group by
T1.Nombre 
order by
Cant_Utilizada desc

---PREGUNTA 10        ¿Cual ha sido el monto total invertido en repuestos durante cada uno de los trimestre del anio 2023?
select 
DATEPART(QUARTER, T3.Fecha_Hora_Inicial_Reparacion) AS trimestre,
sum(T1.Precio) as total_invertido
from grupo03.Detalle_Reg_Mantenimiento T0
-----------------------------------
inner join grupo03.Repuestos T1 on 
T0.Id_Repuesto = T1.Id_Repuesto
-----------------------------------
inner join grupo03.Reg_Mantenimiento T3 on
T0.Id_Reg_Mantenimiento = T3.Id_Reg_Mantenimiento
-----------------------------------
inner join grupo03.Incidencia T4 on
T3.Id_Incidencia = T4.Id_Incidencia
-----------------------------------
where 
year(T3.Fecha_Hora_Inicial_Reparacion) = '2023'
group by
DATEPART(QUARTER, T3.Fecha_Hora_Inicial_Reparacion)