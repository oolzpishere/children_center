# coding: utf-8
module Zxml
  class XmlFactory
    attr_reader :file_name, :path, :key_type
    def initialize(ps = {})
      @file_name = 'form_' + ps[:form] if ps[:form]
      @path = ps[:path] || File.join(File.expand_path(  "../", __FILE__ ), file_name)
      # @key_type = ps[:key_type]
    end

    #getting {"serial_number"=>"序号", ...}
    def name_pair
      reverse_array_item.to_h
    end

    def reverse_array_item
      delete_center.map {|arr| arr.reverse}
    end

    # delete change the source
    # ["序号", "Float", "serial_number"] > ["序号", "serial_number"]
    def delete_center
      td_array.each {|td| td.delete_at(1)}
    end

    def td_array
      to_h(xml_data).map {|h| h["td"]}
    end

    # <tbody> data
    def xml_data
      data = ""
      File.read(path).each_line {|line| data << line.chomp}
      data
    end

    # get tds hash[{"td"=>["序号", "Float", "serial_number"]}, {"td"=>["总价", "Float", "total_price"]}]
    def to_h(data)
      h = Hash.from_xml(data)
      h.dig("tbody","tr")
    end
  end
end
