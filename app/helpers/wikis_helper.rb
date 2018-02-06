module WikisHelper
  def user_is_authorized_for_wikis_crud?
    current_user
  end
  def user_is_authorized_for_wikis_edit?
    current_user
  end
  def user_is_signed_in_and_admin?
    current_user
  end
end
