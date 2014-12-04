require 'fastlane/password_manager'

describe Fastlane do
  describe Fastlane::PasswordManager do
    describe "Test environment" do
      let (:username) { "test@example123.com" }
      let (:password) { "somethingFancy123$" }

      before do
        ENV["DELIVER_USER"] = username
        ENV["DELIVER_PASSWORD"] = password
      end

      describe "#username" do
        it "uses the environment variable if given" do
          expect(Fastlane::PasswordManager.new.username).to eq(username)
        end
      end

      describe "#password" do
        it "uses the environment variable if given" do
          expect(Fastlane::PasswordManager.new.password).to eq(password)
        end
      end
    end
  end
end