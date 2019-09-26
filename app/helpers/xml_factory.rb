# coding: utf-8

class XmlFactory
  attr_reader :file_name, :path, :key_type
  def initialize(ps = {})
    @file_name = 'form_' + ps[:form] if ps[:form]
    @path = ps[:path] || File.join(File.expand_path(  "../", __FILE__ ), file_name)
    # @key_type = ps[:key_type]
  end

  # getting: ["serial_number", "total_price", "trade_no", "trade_status", "payment_method", "field_45", "field_48".....]
  def form_keys
    form_fields && form_fields.map(&:keys).flatten()
  end

  def form_fields
    get_form_structure["fields"]
  end

  # getting:
  # {"fields" => [{
  #       "field_9" => {
  #                   "label": "您对我们的服务满意么？"
  #                 }
  #     }, ... ]}
  def get_form_structure
    fields = []
    hash = {"fields" => fields}
    td_array.each do |item|
      fields << {item.last =>
        {"label" => item.first}
      }
    end
    hash
  end

  # ["序号", "Float", "serial_number"]...
  def td_array
    to_h.map {|h| h["td"]}
  end

  # get tds hash[{"td"=>["序号", "Float", "serial_number"]}, {"td"=>["总价", "Float", "total_price"]}]
  def to_h
    h = Hash.from_xml(xml_data)
    h.dig("tbody","tr")
  end

  # <tbody> data
  def xml_data
    data = ""
    File.read(path).each_line {|line| data << line.chomp}
    data
  end
end
