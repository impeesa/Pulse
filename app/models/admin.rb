class Admin < ActiveRecord::Base
  DEFAULT_SETTINGS = {
    "site_name" => "Site Name",
    "footer_text" => "Copyright &copy; #{Time.now.year}"
  }

  def self.get_site_name
    find(:first).site_name
  end

  def self.get_footer_text
    find(:first).footer_text
  end

  def self.make_default_settings
    create(:site_name => DEFAULT_SETTINGS["site_name"], 
           :footer_text => DEFAULT_SETTINGS["footer_text"])
  end

  def self.save_settings(attr)
    settings = find(:first)
    settings.update_attributes(attr)
  end
end

