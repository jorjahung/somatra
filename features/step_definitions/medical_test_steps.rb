Given(/^I am on the blood test entry page$/) do
  visit new_blood_test_path
end

Given(/^I am on the edit results page$/) do
  visit edit_blood_test_path
end

Given(/^there is a test result already$/) do
  enter_blood('01 Jan 2014')
end

Given(/^I am on the legend page$/) do
  visit blood_tests_legend_path
end

When(/^I enter the results$/) do
  expect(BloodTestsController).to receive(:post).with( "/remote", {:body=>{"utf8"=>"✓", "blood_test"=>{"taken_on"=>"01/01/2014", "hb"=>"13", "mcv"=>"88", "wbc"=>"7.0", "platelets"=>"278", "neutrophils"=>"4.4", "lymphocytes"=>"2.2", "alt"=>"103", "alk_phos"=>"67", "creatinine"=>"50", "esr"=>"9", "crp"=>"<5"}, "commit"=>"submit", "controller"=>"blood_tests", "action"=>"create"}}).and_return({'id' =>  1})
  # stub_request(:get, "http://localhost:3000/blood-tests/legend").
#         to_return(:status => 200, :body => '{"hb":{"name":"Hb","fullname":"Haemoglobin","unit":"g/L","min":11.5,"max":16},"mcv":{"name":"MCV","fullname":"Mean Cell Volume","unit":"fL","min":80,"max":100},"wbc":{"name":"WBC","fullname":"White Blood Cells","unit":"x10\u003Csup\u003E9\u003C/sup\u003E/L","min":4,"max":11},"platelets":{"name":"Platelets","fullname":"Platelets","unit":"x10\u003Csup\u003E9\u003C/sup\u003E/L","min":140,"max":440},"neutrophils":{"name":"Neutrophils","fullname":"Neutrophils","unit":"x10\u003Csup\u003E9\u003C/sup\u003E/L","min":2.5,"max":7.5},"lymphocytes":{"name":"Lymphocytes","fullname":"Lymphocytes","unit":"x10\u003Csup\u003E9\u003C/sup\u003E/L","min":1.0,"max":4.8},"alt":{"name":"ALT","fullname":"Alanine Aminotransferase","unit":"µkat/L","min":10,"max":40},"alk_phos":{"name":"Alk Phos","fullname":"Alkaline Phosphates","unit":"U/L","min":44,"max":147},"creatinine":{"name":"Creatinine","fullname":"Creatinine","unit":"μmol/L","min":50,"max":98},"esr":{"name":"ESR","fullname":"Erythrocyte Sedimentation Rate","unit":"mm/hr","min":0,"max":26},"crp":{"name":"CRP","fullname":"C Reactive Protein","unit":"mg/L","min":0,"max":5}}
# ', :headers => {})
expect(BloodTestsController).to receive(:get).with( "/legend").and_return({"hb" => {"name" => "Hb","fullname" => "Haemoglobin","unit" => "g/L","min" => 11.5,"max" => 16},"mcv" => {"name" => "MCV","fullname" => "Mean Cell Volume","unit" => "fL","min" => 80,"max" => 100},"wbc" => {"name" => "WBC","fullname" => "White Blood Cells","unit" => "x10\u003Csup\u003E9\u003C/sup\u003E/L","min" => 4,"max" => 11},"platelets" => {"name" => "Platelets","fullname" => "Platelets","unit" => "x10\u003Csup\u003E9\u003C/sup\u003E/L","min" => 140,"max" => 440},"neutrophils" => {"name" => "Neutrophils","fullname" => "Neutrophils","unit" => "x10\u003Csup\u003E9\u003C/sup\u003E/L","min" => 2.5,"max" => 7.5},"lymphocytes" => {"name" => "Lymphocytes","fullname" => "Lymphocytes","unit" => "x10\u003Csup\u003E9\u003C/sup\u003E/L","min" => 1.0,"max" => 4.8},"alt" => {"name" => "ALT","fullname" => "Alanine Aminotransferase","unit" => "µkat/L","min" => 10,"max" => 40},"alk_phos" => {"name" => "Alk Phos","fullname" => "Alkaline Phosphates","unit" => "U/L","min" => 44,"max" => 147},"creatinine" => {"name" => "Creatinine","fullname" => "Creatinine","unit" => "μmol/L","min" => 50,"max" => 98},"esr" => {"name" => "ESR","fullname" => "Erythrocyte Sedimentation Rate","unit" => "mm/hr","min" => 0,"max" => 26},"crp" => {"name" => "CRP","fullname" => "C Reactive Protein","unit" => "mg/L","min" => 0,"max" => 5}})
expect(BloodTestsController).to receive(:get).with( "/1.json").and_return({"taken_on"=>"01/01/2014", 
  "hb" => 13, 
  "mcv" => 88, 
  "wbc" => 7.0, 
  "platelets" => 278, 
  "neutrophils" => 4.4, 
  "lymphocytes" => 2.2, 
  "alt" => 103, 
  "alk_phos" => 67, 
  "creatinine" => 50, 
  "esr" => 9, 
  "crp" => "<5"})
  visit new_blood_test_path
  fill_in 'blood_test[taken_on]', with: '01/01/2014'
  fill_in 'blood_test[hb]', with: '13'            # In range
  fill_in 'blood_test[mcv]', with: '88'           # In range
  fill_in 'blood_test[wbc]', with: '7.0'          # In range
  fill_in 'blood_test[platelets]', with: '278'    # In range
  fill_in 'blood_test[neutrophils]', with: '4.4'  # In range
  fill_in 'blood_test[lymphocytes]', with: '2.2'  # In range
  fill_in 'blood_test[alt]', with: '103'          # Out of range
  fill_in 'blood_test[alk_phos]', with: '67'      # In range
  fill_in 'blood_test[creatinine]', with: '50'    # In range
  fill_in 'blood_test[esr]', with: '9'            # In range
  fill_in 'blood_test[crp]', with: '<5'           # In range
  click_button 'submit'
