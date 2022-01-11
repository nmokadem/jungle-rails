require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products then click on product image to go to product details" do
    visit root_path

    #find('_linkdetails', match: :first).click
    # find_link("Details", match: :first).hover
    click_link("Details", match: :first)
    # commented out b/c it's for debugging only
    #save_screenshot
    #save_and_open_screenshot

    expect(page).to have_css '.main-img', count: 1
   save_screenshot
  end
end
