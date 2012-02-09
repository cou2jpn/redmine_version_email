module VersionNotifiablePatch
  def self.included(base) # :nodoc:
    @is_version_wrap = false
    base.extend NotifiableMethods
    base.class_eval do
      unloadable
      class << self
        if !@is_version_wrap
          alias_method_chain :all, :version_updates
          @is_version_wrap = true
        end
      end
    end
  end
end

module NotifiableMethods
  def all_with_version_updates
    notifications = all_without_version_updates
    notifications << Redmine::Notifiable.new('version_added')
    notifications << Redmine::Notifiable.new('version_updated')
    notifications
  end
end


Redmine::Notifiable.send(:include, VersionNotifiablePatch)
