SELECT c.name AS name, l.no AS no
FROM borrower b, loan l, customer c
where b.Ino=l.no AND c.name=b.cname AND c.credit<l.minCredit;

--DELIM

select customer.name AS name, count(borrower.Ino) AS loanCount from customer
left outer join borrower on customer.name=borrower.cname 
group by name;


--DELIM

SELECT loan.type AS loanType FROM borrower left join loan on borrower.Ino=loan.no 
group by loan.type
HAVING count(borrower.cname) <=All(SELECT count(borrower.cname) FROM borrower left join loan on borrower.Ino=loan.no 
group by loan.type);

--DELIM

SELECT borrower.cname AS name FROM borrower left join loan on borrower.Ino=loan.no 
GROUP BY borrower.cname
HAVING count(DISTINCT loan.type)=(select count(DISTINCT loan.type) from loan);

--DELIM


SELECT l1.no AS no FROM borrower left join loan l1 on borrower.Ino=l1.no 
group by l1.type,l1.no
HAVING count(borrower.cname)>(
Select count(cname)/count(DISTINCT no) from borrower left join loan l2 on borrower.Ino=l2.no
where l1.type=l2.type group by l2.type);

--DELIM

SELECT DISTINCT b1.cname AS name1,b2.cname AS name2 FROM borrower b1, borrower b2
where b1.cname<b2.cname AND b1.Ino=b2.Ino AND exists (
select b3.cname from borrower b3 
where b1.cname=b3.cname AND b1.Ino=b2.Ino
group by b3.cname
HAVING count(b3.Ino)=(
select count(b4.Ino) from borrower b4
group by b4.cname
HAVING b2.cname=b4.cname )
);



