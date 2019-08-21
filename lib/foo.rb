require 'yaml'
# require 'ostruct'

class Berth
  attr_accessor :id, :boss, :name, :fo, :terminal, :ipp #, :name, :nabor_sborov

  # def initialize id #, name, nabor_sborov
  #   # @id = id
  #   # @ipp = self.ipp
  #   # @name = name
  #   # @nabor_sborov = nabor_sborov
  #   #    @terminal = OpenStruct.new({foo: 1, bar: 2})
  #   @terminal = "xxx"
  # end

  # def initialize (grade)

# .fo.each do |k, v|
#   Berth.class_eval("def #{k};'#{v}';end")
#   # puts "#{k}  #{v}"
# end

    
  def self.find id
    #database opration to retrieve data. We'll simulate it for now.
    berth = BERTHS.find { |berth| berth.id == id }
  end

  def self.my_attr_accessor(*args)
    # iterate through each passed in argument...
    args.each do |arg|
      # getter
      self.class_eval("def #{arg};@#{arg};end")
      # setter
      self.class_eval("def #{arg}=(val);@#{arg}=val;end")
    end
  end

end

BERTHS = []
$/="\n\n"

file = File.join(File.expand_path(File.dirname(__FILE__)), "berth.yaml")
File.open(file, "r").each do |object|
  BERTHS << YAML::load(object)
end

# BERTHS = YAML.load(File.read("berth.yaml"))

#puts BERTHS.inspect
foo = Berth.find(1)
puts foo.boss
puts foo.name

# puts foo.ipp.inspect

# foo.fo.each do |k, v|
#   puts "#{k}  #{v}"
# end

#instead of fo here take value from ARGV[1].to_s

foo.fo.each do |k, v|
  Berth.class_eval("def #{k};'#{v}';end")
  # puts "#{k}  #{v}"
end

puts foo.cargo_grade
puts foo.cargo_quantity


# Berth.my_attr_accessor(foo.fo)

#puts foo.ipp.inspect            

# BERTHS = [
#   Berth.new(
#   1,
#   "Sheskharis 1",
#   [1,2,3,4,5,6,7,8,9,10,11,12,16,17,18,19,20,21,22] # array of sbor_id
# ),
#   Berth.new(
#     2,
#     "Sheskharis 2",
#     [1,2,3,4,5,6,7,8,9,10,11,12,16,17,18,19,20,21,22]
#   ),
#   Berth.new(
#     3,
#     "IPP 26/27",
#     [1,2,3,4,5,6,7,8,9,10,12,15,16,17,18,19,21,22]
#   ),
# ]


# require 'yaml'

# File.open("berth.yaml", "w") do |file|
#   BERTHS.each do |berth|
#     file.puts YAML::dump(berth)
#     file.puts ""
#   end
# end
