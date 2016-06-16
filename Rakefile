#!/usr/bin/env rake

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

task(:check) { sh('bin/check') }
task(:setup) { sh('bin/setup') }
task default: :check
