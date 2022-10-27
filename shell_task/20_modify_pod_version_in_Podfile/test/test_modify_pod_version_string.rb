#!/usr/bin/env ruby

pod_change_list = [
  {
    :pod_name => 'SomePod1',
    :pod_version => '3.5.1'
  },
  {
    :pod_name => 'SomePod2',
    :pod_version => '3.5.2'
  },
  {
    :pod_name => 'SomePod3',
    :pod_version => '3.5.3'
  },
  {
    :pod_name => 'SomePod4',
    :pod_version => '3.5.4'
  },
  {
    :pod_name => 'SomePod5',
    :pod_version => '3.5.5'
  },
  {
    :pod_name => 'SomePod6',
    :pod_version => '3.5.6'
  },
  {
    :pod_name => 'SomePod7',
    :pod_version => '3.5.7'
  },
  {
    :pod_name => 'SomePod8',
    :pod_version => '3.5.8'
  },
  {
    :pod_name => 'SomePod9',
    :pod_version => '3.5.9'
  }
]

def test_change_pod(pod_change_list)
  pod_change_list.each do |map|
    file_path = File.expand_path('../Podfile1.txt')

    pod_name = map[:pod_name]
    pod_version = map[:pod_version]

    command = "sh ../modify_pod_version_string.sh #{pod_name} #{pod_version} #{file_path}"
    puts "run command: #{command}"
    `#{command}` # also use system command
    if $?.to_i != 0
      raise 'run shell failed'
    end
  end
end

def test_change_pod_with_subpod(pod_change_list)
  pod_change_list.each do |map|
    file_path = File.expand_path('../Podfile2.txt')

    pod_name = map[:pod_name]
    pod_version = map[:pod_version]

    command = "sh ../modify_pod_version_string.sh #{pod_name} #{pod_version} #{file_path}"
    puts "run command: #{command}"
    `#{command}` # also use system command
    if $?.to_i != 0
      raise 'run shell failed'
    end
  end
end

test_change_pod(pod_change_list)
test_change_pod_with_subpod(pod_change_list)
