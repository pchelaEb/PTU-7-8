var _tmr=_tmr||[];
(function(){function r(a,b){return function(){a&&a();b&&b()}}function d(){}if("[object Array]"===Object.prototype.toString.call(_tmr)){var e=window,h=navigator,b=document,f,g;loadstart=[];d.prototype.pageView=function(a){f="referrer"in a?a.referrer:b.referrer;"start"in a&&loadstart.push(a);var k=0,c=0;if("number"==typeof e.innerWidth)k=e.innerWidth,c=e.innerHeight;else if(b.documentElement&&(b.documentElement.clientWidth||b.documentElement.clientHeight))k=b.documentElement.clientWidth,c=b.documentElement.clientHeight;
else if(b.body&&(b.body.clientWidth||b.body.clientHeight))k=b.body.clientWidth,c=b.body.clientHeight;var d="ontouchstart"in e||"onmsgesturechange"in e||h.msMaxTouchPoints&&0<h.msMaxTouchPoints?"1":"0",m=e.devicePixelRatio||0,n="";if(h.plugins&&h.plugins["Shockwave Flash"])n=h.plugins["Shockwave Flash"].description.split(" ")[2];else if(e.ActiveXObject)for(var l=10;2<=l;l--)try{if(new ActiveXObject("ShockwaveFlash.ShockwaveFlash."+l)){n=l+".0";break}}catch(p){}(new Image).src=("https:"==b.location.protocol?
"https:":"http:")+"//top-fwz1.mail.ru/counter?id="+a.id+";js=13"+(f?";r="+escape(f):"")+((g=e.screen)?";s="+g.width+"*"+g.height:"")+("url"in a?";u="+escape(a.url):"")+("start"in a&&0<a.start?";st="+a.start:"")+";vp="+k+"*"+c+";touch="+d+";hds="+m+";flash="+n+";_="+Math.random()};d.prototype.reachGoal=function(a){"goal"in a&&(f="referrer"in a?a.referrer:b.referrer,(new Image).src=("https:"==b.location.protocol?"https:":"http:")+"//top-fwz1.mail.ru/tracker?id="+a.id+";js=13"+(a.goal?";e="+escape("RG/"+
a.goal):"")+(f?";r="+escape(f):"")+((g=e.screen)?";s="+g.width+"*"+g.height:"")+("url"in a?";u="+escape(a.url):"")+";_="+Math.random())};d.prototype.processEvent=function(a){if("id"in a&&"type"in a)switch(a.type){case "pageView":this.pageView(a);break;case "reachGoal":this.reachGoal(a)}};d.prototype.push=function(a){this.processEvent(a)};d.prototype.onload=function(){if(0<loadstart.length){for(var a=(new Date).getTime(),d=0,c;c=loadstart[d];d++)f="referrer"in c?c.referrer:b.referrer,(new Image).src=
("https:"==b.location.protocol?"https:":"http:")+"//top-fwz1.mail.ru/tracker?id="+c.id+";js=13;e="+escape("RT/load")+(f?";r="+escape(f):"")+((g=e.screen)?";s="+g.width+"*"+g.height:"")+";st="+c.start.toString()+";et="+a+("url"in c?";u="+escape(c.url):"")+";_="+Math.random();loadstart=[]}};for(var m=new d,p=0,q;q=_tmr[p];p++)m.processEvent(q);_tmr=m;if("complete"==b.readyState)_tmr.onload();else window.onload=r(window.onload,_tmr.onload)}})();

