FactoryBot.define do
  entry_sting = '{
    "serial_number": 123,
    "field_28": "",
    "field_1": "张三",
    "field_2": "选项1",
    "field_3": 123,
    "field_4": {
      "province": "陕西省",
      "city": "西安市",
      "district": "雁塔区",
      "street": "高新路"
    },
    "field_5": "这是一行文字",
    "field_6": "张三",
    "field_7": "13812345678",
    "field_8": "support@jinshuju.net",
    "field_19": "选项1",
    "field_12": "选项1",
    "field_13": "选项1",
    "field_14": "这是一行文字",
    "field_15": "这是一段文字",
    "field_16": "这是一行文字",
    "field_17": "13812345678",
    "field_21": "选项1",
    "field_22": "选项1",
    "field_23": "选项1",
    "field_24": "这是一行文字",
    "field_25": "这是一段文字",
    "field_26": "这是一行文字",
    "field_27": "13812345678",
    "x_field_weixin_nickname": "小王",
    "x_field_weixin_gender": "男",
    "x_field_weixin_country": "中国",
    "x_field_weixin_province_city": {
      "province": "陕西",
      "city": "西安"
    },
    "x_field_weixin_openid": "adsfQWEasfxqw",
    "x_field_weixin_headimgurl": "http://wx.qlogo.cn/mmopen/m8kRxejzzH0/0",
    "creator_name": "小王",
    "created_at": "2019-11-20T06:13:48.967Z",
    "updated_at": "2019-11-20T06:13:48.967Z",
    "info_remote_ip": "127.0.0.1"
  }'
  # It's string, not convert to json!!
  entry_json_prize_empty = JSON.parse(entry_sting)
  entry_json_prize_one = entry_json_prize_empty.dup
  entry_json_prize_two = entry_json_prize_empty.dup
  entry_json_prize_three = entry_json_prize_empty.dup
  entry_json_prize_four = entry_json_prize_empty.dup
  entry_json_prize_five = entry_json_prize_empty.dup

  entry_json_prize_one["field_28"] = "特等奖"
  entry_json_prize_two["field_28"] = "一等奖"
  entry_json_prize_three["field_28"] = "二等奖"
  entry_json_prize_four["field_28"] = "三等奖"
  entry_json_prize_five["field_28"] = "优胜奖"

  factory :match, class: "Match" do
    serial_number { 1 }
    openid { ""}
    unionid { "" }
    phone {}
    email {}
    entry { entry_json_prize_empty }
    gen_code {}
  end

  factory :form, class: "Form" do
    form {"0llDiH"}
    form_name {"第二十四届全国中小学生绘画书法作品比赛广西赛区参赛报名表"}
    factory :form_with_matchs do
      after(:create) do |form, evaluator|
        create(:match, form: form)
        create(:match, form: form, serial_number: 2, entry: entry_json_prize_one)
        create(:match, form: form, serial_number: 3, entry: entry_json_prize_two)
        create(:match, form: form, serial_number: 4, entry: entry_json_prize_three)
        create(:match, form: form, serial_number: 5, entry: entry_json_prize_four)
        create(:match, form: form, serial_number: 6, entry: entry_json_prize_five)
      end
    end
  end


end
