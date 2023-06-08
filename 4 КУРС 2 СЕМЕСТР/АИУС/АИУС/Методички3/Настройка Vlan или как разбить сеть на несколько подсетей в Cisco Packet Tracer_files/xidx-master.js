var xidx = {};
xidx.uid = 1376300955104;
xidx.pjs = document.getElementsByTagName('script')[0];
xidx.prot = 'https:' == window.location.protocol?'https':'http';
xidx.cb = function(pid, cid) {this.get(this.prot + '://code.xidx.org/partner.gif?uid='+this.uid+'&pid='+pid+'&id='+cid, 0, this);}
xidx.get = function(url, t, self, callback) {
	if (!self)self=this;
	if (t) {
		var s = document.createElement('script');
		s.charset='UTF-8'; s.async = true;
		s.src = url; self.pjs.parentNode.insertBefore(s, self.pjs);

		if (typeof callback == "function") {
			var called = false;
			s.onreadystatechange = function() {
				if (this.readyState == "complete" && !called) {
					called = true;
					callback();
				}
			};
			s.onload = function() {
				if (!called) {
					called = true;
					callback();
				}
			};
		}
	} else
		new Image().src = url;
}
xidx.get(xidx.prot+"://counter.yadro.ru/hit;PLUSO?r"+escape(document.referrer)+((typeof(screen)=="undefined")?"":";s"+screen.width+"*"+screen.height+"*"+(screen.colorDepth?screen.colorDepth:screen.pixelDepth))+";u"+escape(document.URL)+";h"+escape(document.title.substring(0,80))+";1",0);

_tmr = (typeof _tmr=="undefined"?[]:_tmr);
_tmr.push({id: '2378666', type: 'pageView', start: (new Date()).getTime()});
xidx.get(xidx.prot + "://top-fwz1.mail.ru/js/code.js", 1);
xidx.get(xidx.prot + "://static.facetz.net/collect.js", 1, null, function(){loadFacetzCollector("pluso", xidx.uid);});
