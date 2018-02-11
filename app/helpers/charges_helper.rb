module ChargesHelper
  def private_wiki_count
    private_wikis.count
  end
  def private_wikis
    Wiki.where('user_id = ? AND private = ?', current_user.id, true)
  end
  def private_to_public
    private_wikis.update_all(private: false)
  end
end
