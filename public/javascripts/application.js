// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

document.observe("dom:loaded", function() {
  // the element in which we will observe all clicks and capture
  // ones originating from pagination links
  var container = $(document.body)

  if (container) {
    var img = new Image
    img.src = '/images/spinner.gif'

    function createSpinner() {
      return new Element('img', { src: img.src, 'class': 'spinner' })
    }

    container.observe('click', function(e) {
      var el = e.element()
      if (el.match('.pagination a')) {
        el.up('.pagination').insert(createSpinner())
        new Ajax.Request(el.href, { method: 'get' })
        e.stop()
      }
    })
  }
})

function checkPresence( field )
{
	var hint = $F( field ).length == 0 ? "Try again!" : "Right on!";

	if ( $( field + '_hint' ) )
	{
		$( field + '_hint' ).update( hint );
	}
	else
	{
		content = '<span class="validation" id="' + field + '_hint">' + hint + '</span>';
		new Insertion.After( field, content );
	}
}

function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).up().insert({
    before: content.replace(regexp, new_id)
  });
}




function showItem(element, trigger)
{
	if (element != null)
		element.show();
	if (trigger != null )
		trigger.hide();
}

function update_hidden_value(text_field, option)
{
	var hidden_field 	= $(text_field).previous('.hidden_for_autocomplete');
	hidden_field.value 	= option.value;
	block_field(tf);
}

function imageAdd(element_id, iframe_id)
{
    var src     = $(element_id).src.split('?')[0];
    var img_tag = document.createElement("img")
    img_tag.src = src;

    $(iframe_id).contentDocument.body.appendChild(img_tag);

}

function documentAdd(element_id, iframe_id)
{
	var href						= $(element_id).href.split('?')[0];
	var extension 			= href.split('.')[ href.split('.').length - 1 ]
	var link_tag				= document.createElement('a');
	var line_break			= document.createElement('br')
	link_tag.href 			= href;
	link_tag.innerHTML 	= $(element_id).innerHTML
		
	link_tag.addClassName('icon');
	link_tag.addClassName(extension);
	
	$(iframe_id).contentDocument.body.appendChild(line_break);
	$(iframe_id).contentDocument.body.appendChild(link_tag);
}

function addKeyWord(element)
{
  var option = document.createElement("option");
  var tag_list = $('page_tag_list');

  option.innerHTML   = element.value;
  tag_list.value    += ( tag_list.value.replace(/^\s*/, "").replace(/\s*$/, "") != "" ) ? ', ' + element.value : element.value;

  $('page_tag_list_visuals').appendChild(option);
  element.value = '';
}

function TogglePageBoxes(box)
{
  for(var i = 0; i < page_boxes.length; i++)
  {
    if (typeof box == 'string')
    {
      if (page_boxes[i] != box)
        $(page_boxes[i]).hide();
    }
    else
    {
      var conditions = "";

      for(var j = 0; j < box.length; j++)
      {
        conditions += (conditions != "") ? " && '" + page_boxes[i] + "' != '" + box[j] + "'" : "'" + page_boxes[i] + "' != '" + box[j] + "'";
      }

      if (eval(conditions)) { $(page_boxes[i]).hide(); }
    }
  }

  if (typeof box == 'string')
    $(box).toggle();
  else
    box.each(Element.toggle);
}

