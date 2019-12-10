class CreateForwards < ActiveRecord::Migration[5.2]
  def change
    create_table :forwards, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.references :institution, type: :uuid, foreign_key: true
      t.references :forwardable, type: :uuid, polymorphic: true, index: true

      t.timestamps
    end
  end
end
