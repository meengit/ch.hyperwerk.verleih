$(document).ready ->
	
	# snippet for adding and removing tags
	# tag_select, tag_wrapper and target_form elements as strings needed

	tag_add_remove = (tag_select, tag_wrapper, target_form) ->
		$(tag_select).change (e) ->
			add_remove($(e.target).val(), tag_wrapper, target_form)
			return
		return

	tag_add_remove('.tags', '#tag_wrapper', '#hardware_form')

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


	# add existing labels if editing hardware
	
	if edit or copy
		add_remove(label, '#tag_wrapper', '#hardware_form') for label in labels


	# check form if inventory number is allready existant and necessary
	# inputs filled
	
	inventory_number = $('.inventory_number').val()

	$('.submit').click (e) ->

		e.preventDefault()

		not_fullfilled_yet = []
		$('.check').each (index, value) ->

			if not $(value).val()
				not_fullfilled_yet.push $(value).parent().children('label').text()

			return

		if not_fullfilled_yet.length > 0
			alert 'Bitte noch ' + not_fullfilled_yet.join(', ') + ' ausfüllen.'

			return

		if edit and $('.inventory_number').val() is inventory_number

			$('#hardware_form').submit()

			return

		$.post '/hardware/invn/', {number: $('.inventory_number').val()}, (data) ->
			if data is 'true'
				alert 'Inventarnummer schon vorhanden.'

				return

			$('#hardware_form').submit()

			return

		return

	return
