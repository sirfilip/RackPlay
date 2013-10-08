%w[base exceptions].each do |filename|
  require File.expand_path("../my_way/#{filename}", __FILE__)
end
