module PayPal
  class Product < Object
   
    def initialize(options = {})
      options.delete "links"

      super options
    end
    
  end
end
