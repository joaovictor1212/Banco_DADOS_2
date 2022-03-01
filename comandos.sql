-- SELECTS TABELA CUSTOMERS

-- Busca dos clientes que contenham 3 no numero de cliente
select * from customers cu 
where cu.customerNumber like '%3%'
order by customerNumber asc;

-- Busca dos clientes com vinculo com a tabela de funcionários, sem que contenha a funcionária com o nome de Diane
select * from customers cu
left outer join employees em on
cu.salesRepEmployeeNumber = em.employeeNumber
where em.firstName not in ('Diane');

-- Busca dos clientes trazendo Nome, limite e telefone, com vinculo das tabelas de funcionários e escritórios, com os filtros de limite maior ou igual a 100mil, e escritório igual a 4
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

-- Busca da tabela de funcionários trazendo o sobrenome, email com vinculo da tabela de escritório, com filtro que não traz offices com o numero 2
select em.lastName as Sobrenome,
em.email as Email
from employees em 
inner join offices of on
of.officeCode = em.officeCode
where of.officeCode not like '%2%';

-- Busca da tabela de produtos com vinculo da tabela de linhas de produtos, com o Vendedor diferente de 'Min Lin', e a Descrição diferente de null
select po.productCode as ID, 
po.productName as Nome, 
po.productVendor as Vendedor, 
pol.textDescription as Descrição
from products po
left outer join productlines pol on 
pol.productLine = po.productLine
where po.productVendor != 'Min Lin Diecast'
and pol.textDescription is not null;

-- Soma do total de pagamentos de clientes que tenham o numero de cliente maior que 120
select sum(pa.amount) as Valor from payments pa 
inner join customers cu on
pa.customerNumber = cu.customerNumber
where pa.amount >= 100.00
and cu.customerNumber > 120;

-- Busca dos escritórios que as cidades sejam San Francisco e Paris
select * from offices of
where of.city in ('San Francisco','Paris');

-- Busca nos detalhes das orderns que a quantidade seja maior ou igual a 30, o priceEach maior que 33 ordernados por numero de linhas das ordens
select * from orderdetails od
where od.quantityOrdered >= 30
and priceEach <= 33.00
order by od.orderLineNumber;

-- Busca nas ordens com o filtros data e shippedDate diferente de "On hold"
select * from orders ord
where ord.orderDate between '2003-01-06' and '2003-05-01'
and ord.requiredDate > '2003-02-02'
and ord.shippedDate != 'On Hold';
 

select cu.customerNumber as numero_cliente, 
cu.contactLastName as sobrenome, 
cu.phone as telefone, 
o2.priceEach as preço 
from customers cu 
inner join orders o on
o.customerNumber = cu.customerNumber 
left outer join orderdetails o2 on
o2.orderNumber = o.orderNumber 
where o.orderDate BETWEEN '2003-01-04' and '2003-04-24'
and o2.priceEach >= 56.66;


select e.lastName as sobrenome,
e.employeeNumber as numero,
e.reportsTo as reportado_para 
 from employees e 
inner join offices o on
o.officeCode = e.officeCode 
where o.phone not like '%4%'
and e.reportsTo not like '%2%;'

select c.customerName, 
c.contactFirstName, 
c.country, 
p.amount 
from customers c 
inner join payments p on
p.customerNumber = c.customerNumber 
inner join orders o on
o.customerNumber = c.customerNumber 
where p.paymentDate >= '2003-02-01'
group  by c.customerName, 
		  c.contactFirstName,
		  c.country,
		  p.amount 
order by p.amount;