end

When(/^I (?:enter|have entered) a set of results(?:| that includes an empty value)$/) do
  expect(BloodTestsController).to receive(:post).with( "/remote", {:body=>{"utf8"=>"✓", "blood_test"=>{"taken_on"=>"01/01/2014", "hb"=>"13", "mcv"=>"88", "wbc"=>"7.0", "platelets"=>"278", "neutrophils"=>"4.4", "lymphocytes"=>"2.2", "alt"=>"", "alk_phos"=>"67", "creatinine"=>"50", "esr"=>"9", "crp"=>"<5"}, "commit"=>"submit", "controller"=>"blood_tests", "action"=>"create"}}).and_return({'id' =>  1})
  expect(BloodTestsController).to receive(:get).with( "/legend").and_return({"hb" => {"name" => "Hb","fullname" => "Haemoglobin","unit" => "g/L","min" => 11.5,"max" => 16},"mcv" => {"name" => "MCV","fullname" => "Mean Cell Volume","unit" => "fL","min" => 80,"max" => 100},"wbc" => {"name" => "WBC","fullname" => "White Blood Cells","unit" => "x10\u003Csup\u003E9\u003C/sup\u003E/L","min" => 4,"max" => 11},"platelets" => {"name" => "Platelets","fullname" => "Platelets","unit" => "x10\u003Csup\u003E9\u003C/sup\u003E/L","min" => 140,"max" => 440},"neutrophils" => {"name" => "Neutrophils","fullname" => "Neutrophils","unit" => "x10\u003Csup\u003E9\u003C/sup\u003E/L","min" => 2.5,"max" => 7.5},"lymphocytes" => {"name" => "Lymphocytes","fullname" => "Lymphocytes","unit" => "x10\u003Csup\u003E9\u003C/sup\u003E/L","min" => 1.0,"max" => 4.8},"alt" => {"name" => "ALT","fullname" => "Alanine Aminotransferase","unit" => "µkat/L","min" => 10,"max" => 40},"alk_phos" => {"name" => "Alk Phos","fullname" => "Alkaline Phosphates","unit" => "U/L","min" => 44,"max" => 147},"creatinine" => {"name" => "Creatinine","fullname" => "Creatinine","unit" => "μmol/L","min" => 50,"max" => 98},"esr" => {"name" => "ESR","fullname" => "Erythrocyte Sedimentation Rate","unit" => "mm/hr","min" => 0,"max" => 26},"crp" => {"name" => "CRP","fullname" => "C Reactive Protein","unit" => "mg/L","min" => 0,"max" => 5}})
  expect(BloodTestsController).to receive(:get).with( "/1.json").and_return({"taken_on"=>"01/01/2014", 
    "hb" => 13, 
    "mcv" => 88, 
    "wbc" => 7.0, 
    "platelets" => 278, 
    "neutrophils" => 4.4, 
    "lymphocytes" => 2.2, 
    "alt" => "", 
    "alk_phos" => 67, 
    "creatinine" => 50, 
    "esr" => 9, 
    "crp" => "<5"})
  visit new_blood_test_path
  fill_in 'blood_test[taken_on]', with: '01/01/2014'
  fill_in 'blood_test[hb]', with: '13'
  fill_in 'blood_test[mcv]', with: '88'
  fill_in 'blood_test[wbc]', with: '7.0'
  fill_in 'blood_test[platelets]', with: '278'
  fill_in 'blood_test[neutrophils]', with: '4.4'
  fill_in 'blood_test[lymphocytes]', with: '2.2'
  fill_in 'blood_test[alt]', with: ''
  fill_in 'blood_test[alk_phos]', with: '67'
  fill_in 'blood_test[creatinine]', with: '50'
  fill_in 'blood_test[esr]', with: '9'
  fill_in 'blood_test[crp]', with: '<5'
  click_button 'submit'
