namespace :reassign do
  desc "associate all existing records with a single store"
  task store_reassignment: :environment do  

    store = Store.find_or_create_by!(name: "Dawn Treader", user: User.first)

    Item.all.each do |item|
      
      if item.store.nil?      
        puts "Reassigning... #{item.id}"
        item.store = (store) 
        item.save!
      else
        puts "Reassigning not necessary... #{item.id}"
      end
    end
    puts "Done!"
  end

  desc "associate all existing items with cloudinary images" 
  task images_to_cloudinary: :environment do
    Item.all.each do |item|
      puts "Reassigning... #{item.id}"
      
      file_path = Rails.root.join('public', 'images', item.id.to_s, 'original', item.image_file_name)
      file = File.open(file_path)
      item.image = file
      item.save!
    end
    puts "Done!"
  end
end
