select soh.SalesOrderID
from Sales.SalesOrderHeader soh

select count(soh.salesorderid)
from Sales.SalesOrderHeader soh





select soh.OrderDate,count(soh.salesorderid)
from Sales.SalesOrderHeader soh
group by soh.OrderDate

select soh.OrderDate,sod.ProductID,max(sod.OrderQty) maximum
from Sales.SalesOrderHeader soh join Sales.SalesOrderDetail sod
on soh.SalesOrderID=sod.SalesOrderID
group by soh.OrderDate,sod.ProductID
order by max(sod.OrderQty) desc

select pc.Name category , count(p.productid)
from Production.ProductCategory pc 
join Production.ProductSubcategory psc
on pc.ProductCategoryID=psc.ProductCategoryID
join Production.Product p
on psc.ProductSubcategoryID=p.ProductSubcategoryID
group by pc.Name



select pc.Name category ,psc.Name subcategory, count(p.productid)
from Production.ProductCategory pc 
join Production.ProductSubcategory psc
on pc.ProductCategoryID=psc.ProductCategoryID
join Production.Product p
on psc.ProductSubcategoryID=p.ProductSubcategoryID
group by pc.Name , psc.name
order by pc.Name


select pc.Name category ,psc.Name subcategory,p.ProductID, sum(sod.OrderQty)
from Production.ProductCategory pc 
join Production.ProductSubcategory psc
on pc.ProductCategoryID=psc.ProductCategoryID
join Production.Product p
on psc.ProductSubcategoryID=p.ProductSubcategoryID
join Sales.SalesOrderDetail sod
on sod.ProductID = p.ProductID
group by pc.Name , psc.name,p.ProductID
order by pc.Name

select d.Name department ,count(distinct edh.BusinessEntityID)
from HumanResources.Department d
join HumanResources.EmployeeDepartmentHistory edh
on d.DepartmentID = edh.DepartmentID
join HumanResources.Employee e
on e.BusinessEntityID = edh.BusinessEntityID
group by d.Name
order by d.Name


select d.Name department ,count(distinct edh.BusinessEntityID)
from HumanResources.Department d
join HumanResources.EmployeeDepartmentHistory edh
on d.DepartmentID = edh.DepartmentID
join HumanResources.Employee e
on e.BusinessEntityID = edh.BusinessEntityID
group by d.Name
having count(e.BusinessEntityID) between 10 and 50
order by d.Name

select * from Sales.SalesOrderHeader

select year(soh.OrderDate),count(soh.salesorderid)
from Sales.SalesOrderHeader soh
group by year(soh.OrderDate)
order  by YEAR(soh.orderdate)


select year(soh.OrderDate),datename(m,MONTH(soh.OrderDate)),count(soh.salesorderid)
from Sales.SalesOrderHeader soh
group by year(soh.OrderDate),datename(m,MONTH(soh.OrderDate))
order  by YEAR(soh.orderdate),datename(m,MONTH(soh.OrderDate) )

select SalesOrderID,ProductID,OrderQty,sod.ModifiedDate
from sales.SalesOrderDetail sod

select SalesOrderID,ProductID,OrderQty,sod.ModifiedDate
from sales.SalesOrderDetail sod
where sod.ModifiedDate between DATEADD(MM,-3,'20140601') and '20140601'

select SalesOrderID,ProductID,OrderQty,sod.ModifiedDate
from sales.SalesOrderDetail sod
where sod.ModifiedDate between DATEADD(DD,-90,'20140601') and '20140601'

select SalesOrderID,ProductID,OrderQty,sod.ModifiedDate
from sales.SalesOrderDetail sod
where sod.ModifiedDate between '20120101' and DATEADD(YY,2,'20120101') 

select YEAR(soh.OrderDate),DATEPART( QQ,soh.OrderDate),sum(sod.OrderQty)
from Sales.SalesOrderHeader soh join Sales.SalesOrderDetail sod
on soh.SalesOrderID=sod.SalesOrderID
group by YEAR(soh.OrderDate),DATEPART( QQ,soh.OrderDate) 
order by YEAR(soh.OrderDate),datepart(qq,soh.OrderDate)
-- where sod.ModifiedDate between '20120101' and DATEADD(YY,2,'20120101') 
select count(sod.SalesOrderID)
from Sales.SalesOrderDetail sod
where sod.ModifiedDate between  dateadd(YY,-10,GETDATE()) and GETDATE()

select e.BusinessEntityID,e.BirthDate,cast(DATEDIFF(YY,e.birthdate,GETDATE()) as varchar) +' year',cast(DATEDIFF(MM,e.birthdate,GETDATE()) as varchar) +' month' 
from HumanResources.Employee e