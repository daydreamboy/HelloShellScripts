#!/usr/bin/env bash

echo "This is bash!"

/usr/bin/ruby <<EOF

puts 'This is ruby!'

def dump_object(arg)
  puts "[Debug] (#{arg.class}) #{arg.inspect}"
end

dump_object("a")

EOF

