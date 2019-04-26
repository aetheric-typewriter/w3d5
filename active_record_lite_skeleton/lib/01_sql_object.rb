require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns

    @columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        "#{table_name}"
    SQL

    @columns = @columns.first.map { |hdr| hdr.to_sym }
  end

  def self.finalize!
    columns.each do |hdr|
      define_method(hdr.to_s) do 
        attributes[hdr]
      end
      define_method("#{hdr}=") do |val|
        attributes[hdr] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name = self.name.tableize if @table_name.nil?
    @table_name
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    @attributes = {} unless @attributes
    @attributes
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
