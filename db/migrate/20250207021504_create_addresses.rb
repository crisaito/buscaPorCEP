class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.string :cep
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
