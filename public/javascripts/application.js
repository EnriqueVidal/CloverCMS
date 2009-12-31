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

function addKeyWord(element)
{
  var option = document.createElement("option");
  var tag_list = $('page_tag_list');

  option.innerHTML   = element.value;
  tag_list.value    += ( tag_list.value.replace(/^\s*/, "").replace(/\s*$/, "") != "" ) ? ', ' + element.value : element.value;

  $('page_tag_list_visuals').appendChild(option);
  element.value = '';
}

