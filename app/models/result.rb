require 'active_support/ordered_hash'

class Result < ActiveRecord::Base

  scope :types, proc { |args| where(:Type => args) }
  scope :terms, proc { |args| where(:Term => args) }
  scope :classes, proc { |args| where(:Class => args) }
  scope :items, proc { |args| where(:Item => args) }
  scope :sections, proc { |args| where(:Section => args) }

  # Hashes for some fields.
  # Key is db value, value is displayed version.
  # Some keys look exactly like the values, but this was intentional in case db values change.
  def self.terms_hash
    @terms ||= ordered_hash([
      ['CMTD', 'Month To Date'],
      ['CYQT', 'Quarter to Date'],
      ['CYTD', 'Year to Date'],
    ])
  end

  def self.types_hash
    @types ||= ordered_hash([
      ['Actual', 'Actual'],
      ['Plan', 'Plan'],
      ['Prior Year', 'Prior Year'],
    ])
  end

  def self.classes_hash
    @classes ||= ordered_hash([
      ['Domestic', 'Domestic'],
      ['International', 'International'],
      ['Air', 'Air'],
      ['Motorcycle', 'Motorcycle'],
    ])
  end

  # This should probably go in lib/ as ActiveSupport::OrderedHash.initialize().
  def self.ordered_hash(elements)
    o_hash = ActiveSupport::OrderedHash.new
    elements.each do |db_name, display_name|
      o_hash[db_name] = display_name
    end
    o_hash
  end

end
