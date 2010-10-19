require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'find authorized by id' do
    user = User.make
    assert_equal user, User.find_authorized_by_id_or_email!(user.id)
  end

  test 'find authorized by email' do
    user = User.make
    assert_equal user, User.find_authorized_by_id_or_email!(user.email)
  end

  test 'find by authorized raises exception if not found' do
    assert_raise(User::NotFound) do
      User.find_authorized_by_id_or_email!(1)
    end
  end

  test 'find authorized raises exception if not allowed to login' do
    user = User.make(:allowed_to_login => false)
    assert_raise(User::Locked) do
      User.find_authorized_by_id_or_email!(user.id)
    end
  end

end
