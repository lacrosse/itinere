module ApplicationHelper
  def title(text)
    content_for(:title, text)
  end

  def md(text)
    if text.present?
      Redcarpet::Markdown.new(
        REDCARPET,
        autolink: true
      ).render(text).html_safe
    else
      ''
    end
  end

  def md_line(text)
    if text.present?
      Redcarpet::Markdown.new(
        REDCARPET_LINE,
        autolink: true
      ).render(text).html_safe
    else
      ''
    end
  end

  def flash_messages
    flash.select { |k, v| %w(alert notice).include?(k) && v.present? }.map do |type, message|
      klass =
        case type
        when 'notice'
          'success'
        else
          'danger'
        end

      content_tag :div, class: ['alert', "alert-#{klass}", 'alert-dismissible'], role: 'alert' do
        content_tag :button, type: 'button', class: 'close', data: { dismiss: 'alert' }, aria: { label: 'Close' } do
          content_tag :span, aria: { hidden: 'true' } do
            '&times;'.html_safe
          end
        end.concat(message)
      end
    end.join.html_safe
  end
end
