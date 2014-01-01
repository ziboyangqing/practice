/*SimpleMediaPlayer*/
package com.smp {

    public class JsProxy {

        protected var tag:XML;

        public function JsProxy(){
            this.tag = <tag><![CDATA[
		


(function(window) {
	if (typeof window.CMP == "undefined") {
		var document = window.document;
		var body = document.body;
		var msie = /msie/.test(navigator.userAgent.toLowerCase());
		var DIV = document.createElement("div");
		if (msie) {
			body.insertBefore(DIV, body.firstChild);
		} else {
			body.appendChild(DIV);
		}
		DIV.id = "DIV_CMP";
		DIV.style.width = "0px";
		DIV.style.height = "0px";
		DIV.style.overflow = "hidden";
		DIV.style.visibility = "hidden";
		DIV.style.position = "absolute";
		var WMP = function() {
		};
		WMP.prototype = {
			id : "WMP_CMP",
			ec : 0,
			ts : "stopped",
			t1 : 0,
			t2 : 0,
			bp : 0,
			dp : 0,
			wmp : null,
			WMP : null,
			ready : false,
			finish : false,
			init : function() {
				if (!this.wmp) {
					this.wmp = document.createElement("object");
					this.wmp.id = this.id;
					if (msie) {
						this.wmp.classid = "clsid:6BF52A52-394A-11d3-B153-00C04F79FAA6";
					} else {
						this.wmp.type = "application/x-ms-wmp";
					}
					DIV.appendChild(this.wmp);
				}
				this.ready = false;
				this.WMP = document.getElementById(this.id);
				if (this.WMP) {
					try {
						this.WMP.controls.currentPosition = 0;
						this.WMP.settings.playCount = 1;
						this.ready = true;
					} catch (e) {
					}
				}
			},
			load : function(url) {
				if (!this.ready) {
					this.init();
				}
				if (this.ready) {
					this.finish = false;
					this.WMP.error.clearErrorQueue();
					this.WMP.URL = url;
				} else {
					this.finish = true;
				}
			},
			play : function() {
				if (this.ready) {
					this.WMP.controls.play();
				}
			},
			pause : function() {
				if (this.ready) {
					this.WMP.controls.pause();
				}
			},
			stop : function() {
				if (this.ready) {
					this.WMP.controls.stop();
					this.WMP.error.clearErrorQueue();
				}
			},
			seek : function(p) {
				if (this.ready) {
					this.WMP.controls.currentPosition = p;
				}
			},
			volume : function(a) {
				if (this.ready) {
					this.WMP.settings.volume = a[0];
					this.WMP.settings.balance = a[1];
				}
			},
			status : function() {
				if (this.ready) {
					this.ec = this.WMP.error.errorCount;
					this.ts = this.getState(this.WMP.playState);
					this.t1 = this.WMP.controls.currentPosition;
					this.t2 = this.WMP.currentMedia.duration;
					this.bp = this.WMP.network.bufferingProgress;
					this.dp = this.WMP.network.downloadProgress;
				}
				if (this.t2 > 0 && this.dp == 100 && this.t1 > this.t2 - 1) {
					this.finish = true;
				}
				return [this.ec, this.ts, this.t1, this.t2, this.bp, this.dp, this.finish];
			},
			getState : function(n) {
				switch (n) {
				case 1:
					return "stopped";
					break;
				case 2:
					return "paused";
					break;
				case 3:
					return "playing";
					break;
				case 6:
					return "buffering";
					break;
				case 8:
					return "completed";
					break;
				default:
					return "connecting";
				}
			},
			error : function() {
				if (this.ready) {
					var max = this.WMP.error.errorCount;
					if (max > 0) {
						return this.WMP.error.item(max - 1).errorDescription;
					}
				}
				return null;
			},
			info : function() {
				if (this.ready) {
					var info = {};
					var cm = this.WMP.currentMedia;
					var an = cm.attributeCount;
					for ( var i = 0; i < an; i++) {
						var k = cm.getAttributeName(i);
						var p = k.replace(/[^A-Za-z0-9_]/g, "");
						info[p] = cm.getItemInfo(k);
					}
					return info;
				}
				return null;
			}
		};
		var CMP = function() {
			this.wmp = new WMP();
			this.player = this.wmp;
		};
		CMP.prototype = {
			DIV : DIV,
			wmp : null,
			player : null,
			load : function(url) {
				this.player.load(url);
			},
			play : function() {
				this.player.play();
			},
			pause : function() {
				this.player.pause();
			},
			stop : function() {
				this.player.stop();
			},
			seek : function(p) {
				this.player.seek(p);
			},
			volume : function(a) {
				this.player.volume(a);
			},
			status : function() {
				return this.player.status();
			},
			error : function() {
				return this.player.error();
			},
			info : function() {
				return this.player.info();
			},
			image : function(url) {
				var IMG = document.createElement("img");
				IMG.src = url;
				DIV.appendChild(IMG);
			},
			execute : function(str) {
				try {
					eval(str);
				} catch (e) {
				}
			}
		};
		window.CMP = new CMP();
	}
})(window);



		
		]]></tag>
            ;
            super();
        }
    }
}
