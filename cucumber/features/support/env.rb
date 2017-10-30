require 'capybara/cucumber'
require 'selenium/webdriver'
require 'byebug'

Capybara.register_driver :selenium do |app|
  @chromedriver_path = '/usr/bin/chromedriver'
  Selenium::WebDriver::Chrome::driver_path = @chromedriver_path
  Capybara::Selenium::Driver.new(app, :browser => :chrome, :switches => %w[--disable-popup-blocking, --disable-extensions])
end
  
# if RUBY_PLATFORM.to_s.include?('mingw') == true
#  @chromedriver_path = "#{Dir.pwd}/bin/chromedriver.exe"
# else
#  @chromedriver_path = "#{Dir.pwd}/bin/chromedriver"
# end

# puts "Chromedriver path = #{@chromedriver_path} "

# Capybara.register_driver :selenium do |app|
#   Selenium::WebDriver::Chrome.driver_path = @chromedriver_path
#  Capybara::Selenium::Driver.new(app, :browser => :chrome, :switches => %w[--disable-popup-blocking, --disable-extensions])
# end    

Capybara.default_driver = :selenium
# Capybara.current_session.driver.browser.manage.window.maximize
