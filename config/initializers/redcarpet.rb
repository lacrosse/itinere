REDCARPET = Redcarpet::Render::HTML.new(
  hard_wrap: true,
  escape_html: true,
  filter_html: true, no_images: true, no_styles: true
)

render_without_paragraph = Class.new(Redcarpet::Render::HTML) do
  def paragraph(text)
    text
  end
end

REDCARPET_LINE = render_without_paragraph.new(
  hard_wrap: true,
  escape_html: true,
  filter_html: true, no_images: true, no_styles: true
)
