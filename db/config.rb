require "sequel"

Sequel.extension :migration

DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost:5432/decoupled_blog_sequel_dev')
