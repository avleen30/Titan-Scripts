TAG = "air"
TAG2 = "airvip"
customer = Input.cart.customer
discount = 0
message = ""
if customer
  if customer.tags.include?(TAG) #determines if the customer is tagged air
    discount = 1500 #number of Dollars to discount in cents
    message = "Air discount"
  elsif customer.tags.include?(TAG2) #determines if the customer is tagged airvip
    discount = 2500 #number of Dollars to discount in cents
    message = "AirVIP discount"
  end
end

Input.cart.line_items.each do |line_item|
  product = line_item.variant.product
  next if product.gift_card?
  # next unless product.id == 5401566023
  line_item.change_line_price(line_item.line_price - Money.new(cents: discount), message: message) unless discount == 0
end

Output.cart = Input.cart
