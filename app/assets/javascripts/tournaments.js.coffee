# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


# all_matches_scored
# Look at every input, make sure that there is a value
# If there is a value, return true
# Else False

square = (x) -> x * x
cube = (x) -> square(x) * x

$(document).ready ->
	$('.score').on 'blur', -> $(this)
		#.hide()
		.parents('form')
		.submit()
		.parents('tr')
		.find('.finalize')
		.submit()

	$('.finalize').on 'click', -> 
		if $(this).text() == 'Finalize'
			$(this)
			  .text("Submitted")
				.parents("tr")
				.find('.match').toggleClass('submitted')
		else
			$(this)
				.text("Finalize")
				.parents("tr")
				.find('.match').toggleClass('submitted')
		
$(document).ready ->
	$('#add_player').on 'click', -> $('#add_player_form').toggle()
		


