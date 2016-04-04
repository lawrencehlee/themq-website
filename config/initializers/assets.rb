# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
#
%w( application articles ed_pcps tags main static_pages top_tens ).each do |controller|
	  Rails.application.config.assets.precompile +=
			["#{controller}.coffee", "#{controller}.js",
			"#{controller}.scss", "#{controller}.css"]
end

Rails.application.config.assets.precompile += %w( .woff .ttf )
