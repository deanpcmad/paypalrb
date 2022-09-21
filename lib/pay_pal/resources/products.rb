module PayPal
  class ProductsResource < Resource

    def list
      response = get_request("v1/catalogs/products")
      Collection.from_response(response, kind: "products", type: Product)
    end

    def retrieve(id:)
      response = get_request("v1/catalogs/products/#{id}")
      Product.new(response.body)
    end
    
    def create(name:, type:, **params)
      attributes = {name: name, type: type}
      Product.new post_request("v1/catalogs/products", body: attributes.merge(params)).body
    end

  end
end
