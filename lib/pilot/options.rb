require "fastlane_core"
require "credentials_manager"

module Pilot
  class Options
    def self.available_options
      @@options ||= [
        FastlaneCore::ConfigItem.new(key: :username,
                                     short_option: "-u",
                                     env_name: "PILOT_USERNAME",
                                     description: "Your Apple ID Username",
                                     default_value: ENV["DELIVER_USER"] || CredentialsManager::AppfileConfig.try_fetch_value(:apple_id),
                                     verify_block: proc do |value|
                                       CredentialsManager::PasswordManager.shared_manager(value)
                                     end),

        FastlaneCore::ConfigItem.new(key: :ipa,
                                     short_option: "-i",
                                     env_name: "PILOT_IPA",
                                     description: "Path to the ipa file to upload",
                                     default_value: Dir["*.ipa"].first,
                                     verify_block: proc do |value|
                                       fail "Could not find ipa file at path '#{value}'" unless File.exist? value
                                       fail "'#{value}' doesn't seem to be an ipa file" unless value.end_with? ".ipa"
                                     end),
        FastlaneCore::ConfigItem.new(key: :skip_submission,
                                     short_option: "-s",
                                     env_name: "PILOT_SKIP_SUBMISSION",
                                     description: "Skip the distributing action of pilot and only upload the ipa file",
                                     is_string: false,
                                     default_value: false),
        FastlaneCore::ConfigItem.new(key: :app_identifier,
                                     short_option: "-a",
                                     env_name: "PILOT_APP_IDENTIFIER",
                                     description: "The bundle identifier of the app to upload or manage testers (optional)",
                                     optional: true,
                                     default_value: ENV["TESTFLIGHT_APP_IDENTITIFER"] || CredentialsManager::AppfileConfig.try_fetch_value(:app_identifier),
                                     verify_block: proc do |_value|
                                     end),
        FastlaneCore::ConfigItem.new(key: :apple_id,
                                     short_option: "-p",
                                     env_name: "PILOT_APPLE_ID",
                                     description: "The unique App ID provided by iTunes Connect",
                                     optional: true,
                                     default_value: ENV["TESTFLIGHT_APPLE_ID"],
                                     verify_block: proc do |_value|
                                     end),
        FastlaneCore::ConfigItem.new(key: :first_name,
                                     short_option: "-f",
                                     env_name: "PILOT_TESTER_FIRST_NAME",
                                     description: "The tester's first name",
                                     optional: true,
                                     verify_block: proc do |_value|
                                     end),
        FastlaneCore::ConfigItem.new(key: :last_name,
                                     short_option: "-l",
                                     env_name: "PILOT_TESTER_LAST_NAME",
                                     description: "The tester's last name",
                                     optional: true,
                                     verify_block: proc do |_value|
                                     end),
        FastlaneCore::ConfigItem.new(key: :email,
                                     short_option: "-e",
                                     env_name: "PILOT_TESTER_EMAIL",
                                     description: "The tester's email",
                                     optional: true,
                                     verify_block: proc do |_value|
                                        raise "Please pass a valid email address" unless _value.include?"@"
                                     end),
        FastlaneCore::ConfigItem.new(key: :testers_file_path,
                                     short_option: "-c",
                                     env_name: "PILOT_TESTERS_FILE",
                                     description: "Path to a CSV file of testers",
                                     default_value: "./testers.csv",
                                     optional: true,
                                     verify_block: proc do |_value|
                                     end)

      ]
    end
  end
end
