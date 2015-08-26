$(document).ready(function(){
	$('div[id^="plate"]').click(function(){
		$(this).siblings().toggleClass('hidden');
	});
});