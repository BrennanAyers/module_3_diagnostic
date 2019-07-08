require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  context 'When I visit the root path' do
    it 'I can use the search form' do
      visit root_path
      # And I fill in the search form with "sweet potatoes"
      fill_in 'q', with: 'sweet potatoes'
      # And I click "Search"
      VCR.use_cassette('sweet_potato_search') do
        click_on 'Search'
      end
      # Then I should be on page "/foods"
      expect(current_path).to eq(foods_path)
      # Then I should see a total of the number of items returned by the search. (531 for sweet potatoes)
      expect(page).to have_content('531 results')
      # Then I should see a list of ten foods sorted by relevance.
      within("#search-results") do
        expect(page).to have_selector('.food-info', count: 10)
      end
    end

    it 'returns each foods information' do
      sweet_potatoes = [
            {
                "offset": 0,
                "group": "Branded Food Products Database",
                "name": "ONE POTATO TWO POTATO, PLAIN JAYNES, SWEET POTATO CHIPS, UPC: 785654000544",
                "ndbno": "45094945",
                "ds": "LI",
                "manu": "Dieffenbach's Potato Chips"
            },
            {
                "offset": 1,
                "group": "Branded Food Products Database",
                "name": "TERRA, SWEET POTATO CHIPS, PUMPKIN SPICE SWEETS, UPC: 728229014751",
                "ndbno": "45165952",
                "ds": "LI",
                "manu": "THE HAIN CELESTIAL GROUP, INC."
            },
            {
                "offset": 2,
                "group": "Branded Food Products Database",
                "name": "CHILI'S, SWEET & SPICY CHICKEN & SWEET POTATOES, BIG BOLD, UPC: 717854470377",
                "ndbno": "45109414",
                "ds": "LI",
                "manu": "Bellisio Foods Inc"
            },
            {
                "offset": 3,
                "group": "Branded Food Products Database",
                "name": "SWEET POTATO POPPED POTATO CRISPS, UPC: 075450137415",
                "ndbno": "45219208",
                "ds": "LI",
                "manu": "Hy-Vee, Inc."
            },
            {
                "offset": 4,
                "group": "Branded Food Products Database",
                "name": "SWEET POTATO KETTLE POTATO CHIPS, UPC: 762111242839",
                "ndbno": "45324838",
                "ds": "LI",
                "manu": "STARBUCKS COFFEE COMPANY"
            },
            {
                "offset": 5,
                "group": "Branded Food Products Database",
                "name": "SWEET POTATOES, RED POTATOES, CARROTS & PARSNIPS VEGETABLES FOR ROASTING, UPC: 070560970907",
                "ndbno": "45372027",
                "ds": "LI",
                "manu": "The Pictsweet Company"
            },
            {
                "offset": 6,
                "group": "Vegetables and Vegetable Products",
                "name": "Sweet potato leaves, raw",
                "ndbno": "11505",
                "ds": "SR",
                "manu": "none"
            },
            {
                "offset": 7,
                "group": "Vegetables and Vegetable Products",
                "name": "Sweet potato, raw, unprepared (Includes foods for USDA's Food Distribution Program)",
                "ndbno": "11507",
                "ds": "SR",
                "manu": "none"
            },
            {
                "offset": 8,
                "group": "Vegetables and Vegetable Products",
                "name": "Sweet potato, canned, mashed",
                "ndbno": "11514",
                "ds": "SR",
                "manu": "none"
            },
            {
                "offset": 9,
                "group": "Vegetables and Vegetable Products",
                "name": "Sweet potato, frozen, unprepared (Includes foods for USDA's Food Distribution Program)",
                "ndbno": "11516",
                "ds": "SR",
                "manu": "none"
            }
        ]
      visit root_path
      fill_in 'q', with: 'sweet potatoes'
      VCR.use_cassette('sweet_potato_search') do
        click_on 'Search'
      end

      foods = page.all('.food-info')
      foods.each_with_index do |food, index|
        within(food) do
          # - The food's NDB Number
          expect(page).to have_content("NDB Number: #{sweet_potatoes[index]['ndbno']}")
          # - The food's name
          expect(page).to have_content("Name: #{sweet_potatoes[index]['name']}")
          # - The food group to which the food belongs
          expect(page).to have_content("Food Group: #{sweet_potatoes[index]['group']}")
          # - The food's data source
          expect(page).to have_content("Data Source: #{sweet_potatoes[index]['ds']}")
          # - The food's manufacturer
          expect(page).to have_content("Manufacturer: #{sweet_potatoes[index]['manu']}")
        end
      end
    end
  end
end
