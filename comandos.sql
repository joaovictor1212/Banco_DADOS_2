-- SELECTS TABELA CUSTOMERS

select * from customers cu 
where cu.customerNumber like '%3%'
order by customerNumber asc;


select * from customers cu
left outer join employees em on
cu.salesRepEmployeeNumber = em.employeeNumber
where em.firstName not in ('Diane');


 
select cu.customerName as Nome,
cu.creditLimit as Limite,
cu.phone as Telefone
from customers cu 
left outer join employees em on
em.employeeNumber = cu.salesRepEmployeeNumber
inner join offices of on 
em.officeCode = of.officeCode
where of.officeCode = 4
and cu.creditLimit >= 100000.00;

