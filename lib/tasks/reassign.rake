namespace :reassign do
  desc "associate all existing records with a single store"
  task go: :environment do

   

    store = Store.first || Store.create!(name: "Dawn Treader", user: User.first)

    count = 0
    Item.all.each do |item|
      count += 1
      puts "Reassigning... #{count}"

     
      item.store = (store) 
      item.save
    end
    puts "Done!"
  end
end
