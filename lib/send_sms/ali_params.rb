# require_relative "../order_data"


module SendSms
  class AliParams
    attr_reader :record, :type, :order_data
    def initialize( record, type )
      @record = record
      @type = type
      @order_data = ::Admin::OrderData.new(order: record)
    end

    def to_params
      self.send(type)
    end

    def jiazhang
      {"name" => record.entry["field_1"]
       }.to_json
    end

  end
end
