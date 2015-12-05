module Match
  class Bootstrap
    # Install all the things that are available in the repo
    def run(git_url: nil, keychain: nil)
      git_url = GitHelper.clone(git_url)

      Dir[File.join(git_url, "**", "*.cer")].each do |path|
        Utils.import(path, keychain)
      end

      Dir[File.join(git_url, "**", "*.p12")].each do |path|
        Utils.import(path, keychain)
      end

      Dir[File.join(git_url, "**", "*.mobileprovision")].each do |path|
        FastlaneCore::ProvisioningProfile.install(path)
      end

      Helper.log.info "Successfully installed all keys, certificates and provisioning profiles 🙌".green
    end
  end
end
