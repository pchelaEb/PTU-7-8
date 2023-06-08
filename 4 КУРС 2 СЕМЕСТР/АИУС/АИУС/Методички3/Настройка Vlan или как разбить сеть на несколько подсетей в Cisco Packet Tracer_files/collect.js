function loadFacetzCollector(source_name, id) {
    var host = "front.facetz.net";
    var imgUrl =  "//" + host + "/collect?source=" + encodeURIComponent(source_name) + "&id=" + encodeURIComponent(id) + "&previous_url=" + encodeURIComponent(document.referrer) + "&rn=" + Math.random();
    var img = new Image();
    img.src = imgUrl;
    img.onload = function() { return; }
}

