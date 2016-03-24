module ActsAsCsv

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods

    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @csv_contents << CsvRow.new(
            Hash[@headers.zip row.chomp.split(', ')]
           )
      end
    end

    attr_accessor :headers, :csv_contents

    def initialize
      read
    end

    def each
      @csv_contents.each {|row| yield row}
    end

  end

end

class RubyCsv
  include ActsAsCsv
  acts_as_csv
end

class CsvRow
  attr_accessor :row_contents
  def initialize(row)
    #p row
    @row_contents = row
  end

  def method_missing name, *args
    key = name.to_s
    @row_contents[key]
  end

end

m = RubyCsv.new
puts m.headers.inspect
m.each{ |csvrow| p csvrow.one}
