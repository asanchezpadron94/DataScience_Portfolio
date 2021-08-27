-- https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers

-- 5.1 Select the name of all the pieces. 
SELECT name FROM ex_05.pieces;

-- 5.2  Select all the providers' data. 
SELECT * FROM ex_05.providers;

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
SELECT piece, AVG(price)
FROM ex_05.provides
GROUP BY piece;

-- 5.4  Obtain the names of all providers who supply piece 1.
SELECT DISTINCT(a.name)
FROM ex_05.providers AS a
LEFT JOIN ex_05.provides AS b ON a.code = b.provider
WHERE b.piece = 1;

-- 5.5 Select the name of pieces provided by provider with code "HAL".
SELECT DISTINCT(c.name)
FROM ex_05.provides AS a
LEFT JOIN ex_05.providers AS b ON a.provider = b.code
LEFT JOIN ex_05.Pieces AS c ON a.piece = c.code
WHERE b.code = 'HAL';

-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
SELECT piece, provider, price
FROM (
	SELECT c.name AS piece, b.name AS provider, a.price, RANK() OVER(PARTITION BY c.name ORDER BY a.price DESC)
	FROM ex_05.provides AS a
	LEFT JOIN ex_05.providers AS b ON a.provider = b.code
	LEFT JOIN ex_05.Pieces AS c ON a.piece = c.code) AS sub_q
WHERE RANK = 1
;

-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO ex_05.provides(piece, provider, price) VALUES(1, 'TNBC', 7);

-- 5.8 Increase all prices by one cent.
SELECT piece, provider, price + 1 AS price_plus_one FROM ex_05.provides;

-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
DELETE FROM ex_05.provides
WHERE piece = 4 AND provider = 'RBT';

-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
-- (the provider should still remain in the database).
DELETE FROM ex_05.provides
WHERE provider = 'RBT';
