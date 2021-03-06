require 'test/blueprints'
require 'import_sample_data'

['Admin', 'Sales'].each do |group_name|
  Group.make(:name => group_name)
end

User.make_admin
User.make_local_admin

Admin.make_default_settings

Chart.names.each do |name|
  Chart.make :name => name
end
