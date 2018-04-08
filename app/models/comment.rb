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
    time_since_created = (Time.now - self.created_at)

    mm, ss = time_since_created.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)

    if time_since_created < 60
      time_since_created = pluralize(ss.to_i, 'second') + " ago"
    elsif time_since_created < 60*60
      time_since_created = pluralize(mm, 'minute') + " ago"
    elsif time_since_created < 60*60*24
      time_since_created = pluralize(hh, 'hour') + " ago"
    else
      time_since_created = pluralize(dd, 'day') + " ago"
    end
  end

  def time_since_updated
    time_since_updated = (Time.now - self.updated_at)

    mm, ss = time_since_updated.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)

    if time_since_updated < 60
      time_since_updated = pluralize(ss.to_i, 'second') + " ago"
    elsif time_since_updated < 60*60
      time_since_updated = pluralize(mm, 'minute') + " ago"
    elsif time_since_updated < 60*60*24
      time_since_updated = pluralize(hh, 'hour') + " ago"
    else
      time_since_updated = pluralize(dd, 'day') + " ago"
    end
  end
end
