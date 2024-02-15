-- Exercise

-- 1:
SELECT * FROM owners o FULL OUTER JOIN vehicles v ON o.id=v.owner_id;

-- 2:
SELECT first_name, last_name, COUNT(owner_id) FROM owners o JOIN vehicles v on o.id=v.owner_id GROUP BY (first_name, last_name) ORDER BY first_name;

-- 3:
SELECT first_name, last_name, ROUND(AVG(price)) as average_price, COUNT(owner_id)FROM owners o JOIN vehicles v on o.id=v.owner_id GROUP BY (first_name, last_name)HAVING COUNT(owner_id) > 1 AND ROUND(AVG(price)) > 10000 ORDER BY first_name DESC;

-- SQLZoo Part 6:

-- 1:
SELECT matchid,player FROM goal WHERE teamid='GER';

-- 2
SELECT id,stadium,team1,team2 FROM game WHERE id=1012;

-- 3
SELECT player,teamid,stadium,mdate 
  FROM game JOIN goal ON (game.id=goal.matchid) WHERE teamid='GER';

-- 4:
SELECT team1,team2,player
  FROM game JOIN goal ON (game.id=goal.matchid) WHERE player LIKE 'Mario%';

-- 5:
SELECT player, teamid, coach, gtime FROM goal JOIN eteam ON teamid=idWHERE gtime<=10;

-- 6
SELECT mdate,teamname FROM game JOIN eteam ON team1=eteam.id WHERE coach='Fernando Santos';

-- 7:
SELECT player FROM goal JOIN game ON (goal.matchid=game.id) WHERE stadium='National Stadium, Warsaw';

-- 8:
SELECT DISTINCT player FROM game JOIN goal ON matchid = id WHERE teamid<>'GER' AND( team1='GER' OR team2='GER');

-- 9:
SELECT teamname, COUNT(matchid) FROM eteam JOIN goal ON (eteam.id=goal.teamid) GROUP BY teamname;

-- 10:
SELECT stadium,COUNT(matchid) FROM game JOIN goal ON (game.id=goal.matchid) GROUP BY stadium

-- 11:
SELECT matchid,mdate, COUNT(matchid) FROM game JOIN goal ON matchid = id WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY matchid, mdate;

-- 12:
SELECT matchid,mdate, COUNT(matchid) FROM game JOIN goal ON matchid = id WHERE teamid='GER' GROUP BY matchid, mdate;

-- 13:
SELECT mdate, team1, SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1, team2, SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2 FROM game LEFT JOIN goal ON matchid = id GROUP BY mdate, team1, team2 ORDER BY mdate, matchid, team1, team2;


-- SQLZoo part 7:

-- 1:
SELECT id, title FROM movie WHERE yr=1962

-- 2:
SELECT yr FROM movie WHERE title='Citizen Kane';

-- 3:
SELECT id, title, yr FROM movie WHERE title LIKE '%Star Trek%' ORDER BY yr;

-- 4:
SELECT id FROM actor WHERE name='Glenn Close'

-- 5:
SELECT id FROM movie WHERE title='Casablanca'

-- 6:
SELECT actor.name FROM actor JOIN casting ON casting.actorid = actor.id WHERE casting.movieid = 11768;

-- 7:
SELECT actor.name FROM actor JOIN casting ON casting.actorid = actor.id JOIN movie ON movie.id = casting.movieid WHERE movie.title = 'Alien';

-- 8:
SELECT movie.title FROM movie JOIN casting ON casting.movieid = movie.id JOIN actor ON actor.id = casting.actorid WHERE actor.name = 'Harrison Ford';

-- 9:
SELECT movie.title FROM movie JOIN casting ON casting.movieid = movie.id JOIN actor ON actor.id = casting.actorid WHERE actor.name = 'Harrison Ford' AND casting.ord != 1;

-- 10:
SELECT movie.title, actor.name FROM movie JOIN casting ON casting.movieid = movie.id JOIN actor ON actor.id = casting.actorid WHERE movie.yr = 1962 AND casting.ord = 1;

-- 11:
SELECT yr,COUNT(title) FROM movie JOIN casting ON movie.id=movieid JOIN actor   ON actorid=actor.id WHERE name='Rock Hudson' GROUP BY yr HAVING COUNT(title) > 2

-- 12:
SELECT title,name FROM movie JOIN casting ON (movieid=movie.id AND ord=1) JOIN actor ON (actorid=actor.id) WHERE movie.id IN (SELECT movieid FROM casting WHERE actorid IN (SELECT id FROM actor WHERE name='Julie Andrews'))

-- 13:
SELECT actor.name FROM actor JOIN casting ON casting.actorid = actor.id WHERE casting.ord = 1 GROUP BY actor.name HAVING COUNT(*) >= 15;

-- 14:
SELECT title, COUNT(actorid) FROM movie JOIN casting ON movie.id = movieid WHERE yr = 1978 GROUP BY title ORDER BY COUNT(actorid) DESC, title

-- 15:
SELECT a.name FROM (SELECT movie.* FROM movie JOIN casting ON casting.movieid = movie.id JOIN actor ON actor.id = casting.actorid WHERE actor.name = 'Art Garfunkel') AS m JOIN (SELECT actor.*, casting.movieid FROM actor
JOIN casting ON casting.actorid = actor.id WHERE actor.name != 'Art Garfunkel') as a ON m.id = a.movieid;