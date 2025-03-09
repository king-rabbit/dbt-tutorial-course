{#
	commnents that won't appear in the compiled SQL
#}

{% set my_long_variable %}

	select 1 as my_col

{% endset %}

{{my_long_variable}}

{% set my_list = ['user_id', 'created_at']%}

{{my_list}}

select
{%- for item in my_list%}
	{{ item }}{% if not loop.last %},{% endif %}
{%- endfor %}
;