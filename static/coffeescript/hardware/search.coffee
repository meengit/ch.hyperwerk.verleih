$(document).ready ->


	# snippet for adding and removing tags
	# tag_select, tag_wrapper and target_form elements as strings needed

	tag_add_remove = (tag_select, tag_wrapper, target_form) ->
		$(tag_select).change (e) ->
			add_remove($(e.target).val(), tag_wrapper, target_form)
			return
		return

	tag_add_remove('.tags', '#tag_wrapper', '#hardware_search')

	# function for adding tags to the form
	
	add_remove = (tag, tag_wrapper, target_form) ->
		$(tag_wrapper).append('<a href="' + tag + '" class="remove_tag btn btn-mini btn-info" style="margin-bottom: 5px;">' + tag + ' <i class="icon-remove-sign icon-white"></i></a> ')
		$(target_form).append('<input type="hidden" name="tag" value="' +  tag + '"/>')
		$('.remove_tag').click (e) ->

			e.preventDefault()

			if $(e.target).hasClass 'remove_tag'
				$(e.target).remove()
				$('input[value="' + $(e.target).attr('href') + '"]').remove()
			else
				$(e.target).parent().remove()
				$('input[value="' + $(e.target).parent().attr('href') + '"]').remove()


			return
		return


	# add searched for labels
	
	if labels.length > 0
		add_remove(label, '#tag_wrapper', '#hardware_search') for label in labels
	
	return
