module WikisHelper
  def private_ok?(wiki)
    current_user && (current_user.premium? || current_user.admin? || wiki.collaborators.find { |wc| wc.user_id == current_user.id })
  end
  def authorize_wiki(wiki)
    !wiki.private || (wiki.private && private_ok?(wiki))
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
