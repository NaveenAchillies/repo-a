class Income < Ledger
	belongs_to :user, :foreign_key=>:ledger_id
	alias_attribute :money , :data1
	alias_attribute :category , :data3
end
