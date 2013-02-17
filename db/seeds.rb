def life_event field, data, animal
  if (event = data.delete field)
    begin
      year, month, day = event
      animal.send "create_#{field}", date:Date.new(*event), year:year, month:month, day:day, event_type:field, entity_type:animal.class.name
      # ap [field, animal, event]
    rescue Object => e
      ap [e, event]
      raise e
    end
  end
end

count = 0
Dir[File.join(File.dirname(__FILE__), "..", "tollerdata", "tollerdata", "*")].
  to_a.
  sort {|a, b| a.sub(%r{.*/([^/]+)$}, '\1').to_i <=> b.sub(%r{.*/([^/]+)$}, '\1').to_i}.
  each do |fn|

  data = MultiJson.load File.read(fn)
  puts [data["id"], (data["call_name"] || data["name"])].join(" ")
  # ap data
  (animal = Animal.new.tap do |a|
     a.id = data.delete "id"
     ["birth", "death"].each do |event|
       life_event event, data, a
     end
     a.assign_attributes data
   end).save!
  # ap animal
  # ap animal.birth

  exit if (count -= 1) == 0
end
