#!/usr/bin/env tclsh

if {$argc != 1} {
    puts stderr "Usage: $argv0 PortIndex"
    exit
}

set fd [open [lindex $argv 0] r]

set vars {}
while {[gets $fd line] >= 0} {
    set name [lindex $line 0]
    set len [lindex $line 1]
    set line [read $fd $len]

    set swx 1
    foreach item $line {
        if {$swx} {
            lappend vars $item
        }
        set swx [expr !$swx]
    }
}

set vars [lsort -unique $vars]

puts $vars
