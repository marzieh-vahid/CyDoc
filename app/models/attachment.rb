# -*- encoding : utf-8 -*-
class Attachment < ActiveRecord::Base
  # Access restriction
  attr_accessible :title, :file, :code, :object_id, :object_type

  # Association
  belongs_to :object, :polymorphic => true

  # Carrier Wave
  validates_presence_of :file
  mount_uploader :file, AttachmentUploader

  # String
  def to_s(format = :default)
    title == nil ? "" : title
  end

  def code(format = :db)
    # TODO: should probably use Law model.
    raw = read_attribute(:code)

    case format
      when :text
        raw.present? ? I18n::translate(raw, :scope => 'activerecord.attributes.attachment.code_enum') : ""
      else
        raw
    end
  end

  # Lookup attachment for class
  #
  # Returns attachment with code set to the name of the klass. Walks the inheritance
  # tree upwards to look for defaults.
  def self.for_class(klass)
    if attachment = find_by_code(klass.name)
     return attachment
   end

    while klass = klass.superclass do
      if attachment = find_by_code(klass.name)
        return attachment
      end
    end
  end

  before_save :create_title
  private
  def create_title
    self.title = file.filename if title.blank?
  end
end
