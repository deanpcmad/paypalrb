module PayPal
  class OrdersResource < Resource

    def retrieve(id:)
      response = get_request("v2/checkout/orders/#{id}", headers: default_headers)
      Order.new(response.body)
    end
    
    def create(intent:, units:, **params)
      attributes = {intent: intent.upcase, purchase_units: units}
      Order.new post_request("v2/checkout/orders", 
        body: attributes.merge(params),
        headers: default_headers
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
        headers: default_headers
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
        headers: default_headers
      ).body
    end

    def authorize(id:)
      response = post_request("v2/checkout/orders/#{id}/authorize", body: {}, headers: default_headers)
      Order.new(response.body)
    end

    def capture(id:)
      response = post_request("v2/checkout/orders/#{id}/capture", body: {}, headers: default_headers)
      Order.new(response.body)
    end

    def confirm(id:, source:)
      attributes = {payment_source: source}
      response = post_request("v2/checkout/orders/#{id}/confirm-payment-source", body: attributes.merge(params), headers: default_headers)
      Order.new(response.body)
    end

    private

    def default_headers
      {
        "Prefer" => "return=representation",
        "PayPal-Partner-Attribution-Id" => @partner_id
      }
    end

  end
end
