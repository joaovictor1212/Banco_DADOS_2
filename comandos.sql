"""selects para o dia 15/03/2022"""
"""João Victor de Oliveira GU3013197"""

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

-- Busca nos detalhes das ordens que a quantidade seja maior ou igual a 30, o priceEach maior que 33 ordernados por numero de linhas das ordens
select * from orderdetails od
where od.quantityOrdered >= 30
and priceEach <= 33.00
order by od.orderLineNumber;

-- Busca nas ordens com o filtros data e shippedDate diferente de "On hold"
select * from orders ord
where ord.orderDate between '2003-01-06' and '2003-05-01'
and ord.requiredDate > '2003-02-02'
and ord.shippedDate != 'On Hold';
 
-- Busca pelos cliente com filtro de data trazendo preço da tela de detalhes nas ordens
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


-- Busca na tabela de funcionarios trazendo sobrenome, numero e reportado para, com filtros de telefone e para
select e.lastName as sobrenome,
e.employeeNumber as numero,
e.reportsTo as reportado_para 
 from employees e 
inner join offices o on
o.officeCode = e.officeCode 
where o.phone not like '%4%'
and e.reportsTo not like '%2%;'


-- Busca na tabela de clientes com data de pagamentos mais que 01/02/2003
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


-- Busca na tela de produtos de linhas com verificação dos campos
select pl.productLine, 
pl.textDescription,
pl.htmlDescription,
pl.image  
from productlines pl 
left outer join products p2 on
p2.productLine = pl.productLine
where pl.htmlDescription is not null
GROUP by pl.productLine,
pl.textDescription, 
pl.htmlDescription, 
pl.image;

-- Busca na tabela de ordens ordenadas de forma descrecente
select * from orders o 
order by o.orderDate DESC; 

-- Busca na tabela de ordens detalhes, com junção da tabela de produtos, filtrando com o not like, do codigo de produtos e ordens numeros
select * from orderdetails o 
inner join products p on
o.productCode = p.productCode 
where p.productCode not like ('%6%')
and  o.orderNumber not like ('%9%');

-- Busca na tabela de linhas de produtos com limit de 10
select  
from productlines p limit 10;

-- Busca na tabela de pagamentos com alguns campos especificos sendo mostrandos com junção das tabelas de clientes e ordens, com filtro de data de pagamento
select c.customerName as nome, 
o.orderNumber as numero_da_ordem, 
o.comments as comentários,
p.amount as valor 
from payments p 
inner join customers c on
p.customerNumber = c.customerNumber 
inner join orders o on
o.customerNumber = c.customerNumber 
where p.paymentDate BETWEEN '2003-01-01' and '2003-04-01';

-- Busca na tabela de detalhes nas ordens, com junção da tabela de produtos com filtro de quantidade de estoque maior igual a 500
select * from orderdetails o 
inner join orders o2 on
o.orderNumber = o2.orderNumber 
inner join products p on
o.productCode = p.productCode 
where p.quantityInStock >= 500;

-- Busca na tabela de linhas de produto, com junção da de produtosm trazendo nome, estoque e descrição
select p2.productName as nome, 
p2.quantityInStock as estoque, 
p.htmlDescription as descrição
from productlines p 
inner join products p2 
on p.productLine = p2.productLine ;

-- Busca na tabela de funcionarios organizados por codigo do escritório em ordem crescente
select * from employees e 
order by e.officeCode ASC; 

-- Busca na tabela de produto com preço de compra menores que 100
select productCode as id_produto, 
p.buyPrice as preço_compra 
from products p 
where p.buyPrice <= 100.00;

-- Busca na tabela de pagamentos com filtro de não trazer checkNumber com 3 e pagamentos menores que 200
select * from payments p 
where p.checkNumber not like '%3%'
and p.amount >= 2000;

-- Busca na tabela de pagamentos com filtro de pagamentos maiores que 5000, e data do pagamento maior que 01/11/2003 e sem o checkNumber com 3
select * from payments p 
where p.checkNumber not like '%3%'
and p.amount >= 5000
and p.paymentDate >= '2003-11-01';

-- Busca na tabela de linhas de produto com nome. estoque e descrição com filtros de preço de compra e quantidade de estoque
select p2.productName  as nome,
p2.quantityInStock as estoque,
p.htmlDescription as descrição
from productlines p 
inner join products p2 
on p2.productLine = p.productLine 
where p2.buyPrice < 200
and p2.quantityInStock >= 300;

-- Busca com a tabela de funcionarios utilizando case when e ordenação por id
select distinct
e.employeeNumber as ID,
case 
	when e.employeeNumber > 1200
	then 'Vendedor antigo'
	else 'Vendedor novo'
end as Funcionário
from employees e 
inner join customers c 
on c.salesRepEmployeeNumber = employeeNumber 
order by e.employeeNumber; 

-- Busca na tabela de produtos com case when e filtro na quantidade em estoque
select p.productName as Nome,
p.productCode as ID,
case 
		when p.buyPrice < 50
		then 'Preço baixo'
		else 'Preço alto'
end as Preço_de_compra
from products p 
where p.quantityInStock >= 100;

-- Busca na tabela de escritório com case when e ordenação por id
select o.postalCode as CEP,
	case 
		when o.city in ('Paris','Tokyo','Sydney','London')
		then 'Internacional'
		else 'EUA'
	end as Localização
from offices o 
order by o.officeCode;

-- Busca na tabela de detalhes na ordem com filtros de quantityOrdered e orderLineNumber e ordenados pelo codigo do produto
select * from orderdetails o 
where o.quantityOrdered > 30
and o.orderLineNumber > 4
order by o.productCode; 

-- Busca na tabela de ordens com filtro de status e numero da ordem
select * from orders o 
where o.status != 'Shipped'
and orderNumber > 10200;