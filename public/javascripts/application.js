// Add images to editor
function add_images()
{
	$(".galleria-thumbnails .galleria-image img").each(function(){
	    $(this).dblclick(function(){
	      image_operations({ element: this, title: 'Add image', text: 'Would you like to add this image to the page?' })
	    });
	});
}

function remove_uploaded()
{
	$("p.fields").each(function() {
	   if ( $(this).children("input:first").val() != "" )
	    $(this).remove();
	});
}

// Add documents to editor

function add_documents()
{
	$("#documents a").each(function(){
	    $(this).click(function(){
	        document_operations({ element: this, title: 'Add document', text: 'Would you like to add this document to the page?' } );
	        return false;
	    });
	});
}

// Keywords box functions

function existing_keywords()
{
	$('#tag_list').children().each(function(){
		$(this).dblclick(function(){
		    delete_confirmation_dialog({ 
																			element: 	this, 
																			title: 		'Delete tag from tag list', 
																			text: 		'Are you sure you want to delete ' + this.value + ' from your tag list?', 
																			onsuccess: 'keyword_list' 
																		});
		});
	});
}

function add_keywords()
{
	$('#keyword_button').click(function(){
  		$('#keyword_input').html(function() {
  				if (this.value != '')
  				{
  					$('#tag_list').append('<option class="tag">' + this.value + '</option>');
						$("#tag_list").children(":last").dblclick	(function(){
								delete_confirmation_dialog({ 	element: 	this, 
																							title: 		'Delete tag from tag list', 
																							text: 		'Are you sure you want to delete ' + this.value + ' from your tag list?', 
																							onsuccess: 'keyword_list' 
																						});
							});
						keyword_list();
						this.value = '';
  				}
  			});
  	});
}

function keyword_list()
{	
	var keywords = "";
	$("#tag_list option").each(function(){
	    if ( keywords == "")
	        keywords = this.value;
	    else
	        keywords = keywords + ", " + this.value;
	});
	
	$("#final_tag_list")[0].value = keywords;
}

// Dialog box functions

function delete_confirmation_dialog( params )
{
	element = '<div id="dialog-confirm" title="' + params.title + '"><p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>';
	element	+= params.text + '</p></div>';

	$("#main").append(element);
	
	$(function() {
			// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
			$("#dialog").dialog("destroy");

			$("#dialog-confirm").dialog({
				resizable: false,
				modal: true,
				dialogClass: 'alert',
				buttons: {
					'Delete': function() {
						$(this).dialog('close');
						$(params.element).remove();
						eval(params.onsuccess + '()');
						$(this).remove();
					},
					Cancel: function() {
						$(this).dialog('close');
						$(this).remove();
					}
				}
			});
	});
}

function image_operations( params )
{
	element  = '<div id="dialog-pictures" title="' + params.title + '"><p><span class="ui-icon ui-icon-image" style="float:left; margin:0 7px 20px 0;"></span>';
	element += params.text + '</p></div>';
	$("#main").append(element);
	
	$(function() {
			// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
			$("#dialog").dialog("destroy");

			$("#dialog-pictures").dialog({
				resizable: false,
				modal: true,
				dialogClass: 'info',
				buttons: {
					'Add picture to page': function() {
						$(this).dialog('close');
						$("body", $("iframe").contents()).append("<br /><img src=\"" + params.element.src.replace(/squared/, 'medium' ) +  "\" />");
						$(this).remove();
					},
					Cancel: function() {
						$(this).dialog('close');
						$(this).remove();
					}
				}
			});
	});	
}


function document_operations( params )
{
	element = '<div id="dialog-documents" title="' + params.title + '"><p><span class="ui-icon ui-icon-document" style="float:left; margin:0 7px 20px 0;"</span>';
	element += params.text + '</p></div>';
	$("#main").append(element);
	
	$(function() {
			// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
			$("#dialog").dialog("destroy");

			$("#dialog-documents").dialog({
				resizable: false,
				modal: true,
				dialogClass: 'info',
				buttons: {
					'Add picture to page': function() {
						$(this).dialog('close');
						$("body", $("iframe").contents()).append("<a href=\"" + params.element.href + "\">" + params.element.innerHTML + "</a>");
						$(this).remove();
					},
					Cancel: function() {
						$(this).dialog('close');
						$(this).remove();
					}
				}
			});
	});
}

// nested models

$(function() {
  $('form a.add_child').click(function() {
    var association = $(this).attr('data-association');
    var template 		= $('#' + association + '_fields_template').html();
    var regexp 			= new RegExp('new_' + association, 'g');
    var new_id 			= new Date().getTime();

    $(this).parent().before(template.replace(regexp, new_id));
    return false;
  });

  $('form a.remove_child').live('click', function() {
    var hidden_field = $(this).prev('input[type=hidden]')[0];
    if(hidden_field) {
      hidden_field.value = '1';
    }
    $(this).parents('.fields').hide();
    return false;
  });
});

// button methods

function submit_button()
{
	$('.submit').button( { icons: { primary: 'ui-icon-circle-check' } } ).click(function() {
  		$('.form').submit();
  	});
}
