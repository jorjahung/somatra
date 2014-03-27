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

  def omnigraph
    prepare_blood_test_table
    prepare_blood_tests_for_omnigraph
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

  def prepare_blood_tests_for_omnigraph
    blood_tests = SOMA.show_all
    @legend = SOMA.legend
    blood_tests.each do |test|
      @legend.each { |name, data| test[name]  = send("normalise_#{name}", test[name] ) }
      test.delete_if {|k, v| k == "id" || k == "created_at" || k == "updated_at" }
    end
    @blood_tests = blood_tests
  end

  def normalise_hb(value)
    ((value * 8.9) - 72.35).to_i
  end

  def normalise_mcv(value)
    ((value * 2) - 150).to_i
  end

  def normalise_wbc(value)
    ((value * 5.7) + 7.2).to_i
  end

  def normalise_platelets(value)
    ((value * 0.13) + 11.8).to_i
  end

  def normalise_neutrophils(value)
    ((value * 8) + 10).to_i
  end

  def normalise_lymphocytes(value)
    ((value * 10.5) + 19.5).to_i
  end

  def normalise_alt(value)
    ((value * 1.3) + 17).to_i
  end

  def normalise_alk_phos(value)
    ((value * 0.388) + 12.928).to_i if value
  end

  def normalise_creatinine(value)
    ((value * 0.833) - 10).to_i
  end

  def normalise_esr(value)
    ((value * 1.538) + 30).to_i
  end

  def normalise_crp(value)
    ((value.to_i * 8) + 30).to_i
  end
end
