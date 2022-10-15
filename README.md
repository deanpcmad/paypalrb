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
@authentication = PayPal::Authentication.new(client_id: "", client_secret: "")

@authentication.get_token
# =>  #<PayPal::AccessToken access_token="abc123", expires_in=123 
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/deanpcmad/paypalrb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
