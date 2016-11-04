create TRIGGER Trigger_update_onhand ON [dbo].[LGLINE]
AFTER INSERT,DELETE,UPDATE
AS
begin

	declare @prod_sku nvarchar(15);
	declare @total int;

	IF(EXISTS (SELECT * FROM INSERTED))
	begin 
	DECLARE INSERTED_CURSOR CURSOR FOR
	select prod_sku, sum(line_qty) as total
	from inserted
	group by PROD_SKU
	open inserted_cursor
	fetch next from inserted_cursor
	into @prod_sku, @total
	while (@@FETCH_STATUS =0)
	begin
	update LGPRODUCT
	set PROD_QOH=PROD_QOH-@total
	where PROD_SKU= @prod_sku
	fetch next from inserted_cursor 
	into @prod_sku, @total
	end
	close inserted_cursor
	deallocate inserted_cursor
end
	IF(EXISTS (SELECT * FROM deleted))
	begin 
	DECLARE deleted_CURSOR CURSOR FOR
	select prod_sku, sum(line_qty) as total
	from deleted
	group by PROD_SKU
	open deleted_cursor
	fetch next from deleted_cursor
	into @prod_sku, @total
	while (@@FETCH_STATUS =0)
	begin
	update LGPRODUCT
	set PROD_QOH=PROD_QOH+@total
	where PROD_SKU= @prod_sku
	fetch next from inserted_cursor 
	into @prod_sku, @total
	end
	close deleted_cursor
	deallocate deleted_cursor
	end

end 

update LGLINE
set LINE_QTY=LINE_QTY+10
where PROD_SKU='1010-miw' and INV_NUM=133

update LGLINE
set LINE_QTY=LINE_QTY-10
where PROD_SKU='1010-miw' and INV_NUM=133

delete from LGLINE
where PROD_SKU='1010-miw' and INV_NUM=133

insert into LGLINE
values (140,1,'1010-miw',12,30)

insert into LGLINE
values (2231,1,'1010-miw',12,30)

update LGLINE
set LINE_QTY=LINE_QTY-50
where PROD_SKU='1010-miw' and INV_NUM=2231

select *
from LGLINE
where PROD_SKU='1010-miw'
order by INV_NUM

select PROD_SKU,PROD_QOH
from  LGPRODUCT
select *
from  LGPRODUCT
where PROD_SKU='1010-miw'