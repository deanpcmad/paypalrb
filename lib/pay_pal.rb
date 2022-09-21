require "faraday"
require "json"

require_relative "pay_pal/version"

module PayPal

  autoload :Client, "pay_pal/client"
  autoload :Collection, "pay_pal/collection"
  autoload :Error, "pay_pal/error"
  autoload :Resource, "pay_pal/resource"
  autoload :Object, "pay_pal/object"
  
  autoload :AccessToken, "pay_pal/access_token"

  autoload :ProductsResource, "pay_pal/resources/products"

  autoload :Product, "pay_pal/objects/product"

end
