require "faraday"
require "json"

require_relative "pay_pal/version"

module PayPal

  autoload :Client, "pay_pal/client"
  autoload :Collection, "pay_pal/collection"
  autoload :Error, "pay_pal/error"
  autoload :Resource, "pay_pal/resource"
  autoload :Object, "pay_pal/object"
  
  autoload :Authentication, "pay_pal/authentication"

  autoload :ProductsResource, "pay_pal/resources/products"
  autoload :OrdersResource, "pay_pal/resources/orders"
  autoload :IdentityResource, "pay_pal/resources/identity"

  autoload :AccessToken, "pay_pal/objects/access_token"
  autoload :Product, "pay_pal/objects/product"
  autoload :Order, "pay_pal/objects/order"
  autoload :Identity, "pay_pal/objects/identity"

end
