module PayPal
  class Client
    attr_reader :access_token, :sandbox, :adapter

    def initialize(access_token:, sandbox: true, adapter: Faraday.default_adapter, stubs: nil)
      @access_token = access_token
      @sandbox = sandbox
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def products
      ProductsResource.new(self)
    end

    def connection
      url = @sandbox ? "https://api-m.sandbox.paypal.com" : "https://api-m.paypal.com"

      @connection ||= Faraday.new(url) do |conn|
        conn.request :authorization, :Bearer, access_token
        conn.request :json

        conn.response :json

        conn.adapter adapter, @stubs
      end
    end

  end
end
