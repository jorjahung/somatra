class DashboardController < ApplicationController

  def index
    @legend = SOMA.legend
    set_headers
    set_methods
    set_ranges
    set_blood_tests
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
      hash.merge({ property_name => (values['max'] .. values['min']) })
    end
  end

  def set_blood_tests
    @blood_tests =  @legend.inject({}) do |hash, (property_name, values)| 
      hash.merge({ property_name => SOMA.show_results_for(property_name).body })
    end
  end
end
