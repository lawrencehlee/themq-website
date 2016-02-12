module ApplicationHelper
	def markdown(text)
		md = Redcarpet::Markdown.new(renderer,
			extensions = {
				no_intra_emhpasis: false,
				disable_indented_code_blocks: false,
				fenced_code_blocks: true,
			})
		return md.render(text).html_safe
	end
end
