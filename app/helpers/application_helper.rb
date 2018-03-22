module ApplicationHelper
  
  
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
