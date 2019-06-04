module LocationsHelper
  def subscribe_button(location)
    if location.belongs_to_user?(current_user)
      link_to t('locations.index.unfollow'),
              unfollow_locations_path(location.id),
              method: :delete
    else
      link_to t('locations.index.follow'),
              follow_locations_path(location.id)
    end
  end
end
