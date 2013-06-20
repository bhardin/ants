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
	$('input').on "blur", -> $(this)
		.parents("form")
		.submit()
		.parents("td")
		.addClass("submitted")
		
		
		