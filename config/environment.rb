# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
# place me inside your base controller class
ActionView::Base.field_error_proc = Proc.new do |html_tag, object|
  Rails.logger.debug "==============="
  Rails.logger.debug html_tag
  html = Nokogiri::HTML::DocumentFragment.parse(html_tag)
  tag = html.at_css("input") || html.at_css("textarea")

  unless tag.nil?
    Rails.logger.debug 'is input'
    css_class = tag['class'] || ""
    tag['class'] = css_class.split.push("invalid").join(' ')
    tag = tag.to_s.html_safe
    Rails.logger.debug tag
  else
    tag = html.at_css('label')

    unless tag.nil?
      Rails.logger.debug 'is label'

      tag['data-error'] = object.error_message.join(". ")
      tag = html.to_s.html_safe
      Rails.logger.debug tag
    else
      Rails.logger.debug 'unknown'
    end
  end

  Rails.logger.debug tag
  tag
end
