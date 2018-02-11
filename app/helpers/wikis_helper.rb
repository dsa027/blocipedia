module WikisHelper
  def private_ok?
    current_user && (current_user.premium? || current_user.admin?)
  end
  def authorize_wiki(wiki)
    !wiki.private || (wiki.private && private_ok?)
  end
  def is_admin?
    current_user.admin?
  end
  def is_premium?
    current_user.premium?
  end
  def is_owner?(wiki)
    current_user.id == wiki.user_id
  end
end
