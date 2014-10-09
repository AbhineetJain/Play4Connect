module ApplicationHelper
	BOOTSTRAP_FLASH = { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }
	def bootstrap_class_for(flash_type)
    	case flash_type.to_s
	        when 'notice' then "alert-info"
	        when 'success' then "alert-success"
	        when 'error' then "alert-danger"
	        when 'alert' then "alert-warning"
	    end
	end
 
	def flash_messages(opts = {})
		flash.each do |msg_type, message|
			concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
				concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
				concat message
			end)
		end
		nil
	end
end
