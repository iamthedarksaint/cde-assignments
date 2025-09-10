/* Provide a table that shows the region for each sales rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) by account name. */
select r.name region, s.name sales_rep, a.name account_name
from sales_reps s
	join region r on s.region_id = r.id
	join accounts a on a.sales_rep_id = s.id
order by 3 asc;
