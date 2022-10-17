module PayPal
  class IdentityResource < Resource

    def info
      response = get_request("v1/identity/oauth2/userinfo?schema=paypalv1.1")
      Identity.new(response.body)
    end

  end
end
