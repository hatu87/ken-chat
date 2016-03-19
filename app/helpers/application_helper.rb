module ApplicationHelper
  def primary_color
    signed_in? ? 'teal' : 'white'
  end

  def nav_text_color
    signed_in? ? 'white-text' : ''
  end

  def unread_style(message)
    # binding.pry
    message.read_at ? '' : 'unread-message'
  end


end
