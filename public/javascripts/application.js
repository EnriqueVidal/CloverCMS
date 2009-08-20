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