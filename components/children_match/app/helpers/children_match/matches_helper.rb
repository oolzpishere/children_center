module ChildrenMatch
  module MatchesHelper

    # reject rows on results show page
    # reject sign up not includ numbers
    # sign up value is hash
    # 发票单位全称（开发票抬头） ()前后不可有空格，影响筛选
    def compile_value(value)
      if value.is_a?(Hash)
        value.reject { |k,v| v.empty? }
      # for products
      elsif value.is_a?(Array) && value_is_product?(value)
        # value.reject { |item| item.empty? }

        result = []
        value.each do |hash|
          product = []
          product << "#{hash['name']}" if hash['name']
          spec = hash['spec']
          product << "(#{spec.values.first})" if spec
          product << " x "
          product << "#{hash['number']}"if hash['number']
          product = product.join

          result << product
        end
        result.join(', ')

      else
        value
      end
    end

  end
end
