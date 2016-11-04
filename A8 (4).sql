--1
select itemid, Description, listprice
FROM CIS310A8..merchandise
where listprice > (
		select avg (listprice)
		FROM CIS310A8..merchandise
		)
--2
select s.Itemid,avg(o.cost)[Average Cost],avg(s.saleprice) [Average Sale Price]
FROM CIS310A8..saleitem s inner join CIS310A8..orderitem o on s.itemid = o.itemid
group by s.itemid
having avg(s.saleprice) > 1.5*avg(o.cost)
order by s.itemid
--3
select e.EmployeeID,	e.LastName,	sum (si.saleprice)TotalSales, (sum (si.saleprice)/(select sum(saleprice)
																						from CIS310A8..saleitem))*100 as PctSales
FROM CIS310A8..sale s inner join CIS310A8..employee e on s.employeeid =e.employeeid
	inner join CIS310A8..saleitem si on si.saleid= s.saleid
group by e.employeeid, e.lastname
--
select sum (si.saleprice)TotalSales
FROM CIS310A8..saleitem si
group by itemid
--4
select top 1 s.SupplierID, s.Name, (sum(m.shippingcost)/(select sum(shippingcost) from CIS310A8..merchandiseorder))*100 as PctShipCost												
FROM CIS310A8..supplier s inner join CIS310A8..merchandiseorder m on s.supplierid =m.supplierid
group by s.SupplierID,	s.Name
order by PctShipCost desc
--5
select  top 1 c.CustomerID,	c.LastName,	c.FirstName, sum(si.saleprice)MercTotal, sum(sa.saleprice)AnimalTotal,(sum(si.saleprice)+sum(sa.saleprice)) GrandTotal
FROM CIS310A8..customer c inner join CIS310A8..sale s on c.Customerid = s.Customerid inner join 
CIS310A8..saleanimal sa on sa.saleid =s.saleid inner join CIS310A8..saleitem si on si.saleid =s.saleid 
group by c.CustomerID,	c.LastName,	c.FirstName
order by grandtotal desc
--6*
select c.CustomerID,	c.LastName,	c.FirstName, si.saleprice as MayTotal
FROM CIS310A8..customer c inner join CIS310A8..sale s on c.Customerid = s.Customerid
inner join CIS310A8..saleitem si on si.saleid =s.saleid
where si.saleprice > 100 and (DATEPART(MM, s.saledate)=7) or si.saleprice > 50 and (DATEPART(MM, s.saledate)=10)
--7
SELECT    m.DESCRIPTION, m.ITEMID, m.QuantityOnHand AS [PURCHASED], COUNT(si.SALEID) AS [SOLD], m.QuantityOnHand - COUNT(si.SaleID) AS [NETINCREASE]
FROM    CIS310A8..MERCHANDISE m INNER JOIN CIS310A8..SALEITEM si ON m.ITEMID = si.ITEMID INNER JOIN CIS310A8..SALE s ON s.SALEID = si.SALEID
WHERE  m.Description LIKE '%Premium' 
GROUP BY m.ITEMID, m.Description,m.QuantityOnHand  
--8
select m.ItemID,	Description,	ListPrice
FROM CIS310A8..merchandise m inner join  CIS310A8..saleitem si on m.itemid= si.itemid
inner join CIS310A8..sale s on s.saleid =si.saleid
where m.listprice > 50 and (DATEPART(MM, s.saledate)=5) and si.saleprice = 0
--9
select distinct m.ItemID,	m.Description,	m.QuantityOnHand,	si.ItemID
FROM    CIS310A8..Merchandise m full OUTER JOIN CIS310A8..SaleItem si on m.ItemID = si.ItemID
full outer join CIS310A8..sale s on s.saleid =si.saleid
WHERE    m.QuantityOnHand >100 and (DATEPART(yyyy, s.saledate)<>2004)
order by m.itemid
--10
select distinct m.ItemID,	m.Description,	m.QuantityOnHand,	si.ItemID
FROM    CIS310A8..Merchandise m full OUTER JOIN CIS310A8..SaleItem si on m.ItemID = si.ItemID
full outer join CIS310A8..sale s on s.saleid =si.saleid
where    m.QuantityOnHand in (select QuantityOnHand
							 from CIS310A8..Merchandise 
							 where QuantityOnHand >100) 
and (DATEPART(yyyy, s.saledate)<>2004)
order by m.itemid
--11
CREATE TABLE TotalCategory
(
	Category VARCHAR(50),
	low int,
	High int	
)
INSERT INTO TotalCategory
(category, low, High)
VALUES('weak', 0, 200)
INSERT INTO TotalCategory
VALUES('Good', 200, 800)
INSERT INTO TotalCategory
VALUES('Best', 800, 10000)

select  c.CustomerID,	c.LastName,	c.FirstName,(sum(si.saleprice)+sum(sa.saleprice)) GrandTotal
FROM CIS310A8..customer c inner join CIS310A8..sale s on c.Customerid = s.Customerid inner join 
CIS310A8..saleanimal sa on sa.saleid =s.saleid inner join CIS310A8..saleitem si on si.saleid =s.saleid 
group by c.CustomerID,	c.LastName,	c.FirstName
order by grandtotal desc
--12
select distinct s.Name as [Supplier Name], ordertype =
(CASE WHEN a.orderid IS NULL THEN 'Merchandise Order' ELSE 'Animal Order' END)								
FROM CIS310A8..supplier s left outer join CIS310A8..animalorder a on s.supplierid =a.supplierid
left outer join CIS310A8..merchandiseorder m on s.supplierid =m.supplierid
where (DATEPART(MM, a.OrderDate)=5)or  (DATEPART(MM,m.OrderDate)=5)
group by s.Name, a.orderid,	m.ponumber
--13

--14
drop table cis310a8..Category
--15
DELETE TOP (1)
FROM    TotalCategory
WHERE Category = 'Weak'
--16
--copy table
SELECT *
INTO employeecopy
FROM cis310a8..employee;
--delete data
delete 
from employeecopy
--copy data 
insert Employeecopy
select *
from cis310a8..employee