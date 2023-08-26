select c.CustomerID,p.FirstName[CustomerID],soh.SalesPersonID,st.TerritoryID,st.Name[Territory Name],pp.ProductID,pp.Name[Prouduct Name],sod.OrderQty,sod.UnitPrice,sod.UnitPriceDiscount
from Person.Person p  
join Sales.Customer c
on p.BusinessEntityID=c.CustomerID
join Sales.SalesTerritory st
on st.TerritoryID=c.TerritoryID
join Sales.SalesOrderHeader soh
on soh.TerritoryID =st.TerritoryID
join Sales.SalesOrderDetail sod
on sod.SalesOrderID=soh.SalesOrderID
join Sales.SpecialOfferProduct sop
on sop.ProductID= sod.ProductID
join Production.Product pp
on pp.ProductID=sop.ProductID
