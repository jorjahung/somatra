class Soma < Struct.new :base_uri
  
  def self.auth(base_uri)
    #connects to soma and authenticates
    # if it worked it will then create new one
    new(base_uri)
  end

  def legend
    get(:"/legend")
  end

  def show_all
    get(:".json")
  end

  def show(id)
    get(:"/#{id}.json")
  end

  def show_results_for(test)
    get(:"/results/#{test}")
  end

  def send_blood_test_result(body_params)
    post(:"/remote", body_params)
  end

  private
  def get(url)
    HTTParty.get("#{base_uri}#{url}")
  end

  def post(url, body_params)
    HTTParty.post("#{base_uri}#{url}", body: body_params)
  end
end