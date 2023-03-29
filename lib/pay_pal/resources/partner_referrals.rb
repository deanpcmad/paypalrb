module PayPal
  class PartnerReferralsResource < Resource

    def retrieve(id:)
      response = get_request("v2/customer/partner-referrals/#{id}", headers: default_headers)
      PartnerReferral.new(response.body)
    end
    
    def create(**params)
      PartnerReferral.new post_request("/v2/customer/partner-referrals", 
        body: params,
        headers: default_headers
      ).body
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
