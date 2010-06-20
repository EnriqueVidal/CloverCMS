class Snippet < ActiveRecord::Base
  belongs_to :snippetable, :polymorphic => true
  validates_presence_of :snippetable_id, :snippetable_type, :lang, :code
end
