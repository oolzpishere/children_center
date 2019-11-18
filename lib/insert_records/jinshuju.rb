module InsertRecords
  class Jinshuju < Base
    # InsertRecords::Jinshuju.new("0llDiH").batch_insert

    def batch_insert
      response, response_body_hash = request_loop_block {|response| create_records(response) }
      while response_body_hash["next"]
        response, response_body_hash = request_loop_block(response_body_hash["next"]) {|response| create_records(response) }
      end

    end

    def batch_print
      response, response_body_hash = request_loop_block {|response| print_all_records(response) }
      while response_body_hash["next"]
        response, response_body_hash = request_loop_block(response_body_hash["next"]) {|response| print_all_records(response) }
      end
    end

    def request_loop_block(next_num = nil, &block)
      request = request(next_num)
      response = request.response
      raise "request form data fail. #{response.body}" unless response.success?
      # response is array of multiple datas.
      response_body_hash = JSON.parse(response.body)

      yield(response_body_hash["data"])

      return response, response_body_hash
    end

    def create_records(data_array)
      records = []
      @form_obj = Form.find_or_create_by(form: form)
      data_array.each do |record|
        records << Match.new( match_params(record) )
      end
      Match.import records
    end

    def print_all_records(data_array)
      records = []
      @form_obj = Form.find_or_create_by(form: form)
      data_array.each do |record|
        puts record
        records << Match.new( match_params(record) )
      end
      # puts records
    end

    def match_params(record)
      {
       id: record["serial_number"],
       form_id: @form_obj.id,
       serial_number: record["serial_number"],
       openid: record["x_field_weixin_openid"],
       # unionid: "",
       # phone: "",
       # email: "",
       gen_code: record["gen_code"],
       entry: record,
     }
    end

    def request(next_num = nil)
      if next_num
        form_url = "https://jinshuju.net/api/v1/forms/#{form}/entries?next=#{next_num}"
      else
        form_url = "https://jinshuju.net/api/v1/forms/#{form}/entries"
      end

      request = Typhoeus::Request.new(
        form_url,
        method: :get,
        userpwd: "#{ENV["JINSHUJU_API_KEY"]}:#{ENV["JINSHUJU_API_SECRET"]}",
        body: "",
        params: {},
        headers: { Accept: "application/json", "Content-Type" => "application/json" }
      )
      request.run
      request
    end


  end
end
