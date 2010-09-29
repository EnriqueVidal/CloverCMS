jQuery(function() {
    jQuery(".wymeditor").wymeditor({ classesItems: [
	    	{ 'name': 'date', 				'title': 'PARA: Date', 				'expr': 'p'},
	    	{ 'name': 'hidden-note', 	'title': 'PARA: Hidden note', 'expr': 'p[@class!="important"]'}
	  	],
		logoHtml: '',
		skin: 'compact'
	   });
});
