update loan
set type='studentT'
where type='student';

update loan
set type='student'
where type='jumbo';

update loan
set type='jumbo'
where type='studentT';

--DELIM


update customer
set credit=-1
where customer.name = ANY (select borrower.cname from borrower, loan where
borrower.Ino=loan.no AND loan.type='jumbo');
delete from borrower where
borrower.cname = ANY (select customer.name from customer where customer.credit=-1);
delete from customer where customer.credit=-1;
delete from loan where loan.type='jumbo'