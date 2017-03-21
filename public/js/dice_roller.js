(function (global) {
	var diceCount,
		diceSides,
		modifier;

	function rand(min, max) {
		// generate random integer from min (included) to max (included)
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}

	var DiceRoller = function DiceRoller(diceString) {
		this.setDice(diceString);

		return this;
	};

	DiceRoller.prototype.setDice = function (str) {
		var dRexp = /(\d*)?d(\d+|F)([\+\-]\d*)?/,
			parts = (str || '3d6').match(dRexp), // initialized as 3d6 by default
			count = +parts[1],
			mod = +parts[3] || 0,
			sides = parts[2],
			isFudge = sides === 'F';

		diceCount = count || 1;
		diceSides = isFudge ? 3 : +sides;
		modifier = isFudge ? mod - (diceCount * 2) : mod;

		return this;
	};

	DiceRoller.prototype.roll = function (diceString) {
		if (diceString) this.setDice(diceString); // can be resetted to other dice
		var rndVal = 0;
		for (var i = 0; i < diceCount; i++) {
			rndVal += rand(1, diceSides);
		}
		return rndVal + modifier;
	};

	DiceRoller.prototype.formulaRoll = function (str) {
		// TODO: implement formula roll
	};

	global.DiceRoller = DiceRoller;
})(window);

