require 'test/unit'
require 'fileutils'

$: << File.expand_path(File.join(File.dirname(__FILE__), '../lib'))

require File.join(File.dirname(__FILE__), '../lib/sheller')
