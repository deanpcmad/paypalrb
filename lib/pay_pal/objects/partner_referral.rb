module PayPal
  class PartnerReferral < Object

    def initialize(options = {})
      super options

      self.id = options["links"][0]["href"].gsub("/v2/customer/partner-referrals/", "").gsub("https://api.paypal.com", "").gsub("https://api.sandbox.paypal.com", "")
      self.action_url = options["links"][1]["href"]
    end
    
  end
end
