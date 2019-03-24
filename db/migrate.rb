require_relative "config"
Sequel::Migrator.run(DB, "db/migrations")
