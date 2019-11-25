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
      expect(page).to have_text("全国终评入围及预估获奖结果查询")
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
      expect(page).to have_text("很遗憾您的作品未入围“第二十四届全国中小学生绘画书法作品比赛”全国赛终评，感谢您的参与，愿您下届比赛能取得优异成绩！")
    end

    it "not showing text" do
      visit "/matches/1"
      expect(page).to_not have_text("确认参赛")
    end

    it "not showing text" do
      visit "/matches/1"
      expect(page).to_not have_text("评奖")
    end

    it "returns correct text" do
      visit "/matches/2"

      expect(page).to have_text("序号: 123")
      expect(page).to have_text("姓名: 张三")
      expect(page).to have_text("学校全称: 这是一行文字")
      expect(page).to have_text("张三同学，您的作品已获本届“全国中小学生绘画书法作品比赛”争夺全国赛一等奖或二等奖的资格，自愿参加全国赛终评请点击“确认参赛”。")
    end

    it "returns correct text" do
      visit "/matches/3"
      expect(page).to have_text("张三同学，您的作品已获本届“全国中小学生绘画书法作品比赛”争夺全国赛一等奖或二等奖的资格，自愿参加全国赛终评请点击“确认参赛”。")
    end

    it "returns correct text" do
      visit "/matches/4"
      expect(page).to have_text("张三同学，您的作品已获本届“全国中小学生绘画书法作品比赛”争夺全国赛二等奖或三等奖的资格，自愿参加全国赛终评请点击“确认参赛”。")
    end

    it "returns correct text" do
      visit "/matches/5"
      expect(page).to have_text("张三同学，您的作品已获本届“全国中小学生绘画书法作品比赛”争夺全国赛二等奖或三等奖的资格，自愿参加全国赛终评请点击“确认参赛”。")
    end

    it "returns correct text" do
      visit "/matches/6"
      expect(page).to have_text("很遗憾您的作品未入围“第二十四届全国中小学生绘画书法作品比赛”全国赛终评，感谢您的参与，愿您下届比赛能取得优异成绩！")
    end

  end

end
