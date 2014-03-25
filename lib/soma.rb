class Soma < Struct.new :base_uri, :token
  
  def self.auth(base_uri)
    response = HTTParty.post("#{ENV['BASE_URI']}/app_auth", body: {app: 1, key: "#{ENV['SOMA_KEY']}"})
    puts "%" * 80
    puts "%" * 80
    puts response.headers.inspect
    puts "%" * 80
    puts "%" * 80
    if response.code == 200
      token = create_token_with(response.body)
      #connects to soma and authenticates
      # if it worked it will then create new one
      return new(base_uri, token)
    else
      raise "Could not connect to SOMA"
    end
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

  def self.create_token_with(response)
    puts Digest::HMAC.hexdigest(JSON.parse(response)['challenge'], "#{ENV['SOMA_SECRET']}", Digest::SHA1)
  end
end