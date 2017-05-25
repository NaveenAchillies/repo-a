class CreateLedgers < ActiveRecord::Migration[5.0]
  def change
    create_table :ledgers do |t|
    	t.integer :ledger_id, :index=>true
		t.integer :data1
		t.integer :data2
		t.string :data3
		t.string :type, :limit=>100
		t.timestamps
    end
  end
end
