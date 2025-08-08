module HomesHelper
  APP_TITLE = "SideGallery".freeze

  LEFT_COLUMN_IMAGES = [
    { image: "top/subimage1.jpg", title: "Bellona" },
    { image: "top/subimage2.jpg", title: "Two-Handled Jar with Stag" },
  ].freeze

  RIGHT_COLUMN_IMAGES = [
    { image: "top/subimage3.jpg", title: "Cat Amulet" },
    { image: "top/subimage4.jpg", title: "Pope Clement X" },
  ].freeze

  DEPARTMENTS_INFORMATION = [
    { department_id: 0, name: "全てのジャンル" },
    { department_id: 1, name: "ヨーロッパ絵画" },
    { department_id: 2, name: "中世美術" },
    { department_id: 3, name: "古代エジプト美術" },
  ].freeze
end
