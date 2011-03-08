module ApplicationHelper
	require 'digest/md5'
	def dateFormat (date) 
		date.strftime "%Y-%m-%d %H:%M"
	end
	def current_group 
		Group.find(params[:group_id])
	end
	def md5 (text) 
		Digest::MD5.hexdigest(text)
	end
end
