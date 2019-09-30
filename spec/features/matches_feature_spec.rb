require 'rails_helper'

RSpec.feature "Matches", type: :feature do


  describe "Matches index not created match" do
    it "returns correct text" do
      visit "/matches"

      expect(page).to have_text("第二十四届全国中小学生绘画书法作品比赛")
      expect(page).to have_text("您尚未提交报名信息，请在“前沿课堂论坛”公众号进行提交。")
    end

  end

  describe "Matches index created match" do
    before(:each) do
      FactoryBot.create(:form_with_matchs)
    end

    it "returns correct text" do
      visit "/matches"

      expect(page).to have_text("第二十四届全国中小学生绘画书法作品比赛")
      expect(page).to have_text("广西赛区参赛报名结果查询")
      expect(page).to have_text("序号: 123")
      expect(page).to have_text("姓名: 张三")
      expect(page).to have_text("查看详情")
    end

  end

  describe "Matches show created match" do
    before(:each) do
      FactoryBot.create(:form_with_matchs)
    end

    it "returns correct text" do
      visit "/matches/1"

      expect(page).to have_text("序号: 123")
      expect(page).to have_text("姓名: 张三")
      expect(page).to have_text("学校全称: 这是一行文字")
    end

  end

end
