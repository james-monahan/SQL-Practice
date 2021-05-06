*/ For this challenge you need to create a basic Age Calculator 
function which calculates the age in years on the age field of the peoples table. */

CREATE FUNCTION AGECALCULATOR (val TIMESTAMP)
RETURNS integer AS $age_in_years$
declare
	age_in_years integer;
BEGIN
   SELECT DATE_PART('year', AGE(val)) into age_in_years;
   RETURN age_in_years;
END;
$age_in_years$ LANGUAGE plpgsql; 
