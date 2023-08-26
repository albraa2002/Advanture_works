use AdventureWorks2019
select * from Sales.Customer

select c.CustomerID , p.BusinessEntityID , c.AccountNumber
from Sales.Customer c left join person.Person p
on p.BusinessEntityID = c.PersonID

select c.AccountNumber,s.Name [store name]
from  Sales.Customer c
left join Sales.Store s
on c.StoreID =s.BusinessEntityID


select c.AccountNumber,s.Name [store name]
from Sales.Store s
right join Sales.Customer c
on c.StoreID =s.BusinessEntityID


select *
from Production.Product p
where p.Color =  'black' or p.Color = 'red' or p.Color = 'yellow'

select *
from Production.Product p
where p.Color in('black','red' ,'yellow')

select *
from Production.Product p
where p.StandardCost > 500
order by p.StandardCost desc

select *
from Production.Product p
where 
(p.Color = 'black'
and
p.StandardCost > 1000)
or
p.Color = 'red'

select *
from Production.Product p
where p.Color not in('black','red' ,'yellow')

select *
from Production.Product p
where p.Color <> 'red'


select *
from Production.Product p
where p.StandardCost between 26.9708 and 1000
order by p.StandardCost 

select soh.CustomerID,p.FirstName [customer name],soh.SalesPersonID,soh.TerritoryID,st.Name [territory name],sod.OrderQty,sod.ProductID,sod.UnitPrice,sod.UnitPriceDiscount
from Sales.SalesOrderHeader soh
join sales.SalesOrderDetail sod
on soh.SalesOrderID =  sod.SalesOrderID
join sales.Customer c
on soh.CustomerID = c.CustomerID
join Person.Person p
on p.BusinessEntityID = c.PersonID
join sales.SalesPerson sp
on sp.BusinessEntityID = soh.SalesPersonID
join sales.SalesTerritory st
on st.TerritoryID = soh.TerritoryID
join sales.SpecialOfferProduct sop
on sop.ProductID = sod.ProductID
and sop.SpecialOfferID = sod.SpecialOfferID
where sod.UnitPrice > 400
order by sod.UnitPrice


select soh.CustomerID,p.FirstName [customer name],soh.SalesPersonID,soh.TerritoryID,st.Name [territory name],sod.OrderQty,sod.ProductID,sod.UnitPrice,sod.UnitPriceDiscount
from Sales.SalesOrderHeader soh
join sales.SalesOrderDetail sod
on soh.SalesOrderID =  sod.SalesOrderID
join sales.Customer c
on soh.CustomerID = c.CustomerID
join Person.Person p
on p.BusinessEntityID = c.PersonID
join sales.SalesPerson sp
on sp.BusinessEntityID = soh.SalesPersonID
join sales.SalesTerritory st
on st.TerritoryID = soh.TerritoryID
join sales.SpecialOfferProduct sop
on sop.ProductID = sod.ProductID
and sop.SpecialOfferID = sod.SpecialOfferID



select soh.CustomerID,p.FirstName [customer name],soh.SalesPersonID,soh.TerritoryID,st.Name [territory name],sod.OrderQty,sod.ProductID,sod.UnitPrice,sod.UnitPriceDiscount
from Sales.SalesOrderHeader soh
join sales.SalesOrderDetail sod
on soh.SalesOrderID =  sod.SalesOrderID
join sales.Customer c
on soh.CustomerID = c.CustomerID
join Person.Person p
on p.BusinessEntityID = c.PersonID
join sales.SalesPerson sp
on sp.BusinessEntityID = soh.SalesPersonID
join sales.SalesTerritory st
on st.TerritoryID = soh.TerritoryID
join sales.SpecialOfferProduct sop
on sop.ProductID = sod.ProductID
and sop.SpecialOfferID = sod.SpecialOfferID
where p.FirstName like 'a%a'
or sod.ProductID like '7___'

select soh.SalesOrderID,sod.SalesOrderDetailID,p.FirstName [customer name],sod.ProductID,sod.OrderQty,sum(sod.UnitPrice) subtotal
from Sales.SalesOrderHeader soh
join sales.SalesOrderDetail sod
on soh.SalesOrderID =  sod.SalesOrderID
join sales.Customer c
on soh.CustomerID = c.CustomerID
join Person.Person p
on p.BusinessEntityID = c.PersonID
join sales.SalesPerson sp
on sp.BusinessEntityID = soh.SalesPersonID
join sales.SalesTerritory st
on st.TerritoryID = soh.TerritoryID
join sales.SpecialOfferProduct sop
on sop.ProductID = sod.ProductID
and sop.SpecialOfferID = sod.SpecialOfferID
where soh.SalesOrderID = 61227

select sod.SalesOrderID,COUNT(sod.OrderQty) [total items]
from Sales.SalesOrderDetail sod
group by sod.SalesOrderID
order by [total items] desc

select edh.DepartmentID,count(e.businessentityid)
from HumanResources.Employee e
join HumanResources.EmployeeDepartmentHistory edh
on edh.BusinessEntityID = e.BusinessEntityID
group by  edh.DepartmentID