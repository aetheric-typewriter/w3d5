require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
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
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        "#{table_name}"
    SQL
  end

  def self.parse_all(results)
    parse = results.map do |params|
      self.new(params)
    end
    parse
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each do |k, v|
      # debugger
      raise "unknown attribute '#{k}'" unless self.class.columns.include?(k.to_sym)
      k_equals = k.to_s + "="
      send(k_equals.to_sym, v)
    end
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
