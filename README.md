# Venta_de_Vehiculos
Análisis y limpieza de datos con SQL-POWER BI
# Análisis comparativo 2024–2025: ventas y rentabilidad en la comercialización de vehículos

## Preparación, limpieza y modelado de datos

Previo a la construcción del panel de control, se desarrolló un proceso de **limpieza y preparación de datos en SQL**, cuyo detalle se adjunta en el archivo **`Procedimiento limpieza`**.

En esta etapa se abordaron distintas problemáticas presentes en las bases de datos originales, entre ellas:

- validación y corrección de tipos de datos,
- transformación de columnas desde formato **texto a fecha (`DATE`)**,
- transformación de columnas numéricas desde texto a **`NUMERIC` o `INTEGER`**,
- revisión y depuración de registros duplicados,
- normalización de signos en columnas monetarias,
- análisis de valores nulos,
- y elaboración de **consultas, subconsultas y joins** para verificar la coherencia entre tablas de ventas, pagos, compras, inventario y contabilidad.

Dado que la cantidad de tablas intervenidas fue considerable, en la entrega se incorpora únicamente una selección de consultas SQL aplicadas a **algunas tablas que presentaban inconsistencias**, con el propósito de exponer el **procedimiento metodológico de limpieza**. Dicho procedimiento puede ser replicado sobre las demás tablas, ya que responde a una lógica común de validación, transformación y estandarización de datos.

Posteriormente, una vez finalizada la etapa de limpieza, se llevó a cabo el **modelado de datos en Power BI**, cuyo archivo corresponde a **`Venta de vehículo`**. En esta fase se construyeron algunas **tablas de dimensión** con el fin de evitar relaciones **muchos a muchos**, logrando así un **Modelo Entidad-Relación (MER)** más consistente y adecuado para el análisis. Esta decisión metodológica permitió mejorar la estabilidad del modelo, reducir duplicidades en los resultados y asegurar una correcta interpretación de los indicadores.

---

## Resumen ejecutivo

### Año 2024
- **Ventas Neto (+):** $11,7 mil millones  
- **VIN vendidos:** 803  
- **Utilidad bruta:** $1,15 mil millones  
- **Margen de beneficio:** 9,80%

### Año 2025
- **Ventas Neto (+):** $11,05 mil millones  
- **VIN vendidos:** 747  
- **Utilidad bruta:** $1,48 mil millones  
- **Margen de beneficio:** 13,38%

### Interpretación general
Los resultados indican que en **2024** se alcanzó un mayor volumen de ventas, tanto en términos monetarios como en cantidad de vehículos comercializados. No obstante, en **2025**, pese a observarse una disminución en las ventas netas y en la cantidad de unidades vendidas, se obtuvo una **mayor utilidad bruta** y un **margen de beneficio superior**, lo que sugiere una mejora en la eficiencia del negocio, probablemente asociada a una mejor composición del mix vendido, un mayor control de costos y/o una política comercial más eficiente.

---

## Mix Nuevo vs. Usado como factor explicativo principal

### Año 2024
- **Vehículos nuevos:** 531 unidades (**66%**) con un **margen de 21,10%**
- **Vehículos usados:** 272 unidades (**34%**) con un **margen de -29,36%**

### Interpretación
La evidencia muestra que la rentabilidad del negocio durante 2024 fue sostenida principalmente por la venta de **vehículos nuevos**, mientras que los **vehículos usados** generaron una rentabilidad negativa significativa. En consecuencia, el desempeño global se encuentra fuertemente condicionado por la proporción de usados dentro de las ventas.

### Año 2025
La distribución entre vehículos nuevos y usados se mantuvo prácticamente constante, con proporciones cercanas al **66% y 34%**, respectivamente.

### Conclusión
Dado que la estructura del mix no presenta cambios relevantes entre ambos períodos, la mejora en los resultados de 2025 no parece explicarse por una transformación en la composición de ventas, sino más bien por una mejora en la **rentabilidad por unidad vendida**.

---

## Desempeño comercial

En el año **2024**, el mejor desempeño comercial fue alcanzado por **Javiera**, mientras que el rendimiento más bajo correspondió a **Camila**, de acuerdo con el ranking construido a partir de las ventas analizadas.

Desde una perspectiva metodológica, este ranking resulta útil para medir volumen de ventas, aunque sería recomendable complementarlo con indicadores de **utilidad** o **margen**, dado que vender más no implica necesariamente vender de manera más rentable.

---

## Tendencia temporal y eficiencia operativa

### Año 2024
El comportamiento mensual de las ventas muestra una **tendencia descendente** a lo largo del año, con un repunte significativo en **octubre**, asociado principalmente a la venta de un vehículo usado, modelo **Andes City C**.

En términos de eficiencia:

- **Mayo 2024:** margen de **23,41%**
- **Octubre 2024:** margen de **24,49%**

Si bien ambos meses presentan niveles de margen similares, **mayo evidencia una mayor eficiencia**, ya que logra una rentabilidad comparable con un menor nivel de ventas. Esto sugiere una mejor combinación entre precio, costos y composición del mix.

