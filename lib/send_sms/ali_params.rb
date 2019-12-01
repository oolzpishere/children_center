# require_relative "../order_data"


module SendSms
  class AliParams
    attr_reader :record, :type
    def initialize( record, type )
      @record = record
      @type = type
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
