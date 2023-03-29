require 'active_support'

module PayPal
  class Client

    LIVE_URL    = "https://api-m.paypal.com"
    SANDBOX_URL = "https://api-m.sandbox.paypal.com"

    TOKEN_CACHE_KEY = "paypal_oauth_token"
    TOKEN_EXPIRY_MARGIN = 60 * 60

    attr_reader :client_id, :client_secret, :partner_id, :sandbox, :cache, :adapter

    def initialize(client_id:, client_secret:, partner_id: nil, sandbox: true, cache: ActiveSupport::Cache::MemoryStore.new, adapter: Faraday.default_adapter, stubs: nil)
      @client_id = client_id
      @client_secret = client_secret
      @partner_id = partner_id
      @sandbox = sandbox
      @cache = cache
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


    def auth_token(force: false)
      return @cache.read(TOKEN_CACHE_KEY) if @cache.exist?(TOKEN_CACHE_KEY) && force == false

      auth_response = authenticate

      @cache.fetch(TOKEN_CACHE_KEY, expires_in: auth_response["expires_in"] - TOKEN_EXPIRY_MARGIN) do
        auth_response["access_token"]
      end
    end


    def connection
      url = @sandbox ? SANDBOX_URL : LIVE_URL

      @connection ||= Faraday.new(url) do |conn|
        conn.request :authorization, :Bearer, auth_token
        conn.request :json

        conn.response :json

        conn.adapter adapter, @stubs
      end
    end

    private

    # Request an OAuth token from PayPal
    def authenticate
      url = @sandbox ? SANDBOX_URL : LIVE_URL
  
      request_helper = Faraday.new(url: url) do |conn|
        conn.request :authorization, :basic, client_id, client_secret
      end

      response = request_helper.post "/v1/oauth2/token?grant_type=client_credentials"

      JSON.parse(response.body)
    end

  end
end
