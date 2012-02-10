require 'dispatcher'
require 'redmine'
require 'version_patch'
require 'version_notifiable_patch'

Redmine::Plugin.register :redmine_version_email do
  name 'Redmine Version Email plugin'
  author 'cou2jpn'
  description 'This is a plugin for Redmine that sends version email on update.'
  version '1.3.2'
  requires_redmine :version_or_higher => '1.3.0'
end

Dispatcher.to_prepare do
  Version.send(:include, VersionPatch)
end

