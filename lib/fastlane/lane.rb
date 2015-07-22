module Fastlane
  # Represents a lane
  class Lane
    attr_accessor :platform

    attr_accessor :name

    # @return [Array] An array containing the description of this lane
    #   Each item of the array is one line
    attr_accessor :description

    attr_accessor :block

    # @return [Boolean] Is that a private lane that can't be called from the CLI?
    attr_accessor :is_private

    def initialize(platform: nil, name: nil, description: nil, block: nil, is_private: false)
      raise "description must be an array" unless description.kind_of?Array
      
      self.platform = platform
      self.name = name
      self.description = description
      self.block = block
      self.is_private = is_private
    end

    # Execute this lane
    def call(parameters)
      block.call(parameters || {})
    end

    # @return [String] The lane + name of the lane. If there is no platform, it will only be the lane name
    def pretty_name
      [platform, name].reject(&:nil?).join(' ')
    end
  end
end