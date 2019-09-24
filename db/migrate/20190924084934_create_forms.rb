class CreateForms < ActiveRecord::Migration[5.2]
  def change
    create_table :forms do |t|
      t.string :form
      t.string :form_name
      
      t.timestamps
    end
  end
end
