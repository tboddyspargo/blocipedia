module ApplicationHelper
  
  def allowed_to_edit_wiki(wiki)
    signed_in? && (!wiki.private || wiki.user == current_user)
  end
  
  def flash_class(type)
    case(type.to_s)
    when 'alert','danger','error'
      return 'alert-danger'
    when 'warning'
      return 'alert-warning'
    else
      return 'alert-secondary'
    end
  end
  
  def markdown(text)
    @@markdown.render(text).html_safe
  end
  
  private
  options = {
    filter_html: true,
    hard_wrap: true,
    no_styles: true,
    link_attributes: { rel: 'nofollow', target: "_blank" },
    prettify: true
  }

  extensions = {
    autolink: true,
    highlight: true,
    tables: true,
    fenced_code_blocks: true,
    strikethrough: true,
    underline: true,
    quote: true,
    space_after_headers: true,
    superscript: true,
    disable_indented_code_blocks: true
  }

  @@renderer = Redcarpet::Render::HTML.new(options)
  @@markdown ||= Redcarpet::Markdown.new(@@renderer, extensions)
end
