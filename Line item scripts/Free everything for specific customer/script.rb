# customer email to discount:
InternalStaff = "jason.bowman@shopify.com"

if (Input.cart.customer)
  if Input.cart.customer.email == InternalStaff
    DISCOUNT_PERCENT = 0
  else
    Output.cart = Input.cart
    exit
  end
else
  Output.cart = Input.cart
  exit
end

Input.cart.line_items.each do |line_item|
  line_item.change_line_price(
    line_item.line_price * DISCOUNT_PERCENT,
    message: 'Internal Staff Discount',
  )
end

Output.cart = Input.cart
