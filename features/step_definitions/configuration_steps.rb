When /^I configure Pigeon with the possibly erroneous hash:$/ do |config|
  begin
    @config_response = Pigeon.configure eval(config)
  rescue Exception => e
    @exceptions << e
  end
  p @exceptions unless @exceptions.empty?
end

Then /^no exceptions should be raised$/ do
  @exceptions.should be_empty
end

Then /^a (.*?) should be raised with the message "(.*?)"$/ do |type, message|
  @exceptions.select {|e| e.message == message && e.class.to_s == "Pigeon::#{type}" }.count.should eq 1
end

Then /^the following hash should be returned:$/ do |green|
  @config_response.should eq eval(green)
end

Then /^simulate\? should return (true|false)$/ do |ret|
  Pigeon.simulate?.should be (ret == 'true')
end

Then /^test\? should return (true|false)$/ do |ret|
  Pigeon.test?.should be (ret == 'true')
end

Then /^live\? should return (true|false)$/ do |ret|
  Pigeon.live?.should be (ret == 'true')
end

Then /^register_url should return "(.*?)"$/ do |url|
  Pigeon.register_url.should eq url
end

Then /^threeds_url should return "(.*?)"$/ do |url|
  Pigeon.threeds_url.should eq url
end

Then /^paypal_url should return "(.*?)"$/ do |url|
  Pigeon.paypal_url.should eq url
end