module Fastlane
  module Actions
    # Adds a hg tag to the current commit
    class HgAddTagAction < Action
      def self.run(options)
        tag = options[:tag]

        Helper.log.info "Adding mercurial tag '#{tag}' 🎯."
        Actions.sh("hg tag \"#{tag}\"")
      end

      def self.description
        "This will add a hg tag to the current branch"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :tag,
                                       env_name: "FL_HG_TAG_TAG",
                                       description: "Tag to create",
                                       optional: false)
        ]
      end

      def self.author
        # credits to lmirosevic for original git version
        "sjrmanning"
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
