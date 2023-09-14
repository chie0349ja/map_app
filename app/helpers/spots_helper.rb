module SpotsHelper
  def marker_content(spot)
    html = ""
    html << "<strong>Name:</strong> #{link_to spot.name, spot_path(spot)}<br />"
    if spot.photo.attached?
      html << "<strong>Photo</strong> #{image_tag(spot.photo, width: '100%')}<br />"
    end
    return html.html_safe
  end
end
