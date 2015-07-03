module Deliver
  class DownloadScreenshots
    def self.run(app, path)
      begin
        Helper.log.info "Downloading all existing screenshots...".green
        download(app, path)
        Helper.log.info "Successfully downloaded all existing screenshots".green
      rescue Exception => ex
        Helper.log.error ex
        Helper.log.error "Couldn't download already existing screenshots from iTunesConnect.".red
      end
    end

    def self.download(app, folder_path)
      languages = JSON.parse(File.read(File.join(Helper.gem_path('spaceship'), "lib", "assets", "languageMapping.json")))
      v = app.spaceship_ref.latest_version

      v.screenshots.each do |language, screenshots|
        screenshots.each do |screenshot|
          file_name = [screenshot.sort_order, screenshot.device_type, screenshot.original_file_name].join("_")
          Helper.log.info "Downloading existing screenshot '#{file_name}' of device type: '#{screenshot.device_type}'"

          containing_folder = File.join(folder_path, "screenshots", screenshot.language.to_language_code)
          FileUtils.mkdir_p containing_folder rescue nil # if it's already there
          path = File.join(containing_folder, file_name)
          File.write(path, open(screenshot.url).read)
        end
      end
    end
  end
end