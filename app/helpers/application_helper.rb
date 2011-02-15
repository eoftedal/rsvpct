module ApplicationHelper
	def dateFormat (date) 
		date.strftime "%Y-%m-%d %H:%M"
	end
	def current_group 
		Group.find(params[:group_id])
	end
end
