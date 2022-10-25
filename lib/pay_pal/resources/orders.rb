module PayPal
  class OrdersResource < Resource

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

    def create_payment(intent:, description:, currency:, value:, **params)
      items = [{
        description: description,
        amount: {
          currency_code: currency, value: value
        }
      }]

      attributes = {intent: intent.upcase, purchase_units: items}
      Order.new post_request("v2/checkout/orders", 
        body: attributes.merge(params),
        headers: {"Prefer" => "return=representation"}
      ).body
    end

    def create_single(intent:, title:, description:, currency:, value:, **params)
      items = [{
        items: [
          {name: title, description: description, quantity: 1, unit_amount: {currency_code: currency, value: value}}
        ],
        amount: {
          currency_code: currency, value: value,
          breakdown: {
            item_total: {
              currency_code: currency, value: value
            }
          }
        }
      }]

      attributes = {intent: intent.upcase, purchase_units: items}
      Order.new post_request("v2/checkout/orders", 
        body: attributes.merge(params),
        headers: {"Prefer" => "return=representation"}
      ).body
    end

    def authorize(id:)
      response = post_request("v2/checkout/orders/#{id}/authorize", body: {})
      Order.new(response.body)
    end

    def capture(id:)
      response = post_request("v2/checkout/orders/#{id}/capture", body: {})
      Order.new(response.body)
    end

    def confirm(id:, source:)
      attributes = {payment_source: source}
      response = post_request("v2/checkout/orders/#{id}/confirm-payment-source", body: attributes.merge(params))
      Order.new(response.body)
    end

  end
end
