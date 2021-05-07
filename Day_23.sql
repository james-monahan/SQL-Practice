/* In baseball, the batting average is a simple and 
most common way to measure a hitter's performace. 
Batting average is calculated by taking all the 
players hits and dividing it by their number of 
at_bats, and it is usually displayed as a 
3 digit decimal (i.e. 0.300).*/

SELECT player_name, games,
ROUND(hits::DECIMAL(4)/at_bats::DECIMAL(4),3)::VARCHAR(6) AS batting_average
FROM
yankees
WHERE at_bats > 100 
ORDER BY batting_average DESC


/*  Your job is to split out the letters and numbers from the address provided, 
and return a table in the following format: */

SELECT project,
REGEXP_REPLACE(address, '[[:alpha:]]', '', 'g') AS numbers,
REGEXP_REPLACE(address, '[[:digit:]]', '', 'g') AS letters
FROM repositories
