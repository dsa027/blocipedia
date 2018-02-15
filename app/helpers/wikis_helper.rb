module WikisHelper
  def admin_or_mine?(wiki)
    current_user.admin? || (current_user.premium? && wiki.user_id == current_user.id)
  end
  def is_collaborator?(wiki)
    wiki.collaborators.find { |wc| wc.user_id == current_user.id }
  end
  def authorize_wiki(wiki)
    !wiki.private || (wiki.private && admin_or_mine?(wiki)) || (wiki.private && is_collaborator?(wiki))
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
  def get_selected(u_id, w_id)
    Collaborator.where(user_id: u_id, wiki_id: w_id).empty? ? "" : "selected='selected'"
  end
  def priv_to_pub(wiki)
    if !wiki.private
      wiki.collaborators.destroy_all
    end
  end

  def markdown(text)
    options = {
      # filter_html:     true,
      # hard_wrap:       true,
      # lax_spacing:     true,
      # link_attributes: { rel: 'nofollow', target: "_blank" },
      # space_after_headers: true,
      # fenced_code_blocks: true
    }

    extensions = {
      # tables:             true,
      # autolink:           true,
      # superscript:        true,
      # disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
