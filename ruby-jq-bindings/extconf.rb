#!/usr/bin/env ruby

require 'mkmf'

abort 'libjq not found' unless have_library('jq')

create_makefile 'foobar'
