namespace :rewind do
  desc "Reload old records with new Unit Price attribute"
  task go: :environment do
    OrderItem.all.each.with_index(1) do |order_item|
      puts "Reallocating.. #{index}"

      order_item.unit_price = order_item.item.price
    end
    puts "Done!"
  end
end
