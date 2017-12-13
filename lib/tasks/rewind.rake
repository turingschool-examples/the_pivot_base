namespace :rewind do
  desc "Reload old records with new Unit Price attribute"
  task go: :environment do
    OrderItem.all.each_with_index do |order_item, index|
      puts "Reallocating.. #{index}"

      order_item.unit_price = order_item.item.price
    end
    puts "Done!"
  end
end
