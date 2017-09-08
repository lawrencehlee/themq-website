require 'net/http'

module ApplicationHelper
  def markdown(text)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        no_intra_emhpasis: false,
        disable_indented_code_blocks: false,
        fenced_code_blocks: true)

    md.render(text).html_safe
  end

  def get(location)
    uri = URI(location)
    response = Net::HTTP.get(uri)
    response.force_encoding('UTF-8')
  end
end
