jQuery(function() {
    jQuery(".wymeditor").wymeditor({ classesItems: [
				{ 'name': 'ruby', 			'title': 'Ruby Lang', 			'expr': 'pre' },
				{ 'name': 'javascript', 'title': 'Javascript Lang', 'expr': 'pre' }
	  	],
			editorStyles: [
		    { 'name': 'pre', 'css': 'background-color: #FFF; border: 1px solid; font-family: "Bitstream Vera Sans Mono","Monaco","Consolas","Courier New",monospace; font-size: 9pt;' }
		  ],
		logoHtml: '',
		skin: 'compact'
	   });
});
