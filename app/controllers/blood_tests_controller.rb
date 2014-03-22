class BloodTestsController < ApplicationController
  include HTTParty
  base_uri 'http://localhost:3000/blood-tests'

  def new
    @blood_test = BloodTest.new
  end

  def create
    @blood_test = BloodTest.new(blood_test_params)
    if @blood_test.save
      redirect_to blood_test_path(@blood_test)
    else
      flash.now[:errors] = @blood_test.error_messages
      render action: 'new'
    end
  end

  def show
    @blood_test = BloodTest.find(params[:id])
    @probe = BloodProbe.new(@blood_test)
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
    @blood_tests = self.class.get('.json')
  end

  def results
    render json: BloodTest.as_json(params[:name])
  end

  def legend
    render json: BloodTest.legend_as_json
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
    @legend = self.class.get("/legend")
    set_headers
    set_units
    set_methods
    set_ranges
  end
end
