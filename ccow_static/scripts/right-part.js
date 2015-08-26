$(document).ready(function(){
	$(".adduser").click(function(){
		var d = dialog({
			skin: 'min-dialog tips',
			title: 'message',
			content: '<input autofocus />',
			statusbar: '<label><input type="checkbox">不再提醒</label>',
			ok: function () {},
		});
		d.showModal();
	});
});
