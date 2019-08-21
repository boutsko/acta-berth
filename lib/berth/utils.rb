require_relative 'meta'

module Foobar
  module Utils

    # Return a directory with the project libraries.
    def self.gem_libdir
      t = ["#{File.dirname(File.expand_path(__FILE__))}",
           "#{File.dirname(File.expand_path($0))}/../lib/#{Meta::NAME}",
           "#{Gem.dir}/gems/#{Meta::NAME}-#{Meta::VERSION}/lib/#{Meta::NAME}"]
      t.each {|i| return i if File.readable?(i) }
      raise "both paths are invalid: #{t}\n"
    end

    # [...]
  end
  
  if __FILE__ == $0
    Foobar::Utils.gem_libdir
  end
end
