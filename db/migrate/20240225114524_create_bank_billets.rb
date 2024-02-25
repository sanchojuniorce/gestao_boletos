class CreateBankBillets < ActiveRecord::Migration[7.1]
  def change
    create_table :bank_billets do |t|

      t.timestamps
    end
  end
end
