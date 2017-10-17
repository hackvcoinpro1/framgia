module UsersHelper
  def show_avatar_for user
    image_tag(user.avatar.url, class: "img-circle img-responsive", size: Settings.user.avatar.size_default)
  end

  def displayed_column_for_suppervisor
    User.column_names -
      %w(id created_at updated_at password_digest avatar reset_digest
         reset_send_at remember_digest gender) +
      %w(action)
  end

  def displayed_column_for_user
    User.column_names -
      %w(id created_at suppervisor date_start updated_at password_digest avatar
         reset_digest reset_send_at remember_digest gender) +
      %w(action)
  end

  def total_member trainers, trainees
    trainers.size + trainees.size
  end
end
