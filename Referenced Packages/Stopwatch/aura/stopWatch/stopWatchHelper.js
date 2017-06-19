({
	displayAndSetTimer : function(cmp) {
		cmp.set("v.timer", this.formatGivenTime(cmp.priv_stopWatchTracker
				.time()));
	},

	formatGivenTime : function(time) {
		var hour = min = sec = ms = 0;
		var newTime = '';

		hour = Math.floor(time / (60 * 60 * 1000));
		time = time % (60 * 60 * 1000);
		min = Math.floor(time / (60 * 1000));
		time = time % (60 * 1000);
		sec = Math.floor(time / 1000);
		ms = time % 1000;

		newTime = this.padTime(hour, 2) + ':' + this.padTime(min, 2) + ':'
				+ this.padTime(sec, 2) + ':' + this.padTime(ms, 3);
		return newTime;
	},

	padTime : function(num, size) {
		var time = "0000" + num;
		return time.substr(time.length - size);
	},

	stop : function(cmp) {
		cmp.priv_stopWatchTracker.stop();
		if (cmp.priv_clocktimer) {
			clearInterval(cmp.priv_clocktimer);
		}
	}
})