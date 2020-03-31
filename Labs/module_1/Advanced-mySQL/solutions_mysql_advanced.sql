# CHALLENGE 1

# Royalty of each sale for each author
select t.title_id as Title_ID, ta.au_id as Author_ID, t.advance * ta.royaltyper / 100 as Advance, t.price * s.qty * (t.royalty / 100) * (ta.royaltyper / 100) as Royalty_each_sale
from titles t
inner join titleauthor ta on t.title_id=ta.title_id
inner join sales s on ta.title_id=s.title_id;

# Aggregate the total royalties for each title and author
select rpsa.Title_ID, rpsa.Author_ID, rpsa.Advance, sum(rpsa.Royalty_each_sale) as Aggregated_royalties_t_a
from(
select t.title_id as Title_ID, ta.au_id as Author_ID, t.advance * ta.royaltyper / 100 as Advance, t.price * s.qty * (t.royalty / 100) * (ta.royaltyper / 100) as Royalty_each_sale
from titles t
inner join titleauthor ta on t.title_id=ta.title_id
inner join sales s on ta.title_id=s.title_id) as rpsa
group by rpsa.Author_ID, rpsa.Title_ID;

# Calculate the total profits of each author
select Author_ID, sum(Advance + Aggregated_royalties_t_a) as Total_profit
from(
select rpsa.Title_ID, rpsa.Author_ID, rpsa.Advance, sum(rpsa.Royalty_each_sale) as Aggregated_royalties_t_a
from(
select t.title_id as Title_ID, ta.au_id as Author_ID, t.advance * ta.royaltyper / 100 as Advance, t.price * s.qty * (t.royalty / 100) * (ta.royaltyper / 100) as Royalty_each_sale
from titles t
inner join titleauthor ta on t.title_id=ta.title_id
inner join sales s on ta.title_id=s.title_id) as rpsa
group by rpsa.Author_ID, rpsa.Title_ID) as agg_rpsa
group by Author_ID
order by Total_profit desc
limit 3;

# CHALLENGE 2

# Royalty of each sale for each author
create temporary table royalty_per_sale_for_authors
select t.title_id as Title_ID, ta.au_id as Author_ID, t.advance * ta.royaltyper / 100 as Advance, t.price * s.qty * (t.royalty / 100) * (ta.royaltyper / 100) as Royalty_each_sale
from titles t
inner join titleauthor ta on t.title_id=ta.title_id
inner join sales s on ta.title_id=s.title_id;

# Aggregate the total royalties for each title and author
create temporary table agg_rpsa
select rpsa.Title_ID, rpsa.Author_ID, rpsa.Advance, sum(rpsa.Royalty_each_sale) as Aggregated_royalties_t_a
from royalty_per_sale_for_authors rpsa
group by rpsa.Author_ID, rpsa.Title_ID;

# Calculate the total profits of each author
create temporary table author_tot_profit
select Author_ID, sum(Advance + Aggregated_royalties_t_a) as Total_profit
from agg_rpsa
group by Author_ID
order by Total_profit desc;

# CHALLENGE 3

create table most_profiting_authors as
select Author_ID, Total_profit as profits
from author_tot_profit;