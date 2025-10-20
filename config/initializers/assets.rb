# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('vendor/stylesheets')
Rails.application.config.assets.precompile += %w[appstack/dark.css appstack/light.css]
Rails.application.config.assets.precompile << /.(?:svg|eot|woff|ttf)$/
