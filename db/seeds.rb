require 'active_record/fixtures'
# All environments
all_seeds = Dir["db/seeds/*.csv"].map { |file| File.basename(file, '.csv').to_sym }
Fixtures.create_fixtures('db/seeds', all_seeds)

#The current environment
environment_specific_seeds = Dir["db/seeds/#{Rails.env}/*.csv"].map { |file| File.basename(file, '.csv').to_sym }
Fixtures.create_fixtures("db/seeds/#{Rails.env}", environment_specific_seeds)
