require_dependency 'version'

module VersionPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      after_create :version_added
      after_update :version_updated, :if => Proc.new { |p| (p.name_changed? || p.effective_date_changed? || p.status_changed?) }
    end
  end
  module InstanceMethods
    def version_added
      VersionMailer.version_added(self).deliver if Setting.notified_events.include?('version_added')
    end
    def version_updated
      VersionMailer.version_updated(self).deliver if Setting.notified_events.include?('version_updated')
    end
  end
end

