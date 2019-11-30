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
    attr_reader :phone_numbers
    def initialize(record, type)
      super
      @phone_numbers = record.phone
    end

    def send_sms
      template_code, template_param = self.sms_params(type)
      Aliyun::Sms.send(phone_numbers, template_code, template_param)
    end

    def sms_params(type)
      case type
      when /order/
        if record.hotel.car == 0
          # Don't have car usage
          template_code = "SMS_173472652"
          template_param = AliParams.new(record, 'order').to_params
          # send_order_sms
        else
          template_code = "SMS_173945715"
          template_param = AliParams.new(record, 'order_car').to_params
          # send_order_car_sms
        end
        # order_sms
      when /cancel/
        template_code = "SMS_173950836"
        template_param = AliParams.new(record, type).to_params
      end
      return template_code, template_param
    end

    # def order_sms
    # end
    #
    # def send_order_sms
    #   template_code = "SMS_173472652"
    # end
    #
    # def send_order_car_sms
    #   template_code = "SMS_173477675"
    # end

  end

  class Tencent < Base
    # SendSms::Tencent.new(match, "test").send_sms
    attr_reader :phone_numbers
    def initialize(record, type)
      super
      @phone_numbers = self.get_phone(record)
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
        template_code = "486553"
        template_param = [record.entry["field_1"]]
      when /test/
        template_code = "276826"
        template_param = [record.entry["field_1"]]
      end
      return template_code, template_param
    end

    def get_phone
      record.entry["field_7"]
    end

  end

end
