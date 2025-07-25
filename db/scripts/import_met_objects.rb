require 'httparty'

# メトロポリタン美術館APIのDepartment(ジャンル)に割り当てられたIDとその名称
MET_DEPARTMENT_IDS = {
  10 => "Egyptian Art",
  11 => "European Paintings",
  17 => "Medieval Art",
}
# 各Departmentで取得される作品数
LIMIT = 30

MET_DEPARTMENT_IDS.each do |department_id, department_name|
  puts "=== Fetching #{department_name} ==="
  url = "https://collectionapi.metmuseum.org/public/collection/v1/search"
  query = {
    departmentId: department_id,
    hasImages: true,
    q: "*"
  }

  response = HTTParty.get(url, query: query)
  
  # 指定ジャンルの全object_idsの取得とエラーハンドリングの処理
  if response.success?
    object_ids = response.parsed_response["objectIDs"] || []
  else
    puts "Failed to fetch data for #{department_name} (status: #{response.code})"
    next
  end

  puts "Found #{object_ids.size} images for #{department_name}"

  # 指定ジャンルの全object_idsから、LIMITで指定した数分をランダムに取得
  selected_ids = object_ids.sample(LIMIT)

  # selected_idsだけで各作品の詳細情報を取得
  selected_ids.each_with_index do |selected_id, i|
    detail_url = "https://collectionapi.metmuseum.org/public/collection/v1/objects/#{selected_id}"
    object_details_response = HTTParty.get(detail_url)
    object_detail = object_details_response.parsed_response

    print "\rSaving #{i + 1}/#{LIMIT}"

    # 作品の詳細情報をそのまま保存
    MetObject.find_or_create_by(object_id: object_detail["objectID"]) do |obj|
      obj.department = department_name
      obj.title = object_detail["title"]
      obj.artist_display_name = object_detail["artistDisplayName"]
      obj.object_date = object_detail["objectDate"]
      obj.primary_image_small = object_detail["primaryImageSmall"]
      obj.object_url = object_detail["objectURL"]
    end
  end

  puts "\n🎉 Done: #{department_name}"
  puts "Number of #{department_name} is #{MetObject.where(department: department_name).count} now"
  sleep 50
end
