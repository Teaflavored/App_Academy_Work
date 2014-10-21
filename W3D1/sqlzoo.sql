/* SELECT BASICS */
/* 1 */
SELECT
population
FROM 
world
WHERE name = 'Germany'

/* 2 */
SELECT
name, gdp/population
FROM
world
WHERE
area > 5000000

/* 3 */
SELECT
name, continent
FROM
world
WHERE
area < 2000 AND gdp > 5000000000

/* 4 */
SELECT
name, population
FROM
world
WHERE
name IN ('Denmark', 'Finland', 'Norway', 'Sweden')

/* 5 */
SELECT
name
FROM
world
WHERE
name LIKE 'G%'

/* 6 */
SELECT
name, area/1000
FROM
world
WHERE
area BETWEEN 200000 AND 250000

/* SELECT WITHIN SELECT */
/* 1 */
SELECT
name
FROM
world
WHERE
population > (
  SELECT
  population
  FROM
  world
  WHERE
  name = 'Russia'
)
  
/* 2 */
SELECT
name
FROM
world
WHERE
continent = 'Europe' AND gdp/population > (
  SELECT
  gdp/population
  FROM
  world
  WHERE
  name = 'United Kingdom'
)

/* 3 */
SELECT
name, continent
FROM
world
WHERE
continent IN (
  SELECT
  continent
  FROM
  world
  WHERE
  name IN ('Belize','Belgium')
)

/* 4 */
SELECT
name, population
FROM
world
WHERE
population > (
  SELECT
  population
  FROM
  world
  WHERE
  name = 'Canada'
)
AND
population < (
  SELECT
  population
  FROM
  world
  WHERE
  name = 'Poland'
)

/* 5 */
SELECT
name
FROM
world
WHERE
gdp > ALL (
  SELECT
  gdp
  FROM
  world
  WHERE continent = 'Europe'
  AND
  gdp IS NOT NULL
)

/* 6 */
SELECT
continent, name, area
FROM
world x
WHERE area >= ALL (
  SELECT
  area
  FROM
  world y
  WHERE
  x.continent = y.continent
  AND
  area IS NOT NULL
)

/* 7 */
SELECT
name, continent, population
FROM
world
WHERE continent IN (
  SELECT
  continent
  FROM
  world
  GROUP BY continent
  HAVING MAX(population) < 25000000
)

/* 8 */
SELECT
name, continent
FROM
world x 
WHERE population / 3 > ALL (
  SELECT
  population
  FROM
  world y
  WHERE x.continent = y.continent
  AND
  y.population IS NOT NULL
  AND x.name <> y.name
)



SELECT
e.mdate, e.team1, SUM(e.score1), e.team2, SUM(e.score2)
FROM 
(  SELECT 
    matchid,
    id,
    mdate,
    team1,
    CASE 
    WHEN teamid=team1 THEN 1 ELSE 0 END score1, 
    team2,
    CASE 
    WHEN teamid=team2 THEN 1 ELSE 0 END score2
    FROM 
    game 
    LEFT OUTER JOIN goal 
    ON matchid = id) e 
GROUP BY e.id
ORDER BY e.mdate,e.matchid, e.team1,e.team2




SELECT DISTINCT e.title, g.name
FROM 
(SELECT movie.title, movie.id
FROM casting JOIN movie ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE casting.actorid = (SELECT id
FROM actor
WHERE name = 'Julie Andrews') ) e JOIN casting f ON e.id= f.movieid JOIN actor g ON g.id = f.actorid
WHERE f.ord = 1


SELECT a.name
FROM (SELECT casting.actorid,
CASE WHEN ord = 1 THEN 1 ELSE 0 END star
FROM casting) e JOIN actor a ON e.actorid = a.id
GROUP BY a.name
HAVING SUM(e.star) >= 30
ORDER BY 1



SELECT e.title, COUNT(actorid)
FROM movie e JOIN casting f ON e.id = f.movieid
WHERE e.yr = 1978
GROUP BY movieid
ORDER BY 2 DESC



SELECT g.name
FROM
(SELECT movie.id
FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid
WHERE casting.actorid = (
SELECT id
FROM actor
WHERE name = 'Art Garfunkel')) e JOIN casting f ON e.id = f.movieid JOIN actor g ON g.id = f.actorid
WHERE g.name != 'Art Garfunkel'

/* NSS */
SELECT a.institution, b.sample, a.sample
FROM (SELECT institution, sample
  FROM nss
 WHERE question='Q01'
   AND (institution LIKE '%Manchester%') AND subject = '(8) Computer Science'
GROUP BY institution ) a JOIN (SELECT institution, SUM(sample) sample 
  FROM nss
 WHERE question='Q01'
   AND (institution LIKE '%Manchester%')
GROUP BY institution ) b ON a.institution = b.institution

/* SElf join */ 
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53

SELECT DISTINCT e.num, e.company, f.name, f.num, f.company
FROM  (SELECT DISTINCT a.num, b.stop, a.company
  FROM route a JOIN route b ON
      (a.company=b.company AND a.num = b.num)
      JOIN stops stopa ON (a.stop=stopa.id) 
      JOIN stops stopb ON (b.stop=stopb.id) 
  WHERE stopa.name='Craiglockhart') e JOIN 

  (SELECT DISTINCT b.num, a.stop, b.company, stopa.name
  FROM route a JOIN route b ON
      (a.company=b.company AND a.num = b.num)
      JOIN stops stopa ON (a.stop=stopa.id) 
      JOIN stops stopb ON (b.stop=stopb.id) 
  WHERE stopb.name='Sighthill') f ON e.stop = f.stop