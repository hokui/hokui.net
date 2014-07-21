desc "load sample data to development env"
task "db:seed:dev" => :environment do
  load(File.join(Rails.root, 'db', 'seeds', 'development.rb'))
end
