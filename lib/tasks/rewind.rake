namespace :rewind do
  desc "Reload old records with new Unit Price attribute"
  task go: :environment do
    count = 0
    OrderItem.all.each do |order_item|
      count += 1
      puts "Reallocating.. #{count}"

      order_item.unit_price = order_item.item.price
      order_item.save!
    end
    puts "Done!"
  end
end
