-- ?? category accessories ?? 2013
select pc.Name , count(soh.SalesOrderID) 
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
where YEAR(soh.OrderDate) = 2013 and  pc.Name = 'Accessories'
group by pc.Name

-- ?????? ?? categories ???? ?? 2014
select pc.Name , count(soh.SalesOrderID) 
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
group by pc.Name

-- ?? ?? ?? subcategory ???? ? ?? DB
select year(soh.OrderDate), psc.Name , count(soh.SalesOrderID) 
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
group by psc.Name , year(soh.OrderDate)
order by year(soh.OrderDate) , psc.Name

--???? ???????? ?? ?? quarter ?? ??? 2014
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

-- ?????? ?? quarter ???? ???????? ???? ?? 50.000
select YEAR(soh.OrderDate) , DATEPART( QQ,soh.OrderDate) , sum(sod.OrderQty) 
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
group by  DATEPART( QQ,soh.OrderDate) ,  YEAR(soh.OrderDate)
having sum(sod.OrderQty) > 50.000

-- ?????? ?? sales 
select pc.Name ,sum(sod.OrderQty * sod.UnitPrice)
from Production.ProductCategory pc
join production.ProductSubcategory psc
on pc.ProductCategoryID = psc.ProductCategoryID
join Production.Product p 
on p.ProductSubcategoryID = psc.ProductSubcategoryID
join sales.SalesOrderDetail sod
on sod.ProductID = p.ProductID
join sales.SalesOrderHeader soh
on soh.SalesOrderID = sod.SalesOrderID
where YEAR(soh.OrderDate) = 2013 and  pc.Name = 'Accessories'
group by pc.Name
