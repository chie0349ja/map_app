module SpotsHelper
  def marker_content(spot)
    html = ""
    html << <<-HTML
    <div class="spot-category #{'background-category1' if spot.category.name == '農園'} #{'background-category2' if spot.category.name == '産直店'} #{'background-category3' if spot.category.name == '園芸店'} #{'background-category4' if spot.category.name == 'レストラン'}">
      #{spot.category.name}
    </div>
    HTML
    html << "#{link_to spot.name, spot_path(spot)}<br />"
    if spot.photo.attached?
      html << "#{link_to(image_tag(spot.photo, width: '100%'), spot_path(spot))}<br />"
    end
    return html.html_safe
  end
end