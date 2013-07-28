# set up rbenv
include_recipe 'rbenv'

# set up god
cligem "god" do
    version node[:god][:version]
end
