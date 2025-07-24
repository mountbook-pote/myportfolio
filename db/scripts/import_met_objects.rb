require 'httparty'

# MetObjectテーブルを初期化する
MetObject.delete_all

# メトロポリタン美術館APIのDepartment(ジャンル)に割り当てられたIDとその名称
MET_DEPARTMENT_IDS = {
  11 => "European Paintings",
  17 => "Medieval Art",
  10 => "Egyptian Art"
}
# 各Departmentで取得される作品数
LIMIT = 1000

MET_DEPARTMENT_IDS.each do |department_id, department_name|
  puts "=== Fetching #{department_name} ==="
  url = "https://collectionapi.metmuseum.org/public/collection/v1/search"
  query = {
    departmentId: department_id,
    hasImages: true,
    q: "*"
  }

  response = HTTParty.get(url, query: query)
  
  # エラーハンドリングの処理
  if response.success?
    object_ids = response.parsed_response["objectIDs"] || []
  else
    puts "Failed to fetch data for #{department_name} (status: #{response.code})"
    next
  end

  puts "Found #{object_ids.size} images for #{department_name}"

  selected_ids = object_ids.sample(LIMIT)
  selected_ids.each_with_index do |id, i|
    print "\rSaving #{i + 1}/#{LIMIT}"
    MetObject.find_or_create_by(object_id: id) do |obj|
      obj.department = department_name
    end
  end

  puts "\n🎉 Done: #{department_name}"
end
