Dir[File.join(File.dirname(__FILE__), "..", "tollerdata", "tollerdata", "*")].each do |fn|
  data = MultiJson.load File.read(fn)
  puts [data["id"], (data["call_name"] || data["name"])].join(" ")
  Animal.new(data).tap {|a| a.id = data["id"]}.save!
end
