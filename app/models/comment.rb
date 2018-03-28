class Comment < ApplicationRecord
  include ActionView::Helpers::TextHelper
  belongs_to :week
  belongs_to :user

  validates :body, presence: true

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
