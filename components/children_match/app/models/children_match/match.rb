module ChildrenMatch
  class Match < ApplicationRecord
    self.table_name = 'matches'

    belongs_to :form

  end
end
