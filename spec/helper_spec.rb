describe FastlaneCore do
  describe FastlaneCore::Helper do
    
    describe "#is_ci?" do
      it "returns false when not building in a known CI environment" do
        stub_const('ENV', {})
        expect(FastlaneCore::Helper.is_ci?).to be false
      end

      it "returns true when building in Jenkins" do
        stub_const('ENV', { 'JENKINS_URL' => 'http://fake.jenkins.url' })
        expect(FastlaneCore::Helper.is_ci?).to be true
      end

      it "returns true when building in Travis CI" do
        stub_const('ENV', { 'TRAVIS' => true })
        expect(FastlaneCore::Helper.is_ci?).to be true
      end
    end

    # Mac OS only (to work on Linux)
    if OS.mac?
      describe "Xcode Paths" do
        it "#xcode_path" do
          expect(FastlaneCore::Helper.xcode_path[-1]).to eq('/')
          expect(FastlaneCore::Helper.xcode_path).to eq("/Applications/Xcode.app/Contents/Developer/")
        end

        it "#transporter_path" do
          expect(FastlaneCore::Helper.transporter_path).to eq("/Applications/Xcode.app/Contents/Developer/../Applications/Application Loader.app/Contents/itms/bin/iTMSTransporter")
        end
      end
    end
    
  end
end