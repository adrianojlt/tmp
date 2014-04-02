
window.onload = function() {

	//var container = document.getElementById('tabcontainer');
	//var tabs = container.querySelectorAll('.tabnav li');

	//var tabs = document.getElementById('tabcontainer').querySelectorAll('.tabnav li');

	//for ( var i = 0 ; i < tabs.length ; i++ ) { tabs[i].onclick = tabClicked; }
}

function tabClicked(event) {
	event.preventDefault();
	//evento = event;
	var tab = document.getElementById('tabcontainer').querySelector('.tabnav li a.active');
	tab.setAttribute('class','inactive');
	event.srcElement.setAttribute('class','active');
}

function handleDaClick(event) {
	//console.log('clickhandler');
	alert('click');
}

$(document).ready(function() {

	var anchors = $('.tabnav li a');

	for ( var i = 0 ; i < anchors.length ; i++ ) { 

		$(anchors[i]).click(function(e) {

			e.preventDefault();

			var activeLink = $('.tabnav li a.active');
			activeLink.removeClass('active').addClass('inactive');
			$(e.target).removeClass('inactive').addClass('active');

			var indexActiveLink = anchors.index($('.tabnav li a.active'));

			$('.tabcontent.active').removeClass('active').addClass('inactive');
			$($('.tabcontent')[indexActiveLink]).removeClass('inactive').addClass('active');
		});
	}
});