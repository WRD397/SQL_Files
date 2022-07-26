-- Question: Let’s say we want details about all farmer’s market booths and every vendor booth assignment for every market date.
-- the order is thus as we dont wanna miss a single booth info

SELECT b.booth_number, b.booth_type, vba.market_date, v.vendor_id, v.vendor_name
FROM booth b 
LEFT join vendor_booth_assignments vba
	on b.booth_number = vba.booth_number
left join vendor v
	on v.vendor_id = vba.vendor_id
