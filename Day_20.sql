*/ For this challenge you need to create a SELECT statement, this select statement 
must have NULL handling, using COALESCE and NULLIF.
If no name is specified you must replace with [product name not found]
If no card_name is specified you must replace with [card name not found]
If no price is specified you must throw away the record, you must also filter 
the dataset by prices greater than 50. */

SELECT id,
COALESCE(NULLIF(name, ''), '[product name not found]') AS name,
COALESCE(price) AS price,
COALESCE(NULLIF(card_name, ''), '[card name not found]') AS card_name,
card_number,
transaction_date
FROM
eusales
WHERE price > 50


*/For the species, if the monster has more heads than arms, more tails than legs, 
or both, it is a 'BEAST' else it is a 'WEIRDO'. This needs to be captured in the species column.*/

SELECT *,
CASE 
  WHEN heads > arms THEN 'BEAST' 
  WHEN tails > legs THEN 'BEAST'
  ELSE 'WEIRDO'
  END AS species
FROM
top_half AS t
JOIN bottom_half AS b
ON t.id=b.id
ORDER BY species
