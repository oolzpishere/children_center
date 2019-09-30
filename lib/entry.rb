# coding: utf-8
class Entry
  attr_accessor :entry, :form_fields
  attr_reader :result, :xml_factory, :form_keys, :show_fileds, :default_reject_fields

  # hd=hash_data
  # params:
  # ps[:result]
  # optional: ps[:show_fileds]
  def initialize(ps = {})
    @result = ps[:result]
    @entry = result[:entry]
    form = result.form
    # form = ps[:form]
    form_unique_id = form.form
    form_name = form.form_name

    @show_fileds = ps[:show_fileds]

    @xml_factory = XmlFactory.new(form: form_unique_id)
    # xml_factory.form_keys: xml的生成较久，需要0.03s,所以需要把数据存出来
    @form_fields = xml_factory.form_fields
    @form_keys = xml_factory.form_keys

    @default_reject_fields = ['发票号', '邮寄状态','提交人', '微信头像', '微信OpenID', '微信昵称', '微信性别', '微信国家', '微信省市', '修改时间', 'IP', "填写设备", "操作系统", "浏览器"]
  end

  def set_show_values
    set_form_field_values

    if show_fileds
      filter_show_fileds
    else
      form_fields
    end
  end

  def set_form_field_values
    remove_default_reject_fields

    form_fields.each do |hash|
      k = hash.keys.first
      v = entry[k]
      hash[k]["value"] = v
    end
    form_fields
  end

  def filter_show_fileds
    form_fields.select do |hash|
      v = hash.values.first
      label = v["label"]
      show_fileds.include?(label)
    end
  end

  def remove_default_reject_fields
    form_fields.delete_if do |hash|
      v = hash.values.first
      label = v["label"]
      default_reject_fields.include?(label)
    end
  end

end
