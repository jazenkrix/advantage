$(document).ready(function() {
    $(" #nav li").hover(function() {
        $(this).find('ul:first').css({visibility: "visible", display: "none"}).show();
    }, function(){
        $(this).find('ul:first').css({visibility: "hidden"});
    });
    $("form#new_encounter_form").submit(function(e) {
        e.preventDefault();
        $.ajax({
            type: "POST",
            url: "/encounter/new",
            data: $("form#new_encounter_form").serialize(),
            success: function(){
                $("#messages").prepend("<div class='success'>Encounter Added</div>");
            },
            error: function(){
                $("#messages").prepend("<div class='failure'>Error Adding Encounter</div>");
            }
        });
        $.modal.close();
    });
    $("form#new_player_form").submit(function(e) {
        e.preventDefault();
        $.ajax({
            type: "POST",
            url: "/player/new",
            data: $("form#new_player_form").serialize(),
            success: function(){
                $("#messages").prepend("<div class='success'>Player Added</div>");
            },
            error: function(){
                $("#messages").prepend("<div class='failure'>Error Adding Player</div>");
            }
        });
        $.modal.close();
    });
    $("form#new_npc_form").submit(function(e) {
        e.preventDefault();
        $.ajax({
            type: "POST",
            url: "/npc/new",
            data: $("form#new_npc_form").serialize(),
            success: function(){
                $("#messages").prepend("<div class='success'>NPC Added</div>");
            },
            error: function(){
                $("#messages").prepend("<div class='failure'>Error Adding NPC</div>");
            }
        });
        $.modal.close();
    });
    $("form#new_monster_form").submit(function(e) {
        e.preventDefault();
        $.ajax({
            type: "POST",
            url: "/monster/new",
            data: $("form#new_monster_form").serialize(),
            success: function(){
                $("#messages").prepend("<div class='success'>Monster Added</div>");
            },
            error: function(){
                $("#messages").prepend("<div class='failure'>Error Adding Monster</div>");
            }
        });
        $.modal.close();
    });
    $("#user-input").keypress(function(event) {
        if (event.which == 13) {
            var dr = new DiceRoller($(this).val());
            var rs = "<div class='roll'>Rolled: " + $(this).val() + " => <b>" + dr.roll() + "</b></div>";
            $("#messages").prepend(rs);
            $(this).val("");
        }
    });
    $(".d4-button").click(function() {
        var dr = new DiceRoller("1d4");
        var rs = "<div class='roll'>Rolled: 1d4 => <b>" + dr.roll() + "</b></div>";
        $("#messages").prepend(rs);
    });
    $(".d6-button").click(function() {
        var dr = new DiceRoller("1d6");
        var rs = "<div class='roll'>Rolled: 1d6 => <b>" + dr.roll() + "</b></div>";
        $("#messages").prepend(rs);
    });
    $(".d8-button").click(function() {
        var dr = new DiceRoller("1d8");
        var rs = "<div class='roll'>Rolled: 1d8 => <b>" + dr.roll() + "</b></div>";
        $("#messages").prepend(rs);
    });
    $(".d10-button").click(function() {
        var dr = new DiceRoller("1d10");
        var rs = "<div class='roll'>Rolled: 1d10 => <b>" + dr.roll() + "</b></div>";
        $("#messages").prepend(rs);
    });
    $(".d12-button").click(function() {
        var dr = new DiceRoller("1d12");
        var rs = "<div class='roll'>Rolled: 1d12 => <b>" + dr.roll() + "</b></div>";
        $("#messages").prepend(rs);
    });
    $(".d20-button").click(function() {
        var dr = new DiceRoller("1d20");
        var rs = "<div class='roll'>Rolled: 1d20 => <b>" + dr.roll() + "</b></div>";
        $("#messages").prepend(rs);
    });
    $(".d100-button").click(function() {
        var dr = new DiceRoller("1d100");
        var rs = "<div class='roll'>Rolled: 1d100 => <b>" + dr.roll() + "</b></div>";
        $("#messages").prepend(rs);
    });
    $(".attack").click(function(e) {
        e.preventDefault();
        var id = $(this).prop("id");
        var name = id.split('/')[0];
        var attack = id.split('/')[1];
        var hit = parseInt(id.split('/')[2]);
        var dmg = id.split('/')[3];
        var type = id.split('/')[4];
        var dr = new DiceRoller();
        var to_hit_1 = dr.roll("1d20");
        var ar1 = "";
        if (to_hit_1 == 20) {
            ar1 = "<span class='green'>" + (to_hit_1 + hit) + " : </span>"
        } else if (to_hit_1 == 1) {
            ar1 = "<span class='red'>" + (to_hit_1 + hit) + " : </span>"
        } else {
            ar1 = "<span>" + (to_hit_1 + hit) + " : </span>"
        }
        var to_hit_2 = dr.roll("1d20");
        var ar2 = "";
        if (to_hit_2 == 20) {
            ar2 = "<span class='green'>" + (to_hit_2 + hit) + "</span>"
        } else if (to_hit_2 == 1) {
            ar2 = "<span class='red'>" + (to_hit_2 + hit) + "</span>"
        } else {
            ar2 = "<span>" + (to_hit_2 + hit) + "</span>"
        }
        var normal = dr.roll(dmg);
        var critical = 0;
        if (dmg.includes("+")) {
            critical = (normal + dr.roll(dmg.split("+")[0]));
        } else {
            critical = (normal + dr.roll(dmg));
        }
        var rs = "<div class='attack-result'>" +
            "<div class='result-box'>" +
                "<div class='attacker-name'>" + name + "</div>" +
                "<div class='attack-name'>Attack: " + attack + " (+" + hit + " to hit)</div>" +
                "<div class='attack-rolls'>" + ar1 + ar2 + "</div>" +
            "</div>" +
            "<div class='damage-box'>" +
                "<div class='damage'>Damage: " + type + "</div>" +
                "<div class='damage-rolls'>" + normal + " : "  + "<span class='green'>" + critical + "</span></div>" +
                "<div class='damage-raw'>" + id + "</div>" +
            "</div>";
        $("#messages").prepend(rs);
    });
    $("#update-initiative").click(function () {
        $("#update-initiative").hide(function() {
            $("#initiative_order").hide(function () {
                $("#edit-initiative").show(function () {
                });
            });
        });
    });
    $("#creatures").autocomplete({
        source: "/creatures",
        minLength: 3,
        select: function( event, ui ) {
            $("#results").text("input was: '"+ this.value + "' and selection was: "+ ui.item.value);
        }
    });
});