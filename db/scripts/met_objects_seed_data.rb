File.open("db/met_objects_seed_data.rb", "w") do |file|
  file.puts "MetObject.create!(["
  MetObject.find_each.with_index do |obj, i|
    attrs = obj.attributes.except("id", "created_at", "updated_at")
    file.puts "  #{attrs.to_s},"
  end
  file.puts "])"
end
