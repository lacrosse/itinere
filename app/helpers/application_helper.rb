module ApplicationHelper
  def md(text)
    Redcarpet::Markdown.new(
      REDCARPET,
      autolink: true
    ).render(text || '').html_safe
  end

  def md_line(text)
    Redcarpet::Markdown.new(
      REDCARPET_LINE,
      autolink: true
    ).render(text || '').html_safe
  end

  def flash_messages
    flash.select { |k, v| %w(alert notice).include?(k) && v.present? }.map do |type, message|
      container_class =
        case type
        when 'alert' then :error
        else :success
        end
      content_tag :div, class: 'clearfix' do
        content_tag(:p, message)
      end
    end.join('').html_safe
  end
end
