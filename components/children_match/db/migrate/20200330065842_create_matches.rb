class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :serial_number, index: true

      t.string :openid, index: true
      t.string :unionid, index: true
      t.string :phone, index: true
      t.string :email, index: true

      t.belongs_to :form, index: true

      t.json :entry
      t.string :gen_code, index: true
      # t.datetime :form_created_at
      # t.datetime :form_updated_at

      t.timestamps
    end
  end
end
