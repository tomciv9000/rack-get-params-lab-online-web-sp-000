class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
       @@cart.empty?
        return "Your cart is empty"
        @@cart.each do |cart_item|
          resp.write "#{cart_item}\n"
        end
    elsif req.path.match(/add/)
      requested_item = req.params["item"]
      if @@items.include?(requested_item)
        @@cart << requested_item
        return "#{requested_item} has been added to your cart."
      else
        return "#{requested_item} is not available."
      end
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
