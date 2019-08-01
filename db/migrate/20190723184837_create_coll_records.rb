class CreateCollRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :coll_records do |t|
      t.string :identifier
      t.string :creator
      t.string :subject
      t.string :title
      t.string :dc_format
      t.string :coverage
      t.date :date
      t.string :source
      t.string :rights
      t.string :dc_type
      t.text :description
      t.string :genre
      t.text :member_of
      t.string :bhl_cr
      t.string :bhl_el
      t.string :bhl_g
      t.string :bhl_su
      t.string :bhl_it
      t.string :crania1ic_collection
      t.string :crania1ic_includes
      t.string :crania1ic_pathology_symptom
      t.string :crania1ic_sex
      t.string :hart_cr
      t.string :hart_da
      t.string :hart_lo
      t.integer :hart_ordno
      t.string :hart_su
      t.string :hart_vt
      t.integer :hart_wono
      t.string :kelsey_colls
      t.string :kelsey_lot
      t.string :kelsey_mat
      t.string :kelsey_objtype
      t.string :kelsey_sit
      t.string :kelsey_verbpro

      t.timestamps
    end
  end
end
