#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'

program :name, 'dsow2'
program :version, '0.0.1'
program :description, 'Gets facts about AWS account'

command :auth do |c|
  c.syntax = 'dsow2 auth [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Dsow2::Commands::Auth
  end
end

