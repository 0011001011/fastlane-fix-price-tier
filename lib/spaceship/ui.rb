paths = Dir[File.expand_path "**/ui/*.rb", File.dirname(__FILE__)]
raise "Could not find UI classes to import" unless paths.count > 0
paths.each do |file|
  require file
end

module Spaceship
  class Client
    # Public getter for all UI related code
    def UI
      UserInterface.new(self)
    end

    # All User Interface related code lives in this class
    class UserInterface
      # Is called by the client to generate one instance of UserInterface
      def initialize(c)
        @client = c
      end

      # Access the client this UserInterface object is for
      def client
        @client
      end
    end
  end
end
