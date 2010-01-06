#---
# Excerpted from "Advanced Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_arr for more book information.
#---

class ValidatingFormBuilder < ActionView::Helpers::FormBuilder
  
  helpers = field_helpers +
           %w(date_select datetime_select time_select) -
           %w(hidden_field label fields_for)
           
  helpers.each do |name|
   define_method(name) do |field, *args|
     options = args.last.is_a?(Hash) ? args.pop : {}

     if %w(text_field password_field).include?(name) && required_field?(field)
       options[:onblur] = "checkPresence('#{field_name(field)}')"
     end

     @template.content_tag(:p,
                           label(field, label_text(field)) + " " +
                           super(field, options))
   end
  end

private

  def field_name(field)
   "#{@object_name.to_s.underscore}_#{field.to_s.underscore}"
  end

  def label_text(field)
    "#{field.to_s.humanize}#{required_mark(field)}"
  end

  def required_mark(field)
    required_field?(field) ? ' <span class="required">*</span>' : ''
  end

  def required_field?(field)
    @object_name.to_s.camelize.constantize.
                 reflect_on_validations_for(field).
                 map(&:macro).include?(:validates_presence_of)
  end
end

