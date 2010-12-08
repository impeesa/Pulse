require 'test_helper'

class AdminTest < ActionController::IntegrationTest

  test 'admin should be able to create groups' do
    login User.make(:admin)
    visit new_group_path
    fill_in 'Name', :with => 'Sales'
    click_button 'Save'
    assert Group.find_by_name 'Sales'
  end

  test 'admin should be able to select user membership in groups' do
    login User.make(:admin)
    user = User.make
    Group.make(:name => 'Sales')
    visit edit_user_path(user)
    check 'Sales'
    click_button 'Save'
    visit user_path(user)
    assert_contain 'Sales'
  end

  test 'admin should be able to select chart membership in groups' do
    login User.make_admin
    Group.make(:name => 'Sales')
    visit edit_chart_
  end

end
