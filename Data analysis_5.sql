select ProductID,Name,ProductNumber
from production.Product

select e.NationalIDNumber,p.FirstName,p.LastName
from HumanResources.Employee e join Person.Person p
on e.BusinessEntityID = e.BusinessEntityID

select * 
from Production.Product

select pp.Name , pcs.Name
from production.Product pp join Production.ProductSubcategory pcs 
on pp.ProductSubcategoryID = pcs.ProductSubcategoryID

select pp.Name[product name] , pcs.Name[subcategory name] , pc.Name[category name]
from production.Product pp 
join Production.ProductSubcategory pcs 
on pp.ProductSubcategoryID = pcs.ProductSubcategoryID 
join production.ProductCategory pc
on pc.ProductCategoryID = pcs.ProductCategoryID
order by [product name]

select pp.Name[product name] , pcs.Name[subcategory name] , pc.Name[category name]
from production.Product pp 
join Production.ProductSubcategory pcs 
on pp.ProductSubcategoryID = pcs.ProductSubcategoryID 
join production.ProductCategory pc
on pc.ProductCategoryID = pcs.ProductCategoryID
order by [product name] desc


select pp.Name[product name] , pcs.Name[subcategory name] , pc.Name[category name]
from production.Product pp 
join Production.ProductSubcategory pcs 
on pp.ProductSubcategoryID = pcs.ProductSubcategoryID 
join production.ProductCategory pc
on pc.ProductCategoryID = pcs.ProductCategoryID
order by [product name] desc , [subcategory name]

select pp.Name[product name] , pcs.Name[subcategory name] , pc.Name[category name]
from production.Product pp 
join Production.ProductSubcategory pcs 
on pp.ProductSubcategoryID = pcs.ProductSubcategoryID 
join production.ProductCategory pc
on pc.ProductCategoryID = pcs.ProductCategoryID
order by [product name] desc

select pp.Name[product name] , pcs.Name[subcategory name] , pc.Name[category name]
from production.Product pp 
join Production.ProductSubcategory pcs 
on pp.ProductSubcategoryID = pcs.ProductSubcategoryID 
join production.ProductCategory pc
on pc.ProductCategoryID = pcs.ProductCategoryID
order by [product name] desc , [subcategory name] , [category name]

select pp.Name[product name] , pcs.Name[subcategory name] , pc.Name[category name]
from production.Product pp 
join Production.ProductSubcategory pcs 
on pp.ProductSubcategoryID = pcs.ProductSubcategoryID 
join production.ProductCategory pc
on pc.ProductCategoryID = pcs.ProductCategoryID
order by [product name] desc , [subcategory name]desc , [category name] 

select pp.FirstName, e.JobTitle , ed.Name
from HumanResources.EmployeeDepartmentHistory edh
join HumanResources.Department ed
on ed.DepartmentID = edh.DepartmentID
join HumanResources.Employee e
on e.BusinessEntityID = edh.BusinessEntityID
join Person.Person pp
on pp.BusinessEntityID = e.BusinessEntityID
order by FirstName

select p.Name , pc.Name , psc.Name , pd.Description
from Production.ProductCategory pc
join Production.ProductSubcategory psc
on pc.ProductCategoryID = psc.ProductCategoryID
join Production.Product p
on p.ProductSubcategoryID = psc.ProductSubcategoryID
join Production.ProductModel pm
on pm.ProductModelID = p.ProductModelID
join production.ProductModelProductDescriptionCulture pmpdc
on pmpdc.ProductModelID = pm.ProductModelID
join production.ProductDescription pd
on pd.ProductDescriptionID = pmpdc.ProductDescriptionID

select * from sales.Customer 

select c.CustomerID , p.BusinessEntityID , c.AccountNumber
from Sales.Customer c left join Person.Person p 
on p.BusinessEntityID = c.PersonID

select c.CustomerID , s.Name , c.StoreID
from sales.Store s left join sales.Customer c
on c.StoreID = s.BusinessEntityID

select c.CustomerID , s.Name , c.StoreID
from sales.Customer c right join sales.Store s
on c.StoreID = s.BusinessEntityID

select *
from Production.Product p

select *
from Production.Product p
where p.Color = 'black' 

select *
from Production.Product p
where p.Color = 'black' or p.Color = 'red' or p.Color = 'yellow'

select *
from Production.Product p
where p.Color in ('black' ,'red' , 'yellow')

select *
from production.Product p 
where p.StandardCost > 500 
order by p.StandardCost desc

select * 
from Production.Product p 
where p.Color = 'black'
and p.StandardCost > 1000

select * 
from Production.Product p 
where p.Color = 'black'
and p.StandardCost > 1000
or p.color = 'red'

select * 
from Production.Product p 
where p.Color in ( 'black' , 'red' )
and p.StandardCost > 1000

select * 
from Production.Product p 
where p.Color in ( 'black' , 'red' )
and p.StandardCost > 1000
order by p.StandardCost


select * 
from Production.Product p 
where p.Color not in ( 'black' , 'red' )
and p.StandardCost > 1000
order by p.StandardCost


select * 
from Production.Product p 
where p.Color <>  'black'
and p.StandardCost > 1000
order by p.StandardCost

select *
from sales.SalesOrderHeader soh
join sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.SalesOrderID

select soh.CustomerID , soh.SalesPersonID , soh.TerritoryID , sod.OrderQty , sod.ProductID 
from sales.SalesOrderHeader soh
join sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.SalesOrderID

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

select soh.SalesOrderID
from sales.SalesOrderHeader soh

select count (soh.SalesOrderID)
from sales.SalesOrderHeader soh

select soh.OrderDate[orderdate] , count (soh.SalesOrderID)
from sales.SalesOrderHeader soh
group by soh.OrderDate

select soh.OrderDate[orderdate] , max (soh.SalesOrderID)
from sales.SalesOrderHeader soh
group by soh.OrderDate

select soh.OrderDate[orderdate] , max (sod.OrderQty)
from sales.SalesOrderHeader soh
join sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.SalesOrderID
group by soh.OrderDate


select pc.Name category ,psc.Name subcategory , count(p.productid)
from Production.ProductCategory pc
join Production.ProductSubcategory psc
on pc.ProductCategoryID = psc.ProductCategoryID
join Production.Product p 
on psc.ProductSubcategoryID = p.ProductSubcategoryID


select d.Name , count(e.NationalIDNumber)
from HumanResources.Employee e
join HumanResources.EmployeeDepartmentHistory edh
on e.BusinessEntityID = edh.BusinessEntityID
join HumanResources.Department d
on d.DepartmentID = edh.DepartmentID
group by d.name
order by d.name

select COUNT(e.NationalIDNumber)
from HumanResources.Employee e

select d.Name , count(e.NationalIDNumber)
from HumanResources.Employee e
join HumanResources.EmployeeDepartmentHistory edh
on e.BusinessEntityID = edh.BusinessEntityID
join HumanResources.Department d
on d.DepartmentID = edh.DepartmentID
group by d.name
having count (e.BusinessEntityID)>100
order by d.name

select d.Name , count(e.NationalIDNumber)
from HumanResources.Employee e
join HumanResources.EmployeeDepartmentHistory edh
on e.BusinessEntityID = edh.BusinessEntityID
join HumanResources.Department d
on d.DepartmentID = edh.DepartmentID
group by d.name
having count (e.BusinessEntityID) between 10 and 50
order by d.name

select * 
from sales.SalesOrderHeader

select Soh.OrderDate count(soh.salesorderid)
from sales.SalesOrderHeader soh
group by soh.orderdate 