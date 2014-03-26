class DashboardController < ApplicationController

  def index
    @legend = SOMA.legend
    set_headers
    set_methods
    set_ranges
    set_blood_tests
    set_dangerous_blood_tests_by_date
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
      hash.merge({ property_name => SOMA.show_results_for(property_name).body })
    end
  end

  def set_dangerous_blood_tests_by_date
    @dangerous_blood_tests_by_date =  SOMA.show_dangerous_results
  end

end