### Año 2025
Durante 2025 se observa una mejora en la rentabilidad agregada, aun cuando el volumen comercializado fue menor que el del año anterior.

---

## Desempeño por sucursal

### Año 2025
El comportamiento de las sucursales fue más homogéneo:
- La mayoría de ellas se ubicó entre **13% y 16%** de margen,
- con excepción de **Concepción**, cuyo margen se situó en torno al **4%**.

### Año 2024
En este período se observa una mayor dispersión:
- **Las Condes:** ~15%
- **Santiago Centro:** ~2,8%
- **Concepción:** ~12,31%
- **Viña del Mar:** ~8,16%

### Interpretación
La caída del margen en **Concepción durante 2025** puede asociarse a una mayor participación relativa de **vehículos usados**, situación que también se observa en **Santiago Centro durante 2024**. Esto refuerza la hipótesis de que el mix de vehículos comercializados por sucursal tiene una incidencia directa sobre la rentabilidad.

---

## Modelos

- **Año 2024:** el modelo más rentable fue **Pickup P**, con **126 unidades vendidas** y un **margen de 24,52%**.
- **Año 2025:** el modelo más destacado fue **Andes SUV X**, con un **margen de 32,26%**.

### Interpretación
La mejora del margen en 2025 podría estar vinculada a una mayor participación de modelos con mejor rentabilidad o a una mejora en el manejo comercial y de costos asociados a dichos modelos.

---

## Control de pérdidas mediante bandas de margen negativo

Con el objetivo de evaluar el riesgo comercial, se definieron tres bandas de pérdida:

- **Pérdida leve:** entre `0%` y `-10%`
- **Pérdida media:** entre `-10%` y `-20%`
- **Pérdida crítica:** menor a `-20%`

### Año 2024
- **36 VIN** con pérdida entre `0% y -10%`
- **29 VIN** con pérdida entre `-10% y -20%`
- **82 VIN** con pérdida menor a `-20%`

**Desglose 2024**
- **Nuevos:** 18 / 13 / 28
- **Usados:** 18 / 16 / 54

### Año 2025
- **38 VIN** con pérdida entre `0% y -10%`
- **21 VIN** con pérdida entre `-10% y -20%`
- **81 VIN** con pérdida menor a `-20%`

**Desglose 2025**
- **Nuevos:** 22 / 13 / 38
- **Usados:** 16 / 8 / 43

### Interpretación
A pesar de la mejora observada en el margen global durante 2025, continúa existiendo un número considerable de operaciones con pérdida, especialmente en la banda **crítica**. En ambos años, estas pérdidas se concentran de manera importante en los **vehículos usados**, lo que confirma su incidencia negativa sobre la rentabilidad total del negocio.

---

## Justificación metodológica: uso de Ventas Neto (+)

En este análisis se trabajó con **Ventas Neto (+)**, definidas como ventas netas con `neto > 0`, por las siguientes razones:

1. **El IVA no constituye ingreso efectivo del negocio**  
   El valor total de la venta incorpora el impuesto al valor agregado, el cual no representa utilidad para la empresa. Por esta razón, la base adecuada para el análisis de desempeño comercial y rentabilidad es el **valor neto**.

2. **Comparabilidad con los costos**  
   La utilidad bruta se calcula comparando el ingreso real de la venta con el costo asociado a dicha operación. En consecuencia, la relación metodológicamente correcta es:

   - **Utilidad Bruta = Ventas Neto (+) − COGS**
   - **Margen = Utilidad / Ventas Neto (+)**

3. **Evitar distorsiones producidas por devoluciones, reversas o notas de crédito**  
   Filtrar únicamente registros con `neto > 0` permite concentrar el análisis en ventas efectivas, excluyendo movimientos negativos que corresponden a ajustes contables o devoluciones, y que podrían distorsionar la lectura comercial del negocio.

4. **Coherencia con el propósito del dashboard**  
   Esta primera hoja se diseñó con un enfoque **comercial y operativo**, orientado a medir la eficiencia de la venta y su rentabilidad directa. El análisis de la utilidad considerando todos los costos de la empresa (por ejemplo, sueldos, arriendos, gastos administrativos y marketing) corresponde a una etapa posterior, mediante una hoja específica de **Estado de Resultados / EBITDA**.

---

## Conclusiones finales

- Durante **2024** se registró un mayor volumen de ventas, aunque con una rentabilidad afectada por el bajo desempeño de los vehículos usados y por diferencias significativas entre sucursales.
- En **2025**, a pesar de la disminución en ventas netas y unidades comercializadas, se logró una **mejora sustancial en el margen y en la utilidad bruta**, evidenciando una operación más eficiente.
- No obstante, persiste una cantidad relevante de operaciones con pérdida, especialmente en la banda crítica y en el segmento de vehículos usados, lo que sugiere que dicho segmento continúa siendo el principal foco de control y mejora.
