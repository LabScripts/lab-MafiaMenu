var sound = new Audio('sound.wav');
    sound.volume = 1.0;

// Partial Functions
function closeMain() {
	$("body").fadeOut(500);
	$(".members").fadeOut(500);
	$(".leaderboard").fadeOut(500);
}
function openMain() {
	$("body").fadeIn(500);
}
function closeAll() {
	$(".body").fadeOut(500);
	$(".members").fadeOut(500);
	$(".leaderboard").fadeOut(500);
}
function openMembers() {
	$.post('https://lab-MafiaMenu/members', JSON.stringify({}));
	$(".Elements").fadeOut(500);
	$(".members").fadeIn(500);
}
function closeMembers() {
	$(".members").fadeOut(500);
}

function openLeaderboard() {
	$.post('https://lab-MafiaMenu/leaderboard', JSON.stringify({}));
	$(".leaderboard").fadeIn(500);
	$(".Elements").fadeOut(500);
}
function closeMembers() {
	$(".leaderboard").fadeOut(500);
}
$(".recruit").click(function(){
	$.post('https://lab-MafiaMenu/quit', JSON.stringify({}));
    $.post('https://lab-MafiaMenu/recruit', JSON.stringify({}));
});
$(".close").click(function(){
    $.post('https://lab-MafiaMenu/quit', JSON.stringify({}));
});
function Back() {
    $(".members").fadeOut(500);
	$(".leaderboard").fadeOut(500);
	$(".Elements").fadeIn(500);
};
// Listen for NUI Events
window.addEventListener('message', function (event) {

	var item = event.data;

	// Open & Close main window
	if (item.message == "show") {
		openMain();
		$( ".Elements h3" ).empty();
		$( ".Elements h2" ).empty();
		$( ".Elements h3" ).append('<h3>BLACK<span style="color:#ff0037">MARKET</span><br>REPUTATION<hr><span style="color:#ff0037;text-shadow: 0 0 15px #ff0037;">' + item.rep + '</span>XP</h3>');
		$( ".Elements h2" ).append('<h2>CRIMINAL<br>TEAM<span style="color:#ff0037;display: inline-block;">SCORE</span><hr><span style="color:#ff0037;text-shadow: 0 0 15px #ff0037;">' + item.score + '</span> POINTS</h2>');
	}

	if (item.message == "hide") {
		closeMain();
	}

	if (item.message == "leaderboard") {
		$( ".table-holder" ).empty()
		$( ".table-holder" ).append('<table style="width:90%; margin-left:5%;table-layout: auto;"></table>')
		$( "table" ).append('<tr>' +
		'<th class="divider">Name</th>' +
		'<th class="divider">Organisation</th>' +
		'<th class="divider">Score</th>' +
	  	'</tr>')
	}

	if (item.message == "addLeaderboard") {
		$( "table" ).append('<tr>' +
		'<td class="text"><b><span style="animation-name:glow;animation-duration:1s;animation-iteration-count:infinite;animation-direction:alternate;">' + item.label + '</span></b></td>' +
		'<td class="text"><b><span style="animation-name:glow;animation-duration:1s;animation-iteration-count:infinite;animation-direction:alternate;">' + item.type + '</span></b></td>' +
		'<td class="text"><b><span style="animation-name:glow;animation-duration:1s;animation-iteration-count:infinite;animation-direction:alternate;">' + item.score + '</span></b></td>' +
		'</tr>')
	}

	if (item.message == "members") {
		$( ".members-holder" ).empty()
	}

	if (item.message == "addMembers") {
		$( ".members-holder" ).append(
		'<div class="user"><h1>' + item.label + ' <div name="' + item.value + '" class="promote" style="display: inline-block;"><i class="fa-solid fa-user-plus" id = "promote" style = "color:#00ff9d;transform:scale(0.9)"> </i></div> <div name="' + item.value + '" class="descend" style="display: inline-block;"><i class="fa-solid fa-user-minus" id = "descend" style = "color:#ff0077;transform:scale(0.9)"> </i></div> <div name="' + item.value + '" class="fireBTN" style="display: inline-block;"><i class="fa-solid fa-user-slash" id = "fire" onclick="Fire()" style = "color:#ff0037;transform:scale(0.9)"> </i></div></h1></div>')
	}
});

$(".members-holder").on("click", ".fireBTN", function() {
	var $button = $(this);
	var $name = $button.attr('name')

	$.post('https://lab-MafiaMenu/fire', JSON.stringify({
		item: $name
	}));

});

$(".members-holder").on("click", ".promote", function() {
	var $button = $(this);
	var $name = $button.attr('name')

	$.post('https://lab-MafiaMenu/promote', JSON.stringify({
		item: $name
	}));

})

$(".members-holder").on("click", ".descend", function() {
	var $button = $(this);
	var $name = $button.attr('name')

	$.post('https://lab-MafiaMenu/descend', JSON.stringify({
		item: $name
	}));

})

$(".hideout").click(function(){
	$.post('https://lab-MafiaMenu/quit', JSON.stringify({}));
    $.post('https://lab-MafiaMenu/hideout', JSON.stringify({}));
});
