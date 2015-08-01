require "fastlane_core"
require "credentials_manager"

module Gym
  class Options
    def self.available_options
      return @options if @options

      workspace = Dir["./*.xcworkspace"]
      if workspace.count > 1
        puts "Select Workspace: "
        workspace = choose(*(workspace))
      else
        workspace = workspace.first # this will result in nil if no files were found
      end

      project = Dir["./*.xcodeproj"]
      if project.count > 1
        puts "Select Project: "
        project = choose(*(project))
      else
        project = project.first # this will result in nil if no files were found
      end

      @options ||= plain_options(project: project, workspace: workspace)
    end

    def self.plain_options(project: nil, workspace: nil)
      [
        FastlaneCore::ConfigItem.new(key: :workspace,
                                     short_option: "-w",
                                     env_name: "GYM_WORKSPACE",
                                     optional: true,
                                     description: "Path the workspace file",
                                     default_value: workspace,
                                     verify_block: proc do |value|
                                       raise "Workspace file not found at path '#{File.expand_path(value)}'" unless File.exist?(value.to_s)
                                       raise "Workspace file invalid" unless File.directory?(value.to_s)
                                       raise "Workspace file is not a workspace, must end with .xcworkspace" unless value.end_with?(".xcworkspace")
                                     end),
        FastlaneCore::ConfigItem.new(key: :project,
                                     short_option: "-p",
                                     optional: true,
                                     env_name: "GYM_PROJECT",
                                     description: "Path the project file",
                                     default_value: project,
                                     verify_block: proc do |value|
                                       raise "Project file not found at path '#{File.expand_path(value)}'" unless File.exist?(value.to_s)
                                       raise "Project file invalid" unless File.directory?(value.to_s)
                                       raise "Project file is not a project file, must end with .xcodeproj" unless value.end_with?(".xcodeproj")
                                     end),
        FastlaneCore::ConfigItem.new(key: :scheme,
                                     short_option: "-s",
                                     optional: true,
                                     env_name: "GYM_SCHEME",
                                     description: "The project scheme. Make sure it's marked as `Shared`",
                                     verify_block: proc do |value|
                                       raise "Project file not found at path '#{File.expand_path(value)}'" unless File.exist?(value.to_s)
                                       raise "Project file invalid" unless File.directory?(value.to_s)
                                     end),
        FastlaneCore::ConfigItem.new(key: :clean,
                                     short_option: "-c",
                                     env_name: "GYM_CLEAN",
                                     description: "Should the project be cleaned before building it?",
                                     is_string: false,
                                     default_value: false),
        FastlaneCore::ConfigItem.new(key: :output_directory,
                                     short_option: "-o",
                                     env_name: "GYM_OUTPUT",
                                     description: "The directory in which the ipa file should be stored in",
                                     default_value: ".",
                                     verify_block: proc do |value|
                                       raise "Directory not found at path '#{File.expand_path(value)}'" unless File.directory?(value)
                                     end),
        FastlaneCore::ConfigItem.new(key: :sdk,
                                     short_option: "-k",
                                     env_name: "GYM_SDK",
                                     description: "The SDK that should be used for building the application",
                                     optional: true)

      ]
    end
  end
end
