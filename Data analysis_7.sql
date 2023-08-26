select sod.ProductID , sod.OrderQty
from sales.SalesOrderDetail sod
order by sod.ProductID

select sod.ProductID , sod.OrderQty , IIF(sod.OrderQty>10,'special','ordinal')[specialicty]
from sales.SalesOrderDetail sod
order by sod.ProductID

select p.Name ,sod.UnitPrice ,IIF( sod.UnitPrice >100 , 'high price' , 'low price')[product performance]
from Production.Product p 
join Sales.SalesOrderDetail sod
on p.ProductID = sod.ProductID

select p.Name ,p.ListPrice ,IIF( p.listprice >500 , 'high price' , iif(p.listprice>100,'Medium price' , 'low price'))[product performance]
from Production.Product p 

-- في حالةاختبار القيم الفردية 
select p.name , p.listprice ,
case p.listprice
when  500 then 'high price'
when  100 then 'meduim price'
else 'low price' 
end
from production.product p 

--في حالة لو انا هاحط شروط من عندي 
select p.name , p.listprice ,
case 
when p.ListPrice> 500 then 'high price'
when p.ListPrice> 100 then 'meduim price'
else 'low price' 
end
from production.product p 

select sod.SalesOrderID , sum (sod.OrderQty * sod.UnitPrice) total ,
case 
when sum (sod.OrderQty * sod.UnitPrice)>1000 then 'high'
else 'low'
end
from Sales.SalesOrderDetail sod
group by sod.SalesOrderID

select sod.SalesOrderID , sum (sod.OrderQty * sod.UnitPrice) total ,
case 
when sum (sod.OrderQty * sod.UnitPrice)>1000 then 'high'
else 'low'
end [level]
from Sales.SalesOrderDetail sod
group by sod.SalesOrderID

select *
from HumanResources.Employee e 

select e.NationalIDNumber , e.OrganizationLevel , case
when e.OrganizationLevel is null then 0 else 1 end [binary classification]
from HumanResources.Employee e 

select pc.Name , YEAR(soh.OrderDate) , DATEPART( QQ,soh.OrderDate) , sum(sod.OrderQty) 
from Production.ProductCategory pc
join production.ProductSubcategory psc
on pc.ProductCategoryID = psc.ProductCategoryID
join Production.Product p 
on p.ProductSubcategoryID = psc.ProductSubcategoryID
join sales.SpecialOfferProduct sop
on p.ProductID = sop.ProductID
join sales.SalesOrderDetail sod
on sod.SpecialOfferID = sop.SpecialOfferID
join sales.SalesOrderHeader soh
on soh.SalesOrderID = sod.SalesOrderID
where YEAR(soh.OrderDate) = 2014 
group by  DATEPART( QQ,soh.OrderDate) , pc.Name , YEAR(soh.OrderDate)

