class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :birthday
      t.references :user, index: true

      t.timestamps
    end
  end
end
