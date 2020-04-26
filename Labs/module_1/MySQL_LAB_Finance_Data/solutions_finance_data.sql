# CHALLENGE 1 : What is the most successful district?

select district_id, count(account_id) as ac_freq
from account
group by district_id
order by ac_freq desc
limit 5;

# CHALLENGE 2 : How many people changed their place of residence?

select account_id, group_concat(distinct bank_to), group_concat(amount), count(distinct amount) as diff
from bank.order
where k_symbol="SIPO"
group by account_id
having diff > 1;
