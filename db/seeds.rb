require 'test/blueprints'

['Admin', 'Sales'].each do |group_name|
  Group.make(:name => group_name)
end

User.make_admin
