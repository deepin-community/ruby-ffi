require "fileutils"
# Load the fresh installed ffi release
# First ARGV is a custom Ruby version

ruby_version = nil
if ARGV.first
  ruby_version = ARGV.first
else
  RUBY_MAJOR = RUBY_VERSION.match(/^\d+\.\d+/).to_s
  RUBY_MINOR = RUBY_MAJOR == "1.9" ? "." + RUBY_VERSION.match(/\d+$/).to_s : ''
  ruby_version = "#{RUBY_MAJOR}#{RUBY_MINOR}"
end

paths = ["./debian/libffi-ruby#{ruby_version}/usr/lib/ruby/#{ruby_version}/",
  "./debian/libffi-ruby#{ruby_version}/usr/lib/ruby/#{ruby_version}/#{RUBY_PLATFORM}/"]

paths.each {|i| $:.unshift(i)}

require "./debian/libffi-ruby#{ruby_version}/usr/lib/ruby/#{ruby_version}/ffi"
require "./debian/libffi-ruby#{ruby_version}/usr/lib/ruby/#{ruby_version}/ffi/tools/types_generator"

File.open(File.join("./debian/libffi-ruby#{ruby_version}/usr/lib/ruby/#{ruby_version}/ffi", 'types.conf'),'w') do |f|
  f.puts FFI::TypesGenerator.generate
end
