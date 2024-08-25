namespace :import do
  desc "Import prefectures from CSV"
  task prefectures: :environment do
    require 'csv'

    csv_file_path = Rails.root.join('db', 'migrate', 'prefectures.csv')
    CSV.foreach(csv_file_path, headers: true) do |row|
      Prefecture.create!(
        name: row['name'],
        population: row['population']
      )
    end

    puts "Prefectures imported successfully."
  end
end