end

When(/^I add a new blood test$/) do
  enter_blood('01/01/2013')
end

When(/^fill up the edit form$/) do
  fill_in 'blood_test[hb]', with: '20'
  fill_in 'blood_test[esr]', with: '19'
  fill_in 'blood_test[alk_phos]', with: '67'
  click_button 'submit'
end

When(/^I click "(.*?)"$/) do |link|
  click_link link
end

When(/^I click on the date for a blood test$/) do
  click_link "01 Jan 2014"
end

Then(/^I should be able to see the json data$/) do
  expect(page).to have_content('{"hb":{"name":"Hb","fullname":"Haemoglobin","unit":"g/L","min":16,"max":11.5},"mcv":{"name":"MCV","fullname":"Mean Cell Volume","unit":"fL","min":100,"max":80},"wbc":{"name":"WBC","fullname":"White Blood Cells","unit":"x10\u003Csup\u003E9\u003C/sup\u003E/L","min":11,"max":4},"platelets":{"name":"Platelets","fullname":"Platelets","unit":"x10\u003Csup\u003E9\u003C/sup\u003E/L","min":440,"max":140},"neutrophils":{"name":"Neutrophils","fullname":"Neutrophils","unit":"x10\u003Csup\u003E9\u003C/sup\u003E/L","min":7.5,"max":2.5},"lymphocytes":{"name":"Lymphocytes","fullname":"Lymphocytes","unit":"x10\u003Csup\u003E9\u003C/sup\u003E/L","min":4.8,"max":1.0},"alt":{"name":"ALT","fullname":"Alanine Aminotransferase","unit":"µkat/L","min":40,"max":10},"alk_phos":{"name":"Alk Phos","fullname":"Alkaline Phosphates","unit":"U/L","min":147,"max":44},"creatinine":{"name":"Creatinine","fullname":"Creatinine","unit":"μmol/L","min":98,"max":50},"esr":{"name":"ESR","fullname":"Erythrocyte Sedimentation Rate","unit":"mm/hr","min":26,"max":0},"crp":{"name":"CRP","fullname":"C Reactive Protein","unit":"mg/L","min":5,"max":0}}')
end

Then(/^I want to be able to see those results$/) do
  visit blood_tests_path
  ['Taken on', '01 Jan 2014', 'Hb', '13', 'MCV', '88', 'WBC', '7.0', 'Platelets', '278', 'Neutrophils', '4.4', 'Lymphocytes', '2.2', 'ALT', '103', 'Alk Phos', '67', 'Creatinine', '50', 'ESR', '9', 'CRP', '<5'].each do |string|
    expect(page).to have_content(string)
  end
end

Then(/^I want to see which tests are out of range$/) do
  expect(page).to have_css('.danger', text: '103')
end

Then(/^I want to see which tests are within range$/) do
  expect(page).to have_css('.no-danger', text: '13')
end

Given(/^I have submitted more than one set of results$/) do
  enter_blood('01/01/2013')
  enter_blood('01/01/2012')
  enter_blood('01/01/2014')
end

When(/^I am on the blood test results page$/) do 
  visit blood_tests_path
end

Then(/^I should see those results in chronological order$/) do
  first = page.all(:xpath, '//tr/td').first
  last = page.all(:xpath, '//tr').last
  expect(first).to have_content('01 Jan 2014')
  expect(last).to have_content('01 Jan 2012')
end

When(/^I enter a new result with the same date$/) do
  enter_blood('01 Jan 2014')
