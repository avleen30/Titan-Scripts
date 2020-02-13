In this script example, there are 2 customer tags
1) air
2) airvip

If a customer is tagged as "air", they will get a $15 discount off their order total.  
If a customer is tagged as "airvip", they will get a $25 discount off their order total.  

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
