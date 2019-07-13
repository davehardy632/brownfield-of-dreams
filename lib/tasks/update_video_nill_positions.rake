namespace :db do
  desc "Update Videos with nill position to 0"
  task update_positions: :environment do
    Video.update_positions
  end
end
