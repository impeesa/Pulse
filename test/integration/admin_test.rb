require 'test_helper'

class AdminTest < ActionController::IntegrationTest

  test 'admin should be able to create groups' do
    login User.make_admin
    visit new_group_path
    fill_in 'Name', :with => 'Sales'
    click_button 'Save'
    assert Group.find_by_name 'Sales'
  end

  test 'admin should be able to select user membership in groups' do
    login User.make_admin
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
    chart = Chart.make
    Group.make(:name => 'Sales')
    visit edit_chart_path(chart)
    check 'Sales'
    click_button 'Save'
    visit chart_path(chart)
    assert_contain 'Sales'
  end

  test 'users#edit disallows non-admin' do
    user = User.make
    login user
    visit edit_user_path(user)
    assert_contain 'You must be an administrator to access this page'
  end

  test 'charts#edit disallows non-admin' do
    user = User.make
    login user
    visit edit_chart_path(Chart.make)
    assert_contain 'You must be an administrator to access this page'
  end

end
