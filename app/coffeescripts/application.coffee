# Rating initialize for .rating blocks
jQuery ->
	$(".rating").each ->
		id = $(@).attr "id" 
		VK.Widgets.Like id, type: "button", id

# Comments initialization for .comments block
jQuery ->
	id = $(".comments").attr "id"
	
	callback = (num, last_comment, date, sign) ->
		date = encodeURIComponent date
		last_comment = encodeURIComponent last_comment
		$.ajax
			url: '/vk/comment'
			data: "id=#{id}&num=#{num}&last_comment=#{last_comment}&date=#{date}&sign=#{sign}"
			dataType: 'json'
			type:     'post'
			success: (result) ->
	
	params = 
		limit: 20
		width: "496"
		attach: "*"
		norealtime: 1
		onChange: callback
	VK.Widgets.Comments id, params, id
	

	
