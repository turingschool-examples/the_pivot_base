namespace :roles do
  desc "Migrates existing role column into an active record association."
  task go: :environment do
    User.all.each_with_index do |user, index|
      puts "Reassigning... #{index}"
      if user.role == "default"
        user.user_roles.create(role_id: 1)
      elsif user.role == "admin"
        user.user_roles.create(role_id: 2)
      end
    end
    puts "Done!"
  end
end