class Setting < ActiveRecord::Base
  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }

 # include BeautifulScaffoldModule
 # before_save :fulltext_field_processing

  # You can OVERRIDE this method used in model form and search form (in belongs_to relation)
  def caption
    (self["name"] || self["label"] || self["description"] || "##{id}")
  end

  def fulltext_field_processing
    # You can preparse with own things here
 #   generate_fulltext_field([])
  end

  def self.permitted_attributes
    return :env,:key,:value,:keyclass,:admin,:global
  end
end
