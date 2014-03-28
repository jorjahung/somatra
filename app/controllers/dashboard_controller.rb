require 'open-uri'

class DashboardController < ApplicationController

  def index
    if current_user
      check_for_moves_auth
      set_moves_data if current_user.moves_auth_token  
      @legend = SOMA.legend
      set_headers
      set_methods
      set_ranges
      set_blood_tests
      set_dangerous_blood_tests_by_date
    end
  end

  def moves_callback
    new_token = moves_client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
    current_user.moves_auth_token = new_token.token
    current_user.save
    redirect_to root_path
  end

  private

  def set_headers
    @headers = @legend.map { |property_name, values| values["name"] }
  end

  def set_units
    @units = @legend.map { |property_name, values| values["unit"] }
  end

  def set_methods
    @methods = @legend.map { |property_name, values| property_name }
  end

  def set_ranges
    @ranges =  @legend.inject({}) do |hash, (property_name, values)| 
      hash.merge({ property_name => (values['min'] .. values['max']) })
    end
  end

  def set_blood_tests
    @blood_tests =  @legend.inject({}) do |hash, (property_name, values)| 
      hash.merge({ property_name => SOMA.show_results_for(current_user.id, property_name).body })
    end
  end

  def set_dangerous_blood_tests_by_date
    @dangerous_blood_tests_by_date =  SOMA.show_dangerous_results(current_user.id)
  end

  def moves_client
    OAuth2::Client.new(
      ENV['MOVES_CLIENT_ID'],
      ENV['MOVES_CLIENT_SECRET'],
      site:          'https://api.moves-app.com',
      authorize_url: 'https://api.moves-app.com/oauth/v1/authorize',
      token_url:     'https://api.moves-app.com/oauth/v1/access_token'
    )
  end

  def check_for_moves_auth
    if !current_user.moves_auth_token.nil?
      @moves_authorized = false
    else
      @moves_authorize_uri = moves_client.auth_code.authorize_url(:redirect_uri => redirect_uri, scope: 'activity')
      @moves_authorized = true
    end
  end

  def set_moves_data
    @json = access_token.get("/api/1.1/user/summary/daily?pastDays=7").parsed
    @steps = @json.map { |day|
      unless day["summary"].nil?
        (day["summary"].find { |a| a["group"] == "walking"})["steps"]
      else
        0
      end
    }
  end

  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/moves/callback'
    uri.query = nil
    uri.to_s
    'http://localhost:8080/moves/callback'
  end

  def access_token
    OAuth2::AccessToken.new(moves_client, current_user.moves_auth_token, :refresh_token => session[:refresh_token])
  end

end
