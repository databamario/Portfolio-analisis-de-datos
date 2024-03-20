Select *
From salud..['Censo 2022-2021']
where Año like '%2022%'

select *
From muertes_salud_mental
where Periodo like '%2022%'
order by 3,4

SELECT *
From salud..[10803]

SELECT *
From salud..[10803]
where Causa_de_muerte like '%Suicidio%'
order by 2,3,4

SELECT *
From salud..[10803]
where Causa_de_muerte like '%047%'
order by 2,3,4

SELECT *
From salud..[10803]
where Causa_de_muerte like '%048%'
order by 2,3,4

SELECT *
From salud..[10803]
where Causa_de_muerte like '% Otros trastornos mentales %'
order by 2,3,4

Create view muertes_todas_causas as
SELECT *
From salud..[10803]
where Causa_de_muerte like '%Todas las causas%'
order by 2,3,4

SELECT *
INTO muertes_salud_mental
FROM (
    SELECT *
    FROM salud..[10803]
    WHERE Causa_de_muerte LIKE '%Suicidio%'
    UNION
    SELECT *
    FROM salud..[10803]
    WHERE Causa_de_muerte LIKE '%047%'
    UNION
    SELECT *
    FROM salud..[10803]
    WHERE Causa_de_muerte LIKE '%048%'
    UNION
    SELECT *
    FROM salud..[10803]
    WHERE Causa_de_muerte LIKE '% Otros trastornos mentales %'
) AS UnionQuery
ORDER BY 1,2,3,4,5;

SELECT
    CASE 
        WHEN Causa_de_muerte LIKE '%047%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%048%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%Otros trastornos mentales%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%098%' THEN 'Muertes_salud_mental'
        ELSE Causa_de_muerte
    END AS Causa_de_muerte,
    Sexo,
    Edad,
    Comunidades_y_Ciudades_Autónomas,
    Periodo,
    SUM(Total) AS Total
FROM muertes_salud_mental
GROUP BY 
    CASE 
        WHEN Causa_de_muerte LIKE '%047%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%048%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%Otros trastornos mentales%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%098%' THEN 'Muertes_salud_mental'
        ELSE Causa_de_muerte
    END,
    Sexo,
    Edad,
    Comunidades_y_Ciudades_Autónomas,
    Periodo
ORDER BY Causa_de_muerte, Sexo, Edad, Comunidades_y_Ciudades_Autónomas, Periodo;



SELECT *
From salud..[10803]

create view muertes_suicidio AS
SELECT *
From salud..[10803]
where Causa_de_muerte like '%Suicidio%'
order by 2,3,4

create view muertes_alcoholismo AS
SELECT *
From salud..[10803]
where Causa_de_muerte like '%047%'
order by 2,3,4

create view muertes_drogas AS
SELECT *
From salud..[10803]
where Causa_de_muerte like '%048%'
order by 2,3,4

create view muertes_otros_trastornos AS
SELECT *
From salud..[10803]
where Causa_de_muerte like '% Otros trastornos mentales %'
--order by 2,3,4

SELECT *
From salud..[10803]
where Causa_de_muerte like '%Todas las causas%'
order by 2,3,4

Create view muertes_totales_periodo AS
SELECT
    CASE 
        WHEN Causa_de_muerte LIKE '%047%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%048%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%Otros trastornos mentales%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%098%' THEN 'Muertes_salud_mental'
        ELSE Causa_de_muerte
    END AS Causa_de_muerte,
    Sexo,
    Edad,
    Comunidades_y_Ciudades_Autónomas,
    Periodo,
    SUM(Total) AS Total
FROM muertes_salud_mental
GROUP BY 
    CASE 
        WHEN Causa_de_muerte LIKE '%047%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%048%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%Otros trastornos mentales%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%098%' THEN 'Muertes_salud_mental'
        ELSE Causa_de_muerte
    END,
    Sexo,
    Edad,
    Comunidades_y_Ciudades_Autónomas,
    Periodo
ORDER BY Causa_de_muerte, Sexo, Edad, Comunidades_y_Ciudades_Autónomas, Periodo;

SELECT
    CASE 
        WHEN Causa_de_muerte LIKE '%047%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%048%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%Otros trastornos mentales%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%098%' THEN 'Muertes_salud_mental'
        ELSE Causa_de_muerte
    END AS Causa_de_muerte,
    Sexo,
    'Todas las edades' AS Edad,
    Comunidades_y_Ciudades_Autónomas,
    '2022' AS Periodo,
    SUM(Total) AS Total
FROM muertes_salud_mental
WHERE Edad = 'Todas las edades' AND Periodo = '2022'
GROUP BY 
    CASE 
        WHEN Causa_de_muerte LIKE '%047%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%048%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%Otros trastornos mentales%' THEN 'Muertes_salud_mental'
        WHEN Causa_de_muerte LIKE '%098%' THEN 'Muertes_salud_mental'
        ELSE Causa_de_muerte
    END,
    Sexo,
    Comunidades_y_Ciudades_Autónomas
ORDER BY Causa_de_muerte, Sexo, Comunidades_y_Ciudades_Autónomas;

