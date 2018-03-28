module ApplicationHelper
  
  def form_group_tag(errors, options={}, &block)
    css_class = "#{options[:class]} form-group"
    css_class << ' has-error' if errors.any?
    
    content_tag :div, capture(&block), class: css_class
  end
  
  def flash_class(type, value)
    case(type.to_s.downcase)
    when 'success'
      return 'alert-success'
    when 'alert','danger','error'
      return 'alert-danger'
    when 'warning'
      return 'alert-warning'
    else
      return 'alert-success' if (value.is_a?(Hash) && value[:heading] || value['heading'])
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
