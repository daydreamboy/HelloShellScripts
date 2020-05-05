#!/usr/bin/ruby
# -*- coding: UTF-8 -*-
#
# Get all targets' name from a .xcodeproj file
#
# Usage:
#		ruby get_all_targets.rb <path/to/.xcodeproj file>

require 'xcodeproj'

arg0 = ARGV[0]
xcodeproj_path = File.join(arg0)

project = Xcodeproj::Project.open(xcodeproj_path)
project.targets.each do |target|
	puts target
end