desc "drop existing development.sqlite3 and re-setup new one with seed"
task "db:dev" => :environment do
  Rake::Task["db:drop"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:seed:development"].invoke
end
