Given(/^I am on the main game page$/) do
  # prefix = 'file://'
  # prefix = 'file:///' if RUBY_PLATFORM.to_s.include?('mingw')
  
  # parent_dir = File.expand_path("..", Dir.pwd)
  # path_to_app = prefix + parent_dir + '/starwarsquotes.html'
  page.visit "http://adrians.party/starwarsquotes.html"
end

When(/^I put my name as "([^"]*)"$/) do |name|
  fill_in('name', with: name)
end

When(/^I give the right answers$/) do
  select('Luke Skywalker', from: 'character')
  select('Nooooooo!', from: 'quote')
end

Then(/^I should see a message "([^"]*)"$/) do |the_right_message|
  click_button('Am I a true fan?')
  expect(page).to have_text the_right_message
end
