module ApplicationHelper
  def full_title(page_title)
    base_title = "SideGallery"
    if page_title.blank?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end

  def ja_translated_name(en_department_name)
    I18n.t("departments.#{en_department_name}", default: en_department_name)
  end
end
