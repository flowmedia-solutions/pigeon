Given /^Pigeon is configured to return the void_url "(.*?)"$/ do |url|
  Pigeon.should_receive(:void_url).and_return(url)
end

When /^we call void_request with the hash below, it should pass$/ do |green|
  Pigeon::Gateway.void_request eval(green)
end

When /^we call void_request with the hash:$/ do |green|
  @response = Pigeon::Gateway.void_request eval(green)
end