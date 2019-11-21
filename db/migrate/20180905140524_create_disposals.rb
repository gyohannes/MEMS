class CreateDisposals < ActiveRecord::Migration[5.1]
  def change
    create_table :disposals, id: :uuid do |t|
      t.references :equipment, type: :uuid, foreign_key: true
      t.references :disposal_request, type: :uuid, foreign_key: true
      t.string :reason_for_disposal
      t.string :disposal_method
      t.text :disposing_committee
      t.date :disposed_date

      t.timestamps
    end
  end
end
