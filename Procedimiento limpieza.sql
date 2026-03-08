--revisar que vin de purchases no están en sales--

select p.vin
from core.limpio_raw_purchases_vehicles p
left join core.sales_invoices_limpia s
 on s.vin=p.vin
where s.vin is null


--Revisión de llaves que no pueden estar duplicadas en purchases--

SELECT COUNT(*) AS llaves_duplicadas
FROM (
  SELECT vin
  FROM core.limpio_raw_purchases_vehicles
  GROUP BY vin
  HAVING COUNT(*) > 1
) d;


--Revisión de llaves que no pueden estar duplicadas en Sales--
SELECT COUNT(*) AS llaves_duplicadas
FROM (
  SELECT vin
  FROM core.sales_invoices_limpia
  GROUP BY vin
  HAVING COUNT(*) > 1
) d;

select count(*) as llave_duplicada
from(
select facturaid
from core.sales_invoices_limpia
group by facturaid
having count(*)>1
)d;


SELECT COUNT(*) AS llaves_duplicadas
FROM (
  SELECT facturaid,vin
  FROM core.sales_invoices_limpia
  GROUP BY facturaid,vin
  HAVING COUNT(*) > 1
) d;

--Revisión de tipo--
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'core'
  AND table_name   = 'sales_invoices_limpia'
ORDER BY ordinal_position;
-- Lo siguiente solamente si columna facha no está en formato date, en caso de sales_invoices_limpia ya estan todos los campos limpias--
--La tabla que original venía con mas columnas sucias , para no perder ese repaldo se creo la tabla limpia en la sección core con un creat table en cual se le hicieron todos lo cambios--
--A modo de ejemplo mostraré como transforme la columna fecha a date y preciolista a numeric.
-- Revion de cuantos campos de la columna fecha no se pueden covertir a date--
SELECT COUNT(*) AS fechas_fallidas
FROM core.sales_invoices_limpia
WHERE (fechaventa IS NOT NULL AND btrim(fechaventa::text) <> '')
  AND core.try_parse_date(fechaventa::text) IS NULL;

-- En caso de no estar en date y que todos campos se pueden tranformar realizamos lo sisguiente


ALTER TABLE core.sales_invoices_limpia
  ALTER COLUMN fechaventa TYPE date
  USING core.try_parse_date(fechaventa::text);

--Ahora revisamos si hay campos que no se puedan transformar a numeric con preciolista
SELECT COUNT(*) AS preciolista_fallidos
FROM core.sales_invoices_limpia
WHERE (preciolista IS NOT NULL AND btrim(preciolista::text) <> '')
  AND core.parse_amount(preciolista::text) IS NULL;

--Por último en caso de ser necesario transformar la columna numeric.
SELECT COUNT(*) AS preciolista_fallidos
FROM core.sales_invoices_limpia
WHERE (preciolista IS NOT NULL AND btrim(preciolista::text) <> '')
  AND core.parse_amount(preciolista::text) IS NULL;

--En caso de que hayan datos sucios con símbolos o letra columna numeric, enteror o decimales-


SELECT regexp_replace(anovehiculo, '[^0-9,.\-]', '', 'g') AS solo_numeros
FROM core.sales_invoices_limpia;

--Tranformar la columna VIN formato Mayuscula y sin espacios--
UPDATE core.sales_invoices_limpia
SET vendedor = UPPER(BTRIM(vendedor));

-- Garantía de coherencia
ALTER TABLE core.sales_invoices_limpia
  ADD CONSTRAINT chk_sales_cuadra
  CHECK (abs(total - (neto + iva)) <= 1);

COMMIT;

-- Validación rápida (debería dar 0)
SELECT COUNT(*) AS incoherentes
FROM core.sales_invoices_limpia
WHERE abs(total - (neto + iva)) > 1;

-- VALIDACION DE PRECIOS LISTAS NEGATIVOS 
 SELECT COUNT(*) INCOHERENTES
 FROM core.sales_invoices_limpia
 where preciolista<0

-- tranformación de precios listas negativos(errores erp) a positivos-
ALTER TABLE core.sales_invoices_limpia
ADD COLUMN IF NOT EXISTS preciolista_ok numeric;

UPDATE core.sales_invoices_limpia
SET preciolista_ok = ABS(preciolista);

-- transfromación de costo unitario(errores erp) y logistica(errore erp) a positivos
alter table core.limpio_raw_purchases_vehicles
add column if not exists costo_unitario_ok numeric;

update core.limpio_raw_purchases_vehicles
set costo_unitario_ok= abs(costounitario);

alter table core.limpio_raw_purchases_vehicles
add column if not exists costo_ligistico_ok numeric;

update core.limpio_raw_purchases_vehicles
set costo_ligistico_ok= abs(costologistica);


select*from staging.raw_sales_invoices