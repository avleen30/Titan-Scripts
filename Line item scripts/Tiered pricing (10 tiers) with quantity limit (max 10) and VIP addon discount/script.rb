# Example code to show a discount by quantity
# Also limit to total number of items in the cart
# If you add a customer with a Shopify email address an additional VIP discount will be added.

QUANTITY_LIMIT = 10
VIP_ADDITIONAL_DISCOUNT = 25 # 25%
DISCOUNTS_BY_QUANTITY = {
  10 => 30, #30% discount
  9 => 23,
  8 => 17,
  7 => 15,
  6 => 12,
  5 => 10, #10% discount
  4 => 7,
  3 => 6,
  2 => 5,
  1 => 0 #0% discount
}

Input.cart.line_items.each do |line_item|

  # skip applying discounts to Gift Cards
  next if line_item.variant.product.gift_card?
  # -----------------------------------------------------

  # match the current quantity for the line item to our discount values
  quantity, discount = DISCOUNTS_BY_QUANTITY.find do | quantity, _|
    line_item.quantity >= quantity
  end
  # -----------------------------------------------------

  # Force a maximum amount of line items per order. No more than 10 each.
  if(line_item.quantity > QUANTITY_LIMIT)
     line_item.instance_variable_set(:@quantity, QUANTITY_LIMIT)
     puts "Forcing the max items in the cart to #{QUANTITY_LIMIT} for #{line_item.variant.id}"
  end
  # -----------------------------------------------------

  # If the customer has a Shopify email address, give an additional 25% discount.
  # This logic can also apply to customer tags, order count, etc
  if (Input.cart.customer)
    if Input.cart.customer.email.end_with? "shopify.com"
      discount += VIP_ADDITIONAL_DISCOUNT
    end
  end
  # -----------------------------------------------------

  next unless discount

  # Change the price and leave a message.
  message = "#{discount}% off when buying #{quantity} items."
  line_item.change_line_price(
    line_item.line_price * (Decimal.new(1) - discount.to_d / 100),
    message: message,
  )
  # -----------------------------------------------------

end

Output.cart = Input.cart
