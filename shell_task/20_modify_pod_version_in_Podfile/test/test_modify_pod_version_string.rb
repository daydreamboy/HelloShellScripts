#!/usr/bin/env ruby

pod_name = 'SomePod1'
pod_version = '3.5.6'
file_path = File.expand_path('../Podfile1.txt')

command = "sh ../modify_pod_version_string.sh #{pod_name} #{pod_version} #{file_path}"
puts "run command: #{command}"
#`#{command}`
system command
if $?.to_i != 0
  raise 'run shell failed'
end