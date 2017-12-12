require 'rails_helper'

RSpec.describe "As a visitor can visit category show page" do
  it " can visit category show page" do
    Category.create(title: "Cats")
    visit '/cats'
  end
end