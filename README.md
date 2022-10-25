# PayPalRB

**This library is a work in progress**

PayPalRB is a Ruby library for interacting with the PayPal API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paypalrb'
```

## Usage

### Generate an Access Token

Firstly you'll need to generate an Access Token. Set the Client ID and Secret
An Access Token will be an OAuth2 token generated after authentication. 


```ruby
@authentication = PayPal::Authentication.new(
  client_id: "",
  client_secret: "",
  sandbox: true
)

@authentication.get_token
# =>  #<PayPal::AccessToken access_token="abc123", expires_in=123 
```

Then once you have an access token, set it like so:

```ruby
@client = PayPal::Client.new(access_token: "abc123", sandbox: true)
```

### Products

```ruby
# Retrieve a list of products
@client.products.list

# Retrieve a product by its ID
@client.products.retrieve id: "123"

# Create a product
# Type should be physical, digital or service
# Docs: https://developer.paypal.com/docs/api/catalog-products/v1/#products_create
@client.products.create name: "My Product", type: ""
```

### Orders

```ruby
# Retrieves an Order
@client.orders.retrieve id: "abc123"

# Creates an Order
# Intent should be either capture or authorize
# Items is an array of purchase units
# Docs: https://developer.paypal.com/docs/api/orders/v2/#orders_create
@client.orders.create intent: "capture", items: []

# As above but creates an order for the total of value given
@client.orders.create_payment intent: "capture", description: "A Payment",
  currency: "GBP", value: "25.00"

# As above but creates an order for a single item
@client.orders.create_single intent: "capture", title: "Item Title",
  description: "Item Description", currency: "GBP", value: "25.00"

# Authorizes payment for an order. The buyer must first approve the order.
@client.orders.authorize id: "123abc"

# Captures payment for an order. The buyer must first approve the order.
@client.orders.capture id: "123abc"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/deanpcmad/paypalrb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
