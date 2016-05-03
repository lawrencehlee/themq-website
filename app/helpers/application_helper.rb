module ApplicationHelper
	def markdown(text)
		md = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
				no_intra_emhpasis: false,
				disable_indented_code_blocks: false,
				fenced_code_blocks: true)
		md.render(text).html_safe
	end


end
