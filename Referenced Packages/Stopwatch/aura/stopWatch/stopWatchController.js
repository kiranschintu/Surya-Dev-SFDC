({
	startTimer : function(cmp, event, helper) {
		cmp.priv_clocktimer = setInterval(function() {
			helper.displayAndSetTimer(cmp)
		}, 1);
		cmp.priv_stopWatchTracker.start();
	},

	stopTimer : function(cmp, event, helper) {
		helper.stop(cmp);
	},

	resetTimer : function(cmp, event, helper) {
		helper.stop(cmp);
		cmp.priv_stopWatchTracker.reset();
		helper.displayAndSetTimer(cmp);
	},
	
	init : function(cmp, event, helper) {
		cmp.priv_stopWatch = function() {
			var startTime = 0; // Tracks last start or resume time
			var lapTime = 0; // Tracks time when clock was last stopped
			var currentTime = function() {
				return (new Date()).getTime();
			};
			this.start = function() {
				startTime = startTime ? startTime : currentTime();
			};
			this.stop = function() {
				// If timer is running, lapTime will get updated otherwise
				// retain it
				lapTime = startTime ? lapTime + currentTime() - startTime
						: lapTime;
				startTime = 0; // Paused
			};
			this.reset = function() {
				lapTime = startTime = 0;
			};
			this.time = function() {
				return lapTime + (startTime ? currentTime() - startTime : 0);
			};
		};
		cmp.priv_stopWatchTracker = new cmp.priv_stopWatch();
		helper.displayAndSetTimer(cmp);
	}
})