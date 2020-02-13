=begin

Script to set a minuimum quantity per line item in the cart.
This example applies to all items but could be restricted
to those with a certain tag or id.

Questions: @jason

=end

itemMinimum = 5 #change this to your min limit

Input.cart.line_items.each do |line_item|
  if (line_item.quantity < itemMinimum)
    line_item.instance_variable_set(:@quantity, itemMinimum)
  end
end

Output.cart = Input.cart
