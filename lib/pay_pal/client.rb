module PayPal
  class Client
    attr_reader :access_token, :sandbox, :adapter

    def initialize(access_token:, sandbox:, partner_id: nil, adapter: Faraday.default_adapter, stubs: nil)
      @access_token = access_token
      @sandbox = sandbox
      @partner_id = partner_id
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def identity
      IdentityResource.new(self)
    end

    def products
      ProductsResource.new(self)
    end

    def orders
      OrdersResource.new(self)
    end

    def connection
      url = @sandbox ? "https://api-m.sandbox.paypal.com" : "https://api-m.paypal.com"

      headers = {}
      headers["User-Agent"] = "paypalrb/v#{VERSION} (github.com/deanpcmad/paypalrb)"

      if @partner_id
        headers["PayPal-Partner-Attribution-Id"] = @partner_id
      end

      @connection ||= Faraday.new(url) do |conn|
        conn.request :authorization, :Bearer, access_token
        conn.headers = headers
        conn.request :json

        conn.response :json

        conn.adapter adapter, @stubs
      end
    end

  end
end
