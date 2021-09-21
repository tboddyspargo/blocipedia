# frozen_string_literal: true

module ApplicationHelper
  def user_name(user)
    name = user.try(:first_name) ? user.full_name : user.try(:email)
    name || 'Unknown'
  end

  def error_group_tag(errors, options = {}, &block)
    css_class = (options[:class]).to_s
    css_class << (errors.any? ? ' is-invalid' : ' is-valid')

    content_tag :div, capture(&block), class: css_class
  end

  def flash_color(type, _value)
    case type.to_s.downcase
    when 'success', 'notice'
      'success'
    when 'alert', 'danger', 'error'
      'danger'
    when 'warning'
      'warning'
    else
      'secondary'
    end
  end

  def markdown(text)
    @@markdown.render(text).html_safe
  end

  # Redcarpet markdown renderer options.
  options = {
    filter_html: true,
    hard_wrap: true,
    no_styles: true,
    link_attributes: { rel: 'nofollow', target: '_blank' },
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
