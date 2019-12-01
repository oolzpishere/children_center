# require_relative "../order_data"


module SendSms
  class TenParams
    attr_reader :record, :type
    def initialize( record, type )
      @record = record
      @type = type
    end

    def to_params
      self.send(type)
    end

    def jiazhang
      [record.entry["field_1"]]
    end

  end
end
