require 'rails_helper'

RSpec.feature "Matches", type: :feature do

  describe "Pages competition" do
    it "returns correct text" do
      visit "/competition"

      expect(page).to have_text("第二十四届全国中小学生")
      expect(page).to have_text("报名已截止")
      # expect(page).to have_link(href: 'https://jinshuju.net/f/0llDiH')
      expect(page).to have_link(href: '/matches')
    end

  end

end