Create view muertes_junto AS
SELECT
    CASE 
        WHEN m.Causa_de_muerte LIKE '%047%' THEN 'Muertes_salud_mental'
        WHEN m.Causa_de_muerte LIKE '%048%' THEN 'Muertes_salud_mental'
        WHEN m.Causa_de_muerte LIKE '%Otros trastornos mentales%' THEN 'Muertes_salud_mental'
        WHEN m.Causa_de_muerte LIKE '%098%' THEN 'Muertes_salud_mental'
        ELSE m.Causa_de_muerte
    END AS Causa_de_muerte,
    m.Sexo,
    'Todas las edades' AS Edad,
    m.Comunidades_y_Ciudades_Autónomas,
    '2022' AS Periodo,
    SUM(m.Total) AS Total,
    (SUM(m.Total) / c.Población) * 100000 AS Total_relativizado_por_100000_personas,
    c.Población AS Población
FROM 
    muertes_salud_mental m
JOIN
    salud..['Censo 2022-2021'] c ON m.Comunidades_y_Ciudades_Autónomas = c.[Comunidades y Ciudades Autónomas] AND m.Sexo = c.Sexo
WHERE
    m.Edad = 'Todas las edades'  -- Filtrar por el rango de edad 'Todas las edades'
    AND m.Periodo = '2022' -- Filtrar por el año 2022 en la tabla de muertes por salud mental
    AND c.Año = '2022' -- Filtrar por el año 2022 en la tabla del censo
GROUP BY 
    CASE 
        WHEN m.Causa_de_muerte LIKE '%047%' THEN 'Muertes_salud_mental'
        WHEN m.Causa_de_muerte LIKE '%048%' THEN 'Muertes_salud_mental'
        WHEN m.Causa_de_muerte LIKE '%Otros trastornos mentales%' THEN 'Muertes_salud_mental'
        WHEN m.Causa_de_muerte LIKE '%098%' THEN 'Muertes_salud_mental'
        ELSE m.Causa_de_muerte
    END,
    m.Sexo,
    m.Comunidades_y_Ciudades_Autónomas,
    c.Población
ORDER BY Causa_de_muerte, Sexo, Comunidades_y_Ciudades_Autónomas;






SELECT
    m.Causa_de_muerte,
    m.Sexo,
    'Todas las edades' AS Edad,
    m.Comunidades_y_Ciudades_Autónomas,
    '2022' AS Periodo,
    SUM(m.Total) AS Total,
    (SUM(m.Total) / c.Población) * 100000 AS Total_relativizado_por_100000_personas,
    c.Población AS Población
FROM 
    muertes_salud_mental m
JOIN
    salud..['Censo 2022-2021'] c ON m.Comunidades_y_Ciudades_Autónomas = c.[Comunidades y Ciudades Autónomas] AND m.Sexo = c.Sexo
WHERE
    (m.Causa_de_muerte LIKE '%047%' 
    OR m.Causa_de_muerte LIKE '%048%' 
    OR m.Causa_de_muerte LIKE '%Otros trastornos mentales%' 
    OR m.Causa_de_muerte LIKE '%098%')
    AND m.Edad = 'Todas las edades'  -- Filtrar por el rango de edad 'Todas las edades'
    AND m.Periodo = '2022' -- Filtrar por el año 2022 en la tabla de muertes por salud mental
    AND c.Año = '2022' -- Filtrar por el año 2022 en la tabla del censo
GROUP BY 
    m.Causa_de_muerte,
    m.Sexo,
    m.Comunidades_y_Ciudades_Autónomas,
    c.Población
ORDER BY m.Causa_de_muerte, m.Sexo, m.Comunidades_y_Ciudades_Autónomas;


CREATE VIEW muertes_separado AS
SELECT
    m.Causa_de_muerte,
    m.Sexo,
    'Todas las edades' AS Edad,
    m.Comunidades_y_Ciudades_Autónomas,
    '2022' AS Periodo,
    SUM(m.Total) AS Total,
    (SUM(m.Total) / c.Población) * 100000 AS Total_relativizado_por_100000_personas,
    c.Población AS Población
FROM 
    muertes_salud_mental m
JOIN
    salud..['Censo 2022-2021'] c ON m.Comunidades_y_Ciudades_Autónomas = c.[Comunidades y Ciudades Autónomas] AND m.Sexo = c.Sexo
WHERE
    (m.Causa_de_muerte LIKE '%047%' 
    OR m.Causa_de_muerte LIKE '%048%' 
    OR m.Causa_de_muerte LIKE '%Otros trastornos mentales%' 
    OR m.Causa_de_muerte LIKE '%098%')
    AND m.Edad = 'Todas las edades'  -- Filtrar por el rango de edad 'Todas las edades'
    AND m.Periodo = '2022' -- Filtrar por el año 2022 en la tabla de muertes por salud mental
    AND c.Año = '2022' -- Filtrar por el año 2022 en la tabla del censo
GROUP BY 
    m.Causa_de_muerte,
    m.Sexo,
    m.Comunidades_y_Ciudades_Autónomas,
    c.Población


	SELECT *
From salud..[10803] 
where Causa_de_muerte like '%001-102  I-XXII.Todas las causas%'








