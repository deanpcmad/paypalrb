module PayPal
  class OrdersResource < Resource

    # def list
    #   response = get_request("v1/catalogs/products")
    #   Collection.from_response(response, kind: "products", type: Product)
    # end

    def retrieve(id:)
      response = get_request("v2/checkout/orders/#{id}")
      Order.new(response.body)
    end
    
    def create(intent:, units:, **params)
      attributes = {intent: intent.upcase, purchase_units: units}
      Order.new post_request("v2/checkout/orders", 
        body: attributes.merge(params),
        headers: {"Prefer" => "return=representation"}
      ).body
    end

  end
end
