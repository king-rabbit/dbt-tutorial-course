with products as (

	select product_id,
		department as product_department,
		cost as product_cost,
		retail_price as product_retail_price
	from {{ ref('stg_ecommerce__products')}}
)

select
	i.order_item_id,
	i.order_id,
	i.user_id,
	i.product_id,
	i.item_sale_price,
	p.product_department,
	p.product_cost,
	p.product_retail_price,
	i.item_sale_price - p.product_cost as item_profit,
	p.product_retail_price - i.item_sale_price as item_discount

from {{ ref('stg_ecommerce__order_items')}} as i
left join products as p
on i.product_id = p.product_id