end
When(/^I don't enter a date$/) do
  enter_blood('')
end

When(/^I delete the given test$/) do
  click_link 'Delete'
end

Then(/^I should still be on the blood test entry page$/) do
  expect(current_path).to eq(blood_tests_path)
end

Then(/^I should be on the edit page for that blood test$/) do
  expect(current_path).to eq(edit_blood_test_path(BloodTest.find_by_hb(13).id))
end

Then(/^I should see my changes$/) do
  ['Taken on', '01 Jan 2014', 'Hb', '20', 'MCV', '88', 'WBC', '7.0', 'Platelets', '278', 'Neutrophils', '4.4', 'Lymphocytes', '2.2', 'ALT', '103', 'Alk Phos', '67', 'Creatinine', '50', 'ESR', '19', 'CRP', '<5'].each do |string|
    expect(page).to have_content(string)
  end
end

Then(/^I should still see the fields of the second result I entered$/) do
  find_field('Hb').value.should eq '13'
  find_field('MCV').value.should eq '88'
  find_field('WBC').value.should eq '7.0'
end

Then(/^I should not see that set of data on the page$/) do
  ['01 Jan 2014', '20', '88', '7.0', '278', '4.4', '2.2', '103', '67', '50', '19', '<5'].each do |string|
    expect(page).not_to have_content(string)
  end
end

Then(/^there should be blank cells in the table$/) do
  expect(page).to have_css('.empty-value', text: '')
end

Then(/^I should see "(.*?)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I should see my results grouped according to whether or not they are in range$/) do
  expect(current_path).to eq(blood_test_path(1))
  expect(page).to have_css('.danger', text: '103')
  expect(page).to have_css('.no-danger', text: '13')
end

Then(/^I should be on the report page for that blood test$/) do
  expect(current_path).to eq(blood_test_path(BloodTest.find_by_hb(13)))
end

Then(/^I should not see the empty result in the report$/) do
  expect(page).not_to have_content("alk phos")
end

def enter_blood(date)
expect(BloodTestsController).to receive(:post).with("/remote", {:body=>{"utf8"=>"✓", "blood_test"=>{"taken_on"=>date, "hb"=>"13", "mcv"=>"88", "wbc"=>"7.0", "platelets"=>"278", "neutrophils"=>"4.4", "lymphocytes"=>"2.2", "alt"=>"103", "alk_phos"=>"67", "creatinine"=>"50", "esr"=>"9", "crp"=>"<5"}, "commit"=>"submit", "controller"=>"blood_tests", "action"=>"create"}}).and_return({'id' =>  1})
expect(BloodTestsController).to receive(:get).with( "/legend").and_return({"hb" => {"name" => "Hb","fullname" => "Haemoglobin","unit" => "g/L","min" => 11.5,"max" => 16},"mcv" => {"name" => "MCV","fullname" => "Mean Cell Volume","unit" => "fL","min" => 80,"max" => 100},"wbc" => {"name" => "WBC","fullname" => "White Blood Cells","unit" => "x10\u003Csup\u003E9\u003C/sup\u003E/L","min" => 4,"max" => 11},"platelets" => {"name" => "Platelets","fullname" => "Platelets","unit" => "x10\u003Csup\u003E9\u003C/sup\u003E/L","min" => 140,"max" => 440},"neutrophils" => {"name" => "Neutrophils","fullname" => "Neutrophils","unit" => "x10\u003Csup\u003E9\u003C/sup\u003E/L","min" => 2.5,"max" => 7.5},"lymphocytes" => {"name" => "Lymphocytes","fullname" => "Lymphocytes","unit" => "x10\u003Csup\u003E9\u003C/sup\u003E/L","min" => 1.0,"max" => 4.8},"alt" => {"name" => "ALT","fullname" => "Alanine Aminotransferase","unit" => "µkat/L","min" => 10,"max" => 40},"alk_phos" => {"name" => "Alk Phos","fullname" => "Alkaline Phosphates","unit" => "U/L","min" => 44,"max" => 147},"creatinine" => {"name" => "Creatinine","fullname" => "Creatinine","unit" => "μmol/L","min" => 50,"max" => 98},"esr" => {"name" => "ESR","fullname" => "Erythrocyte Sedimentation Rate","unit" => "mm/hr","min" => 0,"max" => 26},"crp" => {"name" => "CRP","fullname" => "C Reactive Protein","unit" => "mg/L","min" => 0,"max" => 5}})
expect(BloodTestsController).to receive(:get).with( "/1.json").and_return({"taken_on"=> date, 
  "hb" => 13, 
  "mcv" => 88, 
  "wbc" => 7.0, 
  "platelets" => 278, 
  "neutrophils" => 4.4, 
  "lymphocytes" => 2.2, 
  "alt" => 103, 
  "alk_phos" => 67, 
  "creatinine" => 50, 
  "esr" => 9, 
  "crp" => "<5"})
  visit new_blood_test_path
  fill_in 'blood_test[taken_on]', with: date
  fill_in 'blood_test[hb]', with: '13'
  fill_in 'blood_test[mcv]', with: '88'
  fill_in 'blood_test[wbc]', with: '7.0'
  fill_in 'blood_test[platelets]', with: '278'
  fill_in 'blood_test[neutrophils]', with: '4.4'
  fill_in 'blood_test[lymphocytes]', with: '2.2'
  fill_in 'blood_test[alt]', with: '103'
  fill_in 'blood_test[alk_phos]', with: '67'
  fill_in 'blood_test[creatinine]', with: '50'
  fill_in 'blood_test[esr]', with: '9'
  fill_in 'blood_test[crp]', with: '<5'
  click_button 'submit'
end
