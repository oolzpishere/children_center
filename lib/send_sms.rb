require_relative "send_sms/ali_params"


module SendSms
  class Base
    attr_reader :record, :type

    def initialize(record, type)
      @record = record
      @type = type
    end

    def send_sms
    end
  end

  class Ali < Base
    # SendSms::Ali.new(match, "jiazhang", "15977793123").send_sms
    # test: SendSms::Ali.new("", "test", "15977793123").send_sms
    attr_reader :phone_numbers
    def initialize(record, type, phone=nil)
      @record = record
      @type = type
      @phone_numbers = phone || record.phone
    end

    def send_sms
      template_code, template_param = self.sms_params(type)
      Aliyun::Sms.send(phone_numbers, template_code, template_param)
    end

    def sms_params(type)
      case type
      when /jiazhang/
        template_code = "SMS_179230643"
        template_param = AliParams.new(record, type).to_params
      when /test/
        template_code = "SMS_179230643"
        template_param = {"name" => "李志鹏鹏"}.to_json
      end
      return template_code, template_param
    end

  end

  class Tencent < Base
    # SendSms::Tencent.new(match, "test").send_sms
    attr_reader :phone_number
    def initialize(record, type, phone=nil)
      @record = record
      @type = type
      @phone_number = phone || self.get_phone
    end

    def send_sms
      template_code, template_param = self.sms_params
      Qcloud::Sms.single_sender(phone_number, template_code, template_param)
      # records.each do |record|
      #   template_param = self.to_params(record)
      #   phone_number = record.phone
      #   Qcloud::Sms.single_sender(phone_number, template_code, params)
      # end
    end

    def sms_params
      case type
      when /jiazhang/
        template_code = "486620"
        template_param = [record.entry["field_1"]]
      when /test/
        template_code = "486620"
        template_param = ["field_1"]
      end
      return template_code, template_param
    end

    def get_phone
      record.entry["field_7"]
    end

    def _buf_send_match
      matches = Match.all.order(:id)[5000..-1].select {|m| m.entry["field_29"].match(/二等奖或三等奖/)}; 0

      m_phones=[]
      m_phone_uniq=[]
      matches.each do |m|
        phone = m.entry["field_7"]
        unless m_phones.include? phone
          m_phones << phone
          m_phone_uniq << m
        end
      end; 0

    end

  end

end
