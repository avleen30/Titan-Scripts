# *if customer tagged with ‘Gold’*
# 1-50 qty: 10% off
# 51-100 qty: 20% off
# 100+: 30% off

# *if customer tagged with ‘silver’*
# 1-50 qty: 15% off
# 51-100 qty: 25% off
# 100+: 35% off

customer = Input.cart.customer
discount = 0

if customer
  Input.cart.line_items.each do |line_item|
    discount_message = ""
    customer.tags.each do |tag|
      if tag.include?("gold")
        if line_item.quantity.between?(1,50) then discount = 0.10 and discount_message = "Gold Member Discount: 10% off. Add " + (51 - line_item.quantity).to_s + " more for 20% off"
        elsif line_item.quantity.between?(51,100) then discount = 0.20 and discount_message = "Gold Member Discount: 20% off. Add " + (100 - line_item.quantity).to_s + " more for 30% off"
        elsif line_item.quantity > 100 then discount = 0.30 and discount_message = "Gold Member Discount: 30% off."
        end
      elsif tag.include?("silver")
        if line_item.quantity.between?(1,50) then discount = 0.15 and discount_message = "Silver Discount Discount: 15% off. Add " + (51 - line_item.quantity).to_s + " more for 25% off"
        elsif line_item.quantity.between?(51,100) then discount = 0.25 and discount_message = "Silver Discount Discount: 25% off. Add " + (100 - line_item.quantity).to_s + " more for 35% off"
        elsif line_item.quantity > 100 then discount = 0.35 and discount_message = "Silver Discount Discount: 35% off"
        end
      end
    end
  line_item.change_line_price(line_item.line_price * (1 - discount), message: discount_message)
  end
end

Output.cart = Input.cart
