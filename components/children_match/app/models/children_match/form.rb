module ChildrenMatch
  class Form < ApplicationRecord
    self.table_name = 'forms'

    has_many :matches

  end
end
