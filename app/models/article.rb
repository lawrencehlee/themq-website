class Article < ActiveRecord::Base
  def get_article_text
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', self.text)
    File.read(filepath).encode("UTF-8", :invalid=>:replace)
  end

	def get_article_text_teaser
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', self.text)
		n = 1;
		open(filepath) do |f|
			lines = []
			n.times do
				line = f.gets || break
				lines << line
			end
			first_line = lines.first
			first_line.split(' ')[0, 25].join(' ') + "...";

		end
	end
end
