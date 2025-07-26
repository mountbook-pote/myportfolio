require 'httparty'

# メトロポリタン美術館APIの各ジャンル(department)に割り当てられたIDとその名称
MET_DEPARTMENT_IDS = {
  10 => "Egyptian Art",
  11 => "European Paintings",
  17 => "Medieval Art",
}
# 各ジャンルで１度の処理でAPI取得される作品数(これ以上は暫くの間取得できなくなる)
LIMIT = 30

# 各ジャンルでLIMIT数だけ作品を取得する
MET_DEPARTMENT_IDS.each do |department_id, department_name|

  # 指定ジャンルの全作品のIDのみを取得（IDのみはまとめてAPI取得可能）
  puts "=== Fetching #{department_name} ==="
  url = "https://collectionapi.metmuseum.org/public/collection/v1/search"
  query = {
    departmentId: department_id,
    hasImages: true,
    q: "*"
  }
  response = HTTParty.get(url, query: query)
  
  if response.success?
    object_ids = response.parsed_response["objectIDs"] || []
  else
    puts "Failed to fetch data for #{department_name} (status: #{response.code})"
    next
  end

  puts "Found #{object_ids.size} images for #{department_name}"

  # 指定したジャンルの全作品のIDから、LIMITで指定した分のIDをランダムに取得
  selected_ids = object_ids.sample(LIMIT)

  # 指定した分のIDから、そのIDに該当する作品の詳細情報を１つずつ取得(詳細情報はまとめて取れない)
  selected_ids.each_with_index do |selected_id, i|
    detail_url = "https://collectionapi.metmuseum.org/public/collection/v1/objects/#{selected_id}"
    object_details_response = HTTParty.get(detail_url)
    object_detail = object_details_response.parsed_response
    next if object_detail["department"] != department_name # 万が一指定したジャンルと作品のジャンルが異なれば飛ばす
    next if object_detail["primaryImageSmall"].blank? # 画像URLがなければ飛ばす
    
    # 作品の詳細情報のうち必要なものをDBに保存
    MetObject.find_or_create_by(object_id: object_detail["objectID"]) do |obj|
      obj.department = object_detail["department"]
      obj.title = object_detail["title"]
      obj.artist_display_name = object_detail["artistDisplayName"]
      obj.object_date = object_detail["objectDate"]
      obj.primary_image_small = object_detail["primaryImageSmall"]
      obj.object_url = object_detail["objectURL"]
    end

    # DBに保存した文をカウント
    print "\rSaving #{i + 1}/#{LIMIT}"
  end

  # DB保存作業終了のメッセージと、現在DBに保存されているそのジャンルの作品数
  puts "\n🎉 Done: #{department_name}"
  puts "Number of #{department_name} is #{MetObject.where(department: department_name).count} now"

  # 次の処理に入る前に待つ時間(一度にアクセスが増えると取得できなくなるため)
  sleep 50
end
