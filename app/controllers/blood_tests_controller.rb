class BloodTestsController < ApplicationController

  def new
    @blood_test = BloodTest.new
  end

  def create
    blood_test = SOMA.send_blood_test_result(params)
    redirect_to blood_test_path(blood_test['id'])
  end

  def show
    @legend = SOMA.legend
    @blood_test = SOMA.show(params[:id])
    set_ranges
    set_headers
  end

  def edit
    @blood_test = BloodTest.find(params[:id])
  end

  def update
    @blood_test = BloodTest.find(params[:id])
    @blood_test.update_attributes(blood_test_params)
    redirect_to blood_tests_path
  end

  def destroy
    @blood_test = BloodTest.find(params[:id])
    @blood_test.destroy
    redirect_to blood_tests_path
  end

  def index 
    prepare_blood_test_table
    @blood_tests = SOMA.show_all
  end

  def results
    render json: BloodTest.as_json(params[:name])
  end

  def legend
    render json: BloodTest.legend_as_json
  end

  def omnigraph
    prepare_blood_test_table
    blood_tests =  @legend.inject({}) do |hash, (property_name, values)| 
      hash.merge({ property_name => SOMA.show_results_for(property_name).parsed_response })
    end
    blood_tests["hb"].each          { |d| d["result"] = ((d["result"] * 8.9) - 72.35).to_i }
    blood_tests["mcv"].each         { |d| d["result"] = ((d["result"] * 2) - 150).to_i }
    blood_tests["wbc"].each         { |d| d["result"] = ((d["result"] * 5.7) + 7.2).to_i }
    blood_tests["platelets"].each   { |d| d["result"] = ((d["result"] * 0.13) + 11.8).to_i }
    blood_tests["neutrophils"].each { |d| d["result"] = ((d["result"] * 8) + 10).to_i }
    blood_tests["lymphocytes"].each { |d| d["result"] = ((d["result"] * 10.5) + 19.5).to_i }
    blood_tests["alt"].each         { |d| d["result"] = ((d["result"] * 1.3) + 17).to_i }
    blood_tests["alk_phos"].each    { |d| d["result"] = ((d["result"] * 0.388) + 12.928).to_i }
    blood_tests["creatinine"].each  { |d| d["result"] = ((d["result"] * 0.833) - 10).to_i }
    blood_tests["esr"].each         { |d| d["result"] = ((d["result"] * 1.538) + 30).to_i }
    blood_tests["wbc"].each         { |d| d["result"] = ((d["result"] * 8) + 30).to_i }

    # blood_tests.each do |test|
    #   test["hb"]  = (test["hb"] * 8.9) - 72.35
    #   test["mcv"] = (test["mcv"] * 2) - 150
    #   test["wbc"] = (test["wbc"] * 5.7) + 7.2
    #   test["platelets"] = (test["platelets"] * 0.13) + 11.8
    #   test["neutrophils"] = (test["neutrophils"] * 8) + 10
    #   test["lymphocytes"] = (test["lymphocytes"] * 10.5) + 19.5
    #   test["alt"] = (test["alt"] * 1.3) + 17
    #   test["alk_phos"] = (test["alk_phos"] * 0.388) + 12.928 if test["alk_phos"]
    #   test["creatinine"] = (test["creatinine"] * 0.833) - 10
    #   test["esr"] = (test["esr"] * 1.538) + 30
    #   test["crp"] = (test["crp"].to_i * 8) + 30
    # end
    @blood_tests = blood_tests
  end

  private

  def blood_test_params
    params.require(:blood_test).permit(
      :taken_on,
      :hb,
      :mcv,
      :wbc,
      :platelets,
      :neutrophils,
      :lymphocytes,
      :alt,
      :alk_phos,
      :creatinine,
      :esr,
      :crp
      )
  end

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

  def prepare_blood_test_table
    @legend = SOMA.legend
    set_headers
    set_units
    set_methods
    set_ranges
  end
end
