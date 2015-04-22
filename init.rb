Redmine::Plugin.register :redmine_version_email do
  name 'Redmine Version Email plugin'
  author 'cou2jpn'
  description 'This is a plugin for Redmine that sends version email on update.'
  version '3.0.0'
  requires_redmine :version_or_higher => '3.0.0'
end

ActionDispatch::Callbacks.to_prepare do
  require 'version_patch'
  require 'version_notifiable_patch'
  Version.send(:include, VersionPatch)
end

