class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :env
      t.string :key
      t.string :value
      t.string :keyclass
      t.boolean :admin
      t.boolean :global

      t.timestamps
    end
  end
end
