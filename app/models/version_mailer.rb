class VersionMailer < Mailer

  def version_added(version)
    @version = version
    @project = @version.project
    @version_url = url_for(:controller => 'versions', :action => 'show', :id => @version)
    @wiki_url = url_for(:controller => 'wiki', :action => 'show', :project_id => @project, :id => @version.wiki_page_title) unless @version.wiki_page_title.blank?
    redmine_headers 'Project' => @project.identifier,
                    'author' => User.current.login,
                    'version-added' => @version.id
    to = @project.users.select {|u| u.mail_notification != 'none' && u.allowed_to?(:view_issues, @project)}

    mail :to => to, :subject => "[#{@project.name}: #{l(:label_version)} #{l(:label_added)}] #{@version.name}"
  end

  def version_updated(version)
    @version = version
    @project = @version.project
    @version_url = url_for(:controller => 'versions', :action => 'show', :id => @version)
    @effective_date_old = @version.effective_date_was.blank? ? l(:label_none) : format_date(@version.effective_date_was)
    @effective_date_new = @version.effective_date.blank? ? l(:label_none) : format_date(@version.effective_date)
    @wiki_url = url_for(:controller => 'wiki', :action => 'show', :project_id => @project, :id => @version.wiki_page_title) unless @version.wiki_page_title.blank?
    redmine_headers 'Project' => @project.identifier,
                    'author' => User.current.login,
                    'version-modified' => @version.id
    to = @project.users.select {|u| u.mail_notification != 'none' && u.allowed_to?(:view_issues, @project)}

    mail :to => to, :subject => "[#{@project.name}: #{l(:label_version)} #{l(:label_modified)}] #{@version.name}"
  end

end

