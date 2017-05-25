class User < ActiveRecord::Base
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable, :lockable, :timeoutable

	has_many :incomes, :foreign_key=>:ledger_id
	has_many :expenses, :foreign_key=>:ledger_id
end
