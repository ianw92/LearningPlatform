require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'timer created after user is created' do
    user = users(:one)
    assert Timer.find_by(user_id: user.id).exists?
  end
end
