namespace :reassign do
  desc "associate all existing records with a single store"
  task go: :environment do
    count = 0
    Item.all.each do |item|
      count += 1
			puts "Reassigning... #{count}"
			item.store_id = 1  
			item.save
    end
    puts "Done!"
  end
end
