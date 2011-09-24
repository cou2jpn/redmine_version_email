class VersionMailer < Mailer

  def version_added(version)
    project = version.project
    wiki_url = url_for(:controller => 'wiki', :action => 'show', :project_id => project, :id => version.wiki_page_title) unless version.wiki_page_title.blank?
    redmine_headers 'Project' => project,
                    'author' => User.current,
                    'version-added' => version
    set_language_if_valid User.current.language
    # send to members permitted :view_issues.
    recipients project.members.collect {|m| m.user}.select {|user| user.allowed_to?(:view_issues, project)}.collect {|u| u.mail}
    subject "[#{project.name}: #{l(:label_version)}] #{version.name}"
    body :project => project,
         :version => version,
         :version_url => url_for(:controller => 'versions', :action => 'show', :id => version),
         :wiki_url => wiki_url
    render_multipart('version_added', body)
  end

  def version_updated(version)
    project = version.project
    wiki_url = url_for(:controller => 'wiki', :action => 'show', :project_id => project, :id => version.wiki_page_title) unless version.wiki_page_title.blank?
    redmine_headers 'Project' => project,
                    'author' => User.current,
                    'version-modified' => version
    set_language_if_valid User.current.language
    # send to members permitted :view_issues.
    recipients project.members.collect {|m| m.user}.select {|user| user.allowed_to?(:view_issues, project)}.collect {|u| u.mail}
    subject "[#{project.name}: #{l(:label_version)}] #{version.name}"
    body :project => project,
         :version => version,
         :effective_date_old => version.effective_date_was.blank? ? l(:label_none) : format_date(version.effective_date_was),
         :effective_date_new => version.effective_date.blank? ? l(:label_none) : format_date(version.effective_date),
         :version_url => url_for(:controller => 'versions', :action => 'show', :id => version),
         :wiki_url => wiki_url
    render_multipart('version_updated', body)
  end

end

