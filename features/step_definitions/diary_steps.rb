Then(/^I should be able to see the latest entry$/) do
  expect(page).to have_content('01 Feb 2014')
end

Then(/^I should see the results that I should be aware of$/) do
  expect(page).to have_content('platelets')
end