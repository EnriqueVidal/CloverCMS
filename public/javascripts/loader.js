function loadJsFiles(){
	//var jsFilesToLoad = new Array("jquery-1.4.2.min.js","dd_belatedpng.js","jquery.pngFix.js","myScript.js");
	var jsFilesToLoad = new Array("dd_belatedpng.js","myScript.js");
	
	for (file in jsFilesToLoad){
		document.write('<script src="/javascripts/' + jsFilesToLoad[file] + '"><\/script>');
	}
}

loadJsFiles();

