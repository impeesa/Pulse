require 'test/blueprints'

['Admin', 'Sales'].each do |group_name|
  Group.make(:name => group_name)
end

User.make_admin

Chart.names.each do |name|
  Chart.make :name => name
end
