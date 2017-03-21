$(document).ready(function() {
    $(" #nav li").hover(function() {
        $(this).find('ul:first').css({visibility: "visible", display: "none"}).show();
    }, function(){
        $(this).find('ul:first').css({visibility: "hidden"});
    });
    $("#user-input").keypress(function(event) {
        if (event.which == 13) {
            var dr = new DiceRoller($(this).val());
            var rs = "<div class='roll'>Rolled: " + $(this).val() + " => <b>" + dr.roll() + "</b></div>";
            $("#messages").prepend(rs);
            $(this).val("");
        }
    });
    $("#d20-button").click(function() {
        var dr = new DiceRoller("1d20");
        var rs = "<div class='roll'>Rolled: 1d20 => <b>" + dr.roll() + "</b></div>";
        $("#messages").prepend(rs);
    });
});