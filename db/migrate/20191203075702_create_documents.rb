class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents, id: :uuid do |t|
      t.string :name
      t.references :documentable, type: :uuid, polymorphic: true, index: true

      t.timestamps
    end
  end
end
