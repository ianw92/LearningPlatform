class Comment < ApplicationRecord
  include ActionView::Helpers::TextHelper
  belongs_to :week
  belongs_to :user

  validates :body, presence: true

  def edited
    if created_at != updated_at
      return true
    else
      return false
    end
  end

  def time_since_created
    return time_since('created')
  end

  def time_since_updated
    return time_since('updated')
  end

  private
  def time_since(updated_or_created)
    if updated_or_created == 'updated'
      time_since_x = (Time.now - self.updated_at)
    else
      time_since_x = (Time.now - self.created_at)
    end

    mm, ss = time_since_x.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)

    if time_since_x < 60
      time_since_x = pluralize(ss.to_i, 'second') + " ago"
    elsif time_since_x < 60*60
      time_since_x = pluralize(mm, 'minute') + " ago"
    elsif time_since_x < 60*60*24
      time_since_x = pluralize(hh, 'hour') + " ago"
    else
      time_since_x = pluralize(dd, 'day') + " ago"
    end
  end
end
