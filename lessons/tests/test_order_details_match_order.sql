/*
    Checks that, for any order, that the number of line items in the order_items table
	matches the num_items_ordered column in the orders table.

    Returns all of the rows where we don't get a match

    We could run multiple checks here (e.g. check only 1 user_id per order, or that the shipped_at timestamps
	are all the same for a given order), but this is just an example of a custom test.
*/


with order_details as (

	select order_id,
		count(*) as num_of_items_in_order
	from {{ ref('stg_ecommerce__order_items')}}
	group by 1

)

select o.order_id,
	o.num_of_item,
	od.num_of_items_in_order

from {{ ref('stg_ecommerce__orders')}} as o
full outer join order_details as od using(order_id)
where
	  -- All orders should have at least 1 item, and every item should tie to an order
    o.order_id IS NULL
    OR od.order_id IS NULL
    -- Number of items doesn't match
    OR o.num_of_item != od.num_of_items_in_order
