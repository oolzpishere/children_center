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
      expect(page).to have_text("您的作品尚在评审中，请等待结果公布。")
    end

    it "returns correct text" do
      visit "/matches/2"

      expect(page).to have_text("序号: 123")
      expect(page).to have_text("姓名: 张三")
      expect(page).to have_text("学校全称: 这是一行文字")
      expect(page).to have_text("特等奖")
      expect(page).to have_text("恭喜张三同学，你的第二十四届全国中小学生绘画书法作品比赛参赛作品获得复评一等奖！你的获奖作品已被选送全国组委会参加终评，冲击全国一等奖，自愿参加终评请点击下方链接。")
    end

    it "returns correct text" do
      visit "/matches/3"
      expect(page).to have_text("恭喜张三同学，你的第二十四届全国中小学生绘画书法作品比赛参赛作品获得复评一等奖！你的获奖作品已被选送全国组委会参加终评，冲击全国一等奖，自愿参加终评请点击下方链接。")
    end

    it "returns correct text" do
      visit "/matches/4"
      expect(page).to have_text("恭喜张三同学，你的第二十四届全国中小学生绘画书法作品比赛参赛作品获得复评二等奖！你的获奖作品已被选送全国组委会参加终评，冲击全国二等奖，自愿参加终评请点击下方链接。")
    end

    it "returns correct text" do
      visit "/matches/5"
      expect(page).to have_text("恭喜张三同学，你的第二十四届全国中小学生绘画书法作品比赛参赛作品获得复评三等奖！你的获奖作品已被选送全国组委会参加终评，冲击全国三等奖，自愿参加终评请点击下方链接。")
    end

    it "returns correct text" do
      visit "/matches/6"
      expect(page).to have_text("恭喜张三同学，你的参赛作品获得复评优胜！")
    end

  end

end
