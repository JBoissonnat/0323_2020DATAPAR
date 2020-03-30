# CHALLENGE 1

select a.au_id as "AUTHOR ID", a.au_lname as "LAST NAME", a.au_fname as "FIRST NAME", t.title as "TITLE", p.pub_name as "PUBLISHER"
from authors a
join titleauthor ta on a.au_id=ta.au_id
join titles t on ta.title_id=t.title_id
join publishers p on t.pub_id=p.pub_id
order by a.au_id;

# CHALLENGE 2

select a.au_id as "AUTHOR ID", a.au_lname as "LAST NAME", a.au_fname as "FIRST NAME", p.pub_name as "PUBLISHER", count(t.title) as "TITLE COUNT"
from authors a
join titleauthor ta on a.au_id=ta.au_id
join titles t on ta.title_id=t.title_id
join publishers p on t.pub_id=p.pub_id
group by a.au_id, p.pub_name
order by a.au_id desc;

# CHALLENGE 3

select a.au_id as "AUTHOR ID", a.au_lname as "LAST NAME", a.au_fname as "FIRST NAME", sum(s.qty) as "TOTAL"
from authors a
join titleauthor ta on a.au_id=ta.au_id
join titles t on ta.title_id=t.title_id
join sales s on t.title_id=s.title_id
group by a.au_id, t.title
order by sum(s.qty) desc
limit 3;

# CHALLENGES 4

select a.au_id as "AUTHOR ID", a.au_lname as "LAST NAME", a.au_fname as "FIRST NAME", sum(s.qty) as "TOTAL"
from authors a
left join titleauthor ta on a.au_id=ta.au_id
left join titles t on ta.title_id=t.title_id
left join sales s on t.title_id=s.title_id
group by a.au_id, t.title
order by sum(s.qty) desc;
