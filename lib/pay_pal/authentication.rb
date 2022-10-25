module PayPal
  class Authentication

    attr_reader :client_id, :client_secret, :sandbox

    def initialize(client_id:, client_secret:, sandbox:, adapter: Faraday.default_adapter)
      @client_id = client_id
      @client_secret = client_secret
      @sandbox = sandbox
      @adapter = adapter
    end

    def get_token
      if @sandbox
        url = "https://api-m.sandbox.paypal.com"
      else
        url = "https://api-m.paypal.com"
      end

      request_helper = Faraday.new(url: url) do |conn|
        conn.request :authorization, :basic, client_id, client_secret
      end

      response = request_helper.post "/v1/oauth2/token?grant_type=client_credentials"

      body = JSON.parse(response.body)
      AccessToken.new(body)
    end

  end
end
