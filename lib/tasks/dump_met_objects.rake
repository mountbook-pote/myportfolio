namespace :db do
  desc "Dump MetObject data to db/met_objects_seed_data.rb"
  task dump_met_objects: :environment do
    File.open("db/met_objects_seed_data.rb", "w") do |file|
      file.puts "MetObject.create!(["
      MetObject.find_each do |obj|
        attrs = obj.attributes.except("id", "created_at", "updated_at")
        file.puts "  #{attrs.to_s},"
      end
      file.puts "])"
    end
    puts "Dumped MetObject data to db/met_objects_seed_data.rb"
  end
end
