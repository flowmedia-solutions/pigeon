Given /^Pigeon is configured to return the threeds_url "(.*?)"$/ do |url|
  Pigeon.should_receive(:threeds_url).and_return(url)
end

When /^we call threeds_validation with the hash below, it should pass$/ do |green|
  Pigeon::Gateway.threeds_validation eval(green)
end

When /^we call threeds_validation with the hash:$/ do |green|
  @response = Pigeon::Gateway.threeds_validation eval(green)
end