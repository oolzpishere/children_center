# coding: utf-8
class Entry
  attr_accessor :entry
  attr_reader :result, :xml_factory, :form_fields

  # hd=hash_data
  # [params] Result.any
  def initialize(ps = {})
    @result = ps[:result]
    @entry = result[:entry]
    form = result.form
    form_unique_id = form.form
    form_name = form.form_name

    @xml_factory = XmlFactory.new(form: form_unique_id)
    @form_fields = xml_factory.form_fields
  end

    def show_values
      name_values = {}
      values.each do |k,v|
        label = form_structure[k] && form_structure[k]["label"]
        name_values[label] = v
      end
      name_values
    end

    # def values
    #   # values = eng_key? ? change_name : filter_entry
    #   # except_hash(values)
    #   v = except_hash(filter_entry)
    #   reject_empty(v)
    # end

    # 对应不上最新form_files的则不显示
    # english key use keys or chinese key use values from name_pair
    def get_permitted_entry
      entry = filter_entry_by_form

      # todo better do it at show action.
      reject_array = ['发票号', '邮寄状态','提交人', '微信头像', '微信OpenID', '微信昵称', '微信性别', '微信国家', '微信省市', '修改时间', 'IP']
      entry = except_hash(reject_array, entry)
    end

    def filter_entry_by_form
      entry.select do |k, _|
        xml_factory.form_keys.include?(k)
      end
    end

    def except_hash(reject_array, entry)
      entry.reject do |k,_|
        form_field = form_fields.select {|i| i.keys.include? k}.first
        reject_array.include?( form_field["label"] )
      end
    end

    # todo not used.
    # reject empty products
    def reject_empty(values)
      values.reject { |k,v|
        ( !v.to_s.match(/\d/) if v.is_a?(Hash) || v.is_a?(Array) ) || v.to_s.chomp.empty?
      }
    end


end
