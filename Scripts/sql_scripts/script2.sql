/* Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000. */
select *
from orders
where standard_qty::int = 0 AND (gloss_qty::int > 1000 OR poster_qty::int > 1000)
