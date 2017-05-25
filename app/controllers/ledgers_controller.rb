class LedgersController < ApplicationController
	require "csv"

	def index
		if current_user.present?
			@data = current_user.incomes.to_a
			@total_income = @data.pluck(:data1).sum
			expenses = current_user.expenses.to_a
			@data << expenses 
			@data = @data.flatten
			
			@total_expense = expenses.pluck(:data1).sum
			respond_to do |format|
				format.html {}
				format.pdf {
					label_data = self.render_to_string(:action=>'/index', :layout=>false)
					label_data = WickedPdf.new.pdf_from_string(label_data)
					send_data(label_data, :filename=>"data.pdf")
				}
				format.csv { 
					response = ["Type","Category","Amount","Created"].to_csv
					@data.each do |data|
	        			response += [data.type,data.data3,data.data1,data.created_at.strftime('%b %d,%Y')].to_csv
	  				end
					send_data(response, :filename=> "data.csv")
	    		}
			end
		end
	end


	def create
		new_courier = current_user.incomes.create(params[:income].to_hash.with_indifferent_access) if params[:data] == "income"
		new_courier = current_user.expenses.create(params[:income].to_hash.with_indifferent_access) if params[:data] == "expense"
		redirect_to :action => 'index'
	end

	def new_income
		
	end

	def edit
		courier = Ledger.where(:id=>params[:id])[0]
	end

	def update			
		courier = CourierPanel::Courier.unscope(:where).where(:id=>params[:id])[0]
		if courier.present?
			Account.with_account(params[:couriers][:vaccount_id].to_i) do
				courier.update_attributes(params[:couriers].to_hash.with_indifferent_access)
			end
		end
	    redirect_to :action => 'index'
	end

	def destroy
		ledger = Ledger.where(:id=>params[:id], :ledger_id=>current_user.id)[0]
		if ledger.present?
			ledger.destroy
		end 
		return redirect_to :back, :flash=>{:success=>'Successfully record deleted.'}
	end

end