require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  test 'should disallow deletion if users have membership in group' do
    group = Group.make(:name => 'asdf')
    user = User.make
    user.groups << group
    group.destroy
    assert_equal 0, UserGroup.count
  end

end
