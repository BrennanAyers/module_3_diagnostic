require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  context 'When I visit the root path' do
    it 'I can use the search form' do
      visit root_path
      # And I fill in the search form with "sweet potatoes"
      fill_in 'q', with: 'sweet potatoes'
      # And I click "Search"
      click_on 'Search'
      # Then I should be on page "/foods"
      expect(current_path).to eq(foods_path)
      # Then I should see a total of the number of items returned by the search. (531 for sweet potatoes)
      expect(page).to have_content('531 results')
      # Then I should see a list of ten foods sorted by relevance.
      within("#search-results") do
        expect(page).to have_selector(".food-info", count: 10)
      end
    end
  end
end
