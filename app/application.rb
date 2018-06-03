class Application

  @@items = []
  @@cart =[]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      @@cart.each do |cart|
        resp.write "#{cart}\n"
      end
      if @@cart.empty?
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/add/)
      search_term=req.params["item"]
      resp.write shopping_cart(search_term)
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
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

  def shopping_cart(search_term)
    if @@items.include?(search_term) && @@cart.include?(search_term)==false
      @@cart << search_term
      return "added #{search_term}"
    else
      return "We don't have that item"
    end
  end
end
