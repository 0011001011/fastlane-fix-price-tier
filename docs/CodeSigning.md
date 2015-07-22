# CodeSigning

There are multiple ways of doing code signing right. Letting Xcode automatically choose the provisioning profile is **not** one of them.

### Easy Solution: Static Setting

In your project file set the correct `Provisioning Profile` and use the the `ipa` integration in `fastlane`.

**Disadvantages**: As soon as your provisioning profile changes, you'll have to update your project file. Therefore not a long-term solution.

### Best Solution: Using environment variables

By choosing `Automatic` the underlying value in your project file is just empty. Open your `project.pbxproj` and look for
```
PROVISIONING_PROFILE = "";
```
To fill the profile in using environment variables use 
```
PROVISIONING_PROFILE = "$(PROFILE_UDID)";
```
This allows the Xcode project to use `Automatic` provisioning profiles and enables `fastlane` to set a custom profile.

In your `Fastfile`, add the following between your `sigh` and `ipa` call:

```ruby
sigh

# use the UDID of the newly created provisioning profile
ENV["PROFILE_UDID"] = Actions.lane_context[Actions::SharedValues::SIGH_UDID]

ipa(scheme: "Release")
```

This allows you to also support more complex setups, for example if your app supports app extensions or a Watch App.

Check out the [MindNode Setup](https://github.com/fastlane/examples/blob/master/MindNode/Fastfile) that shows you how to set different provisioning profiles for various targets.

### Hacky Solution: Modify the Xcode project
Using the [update_project_provisioning](https://github.com/KrauseFx/fastlane/blob/master/docs/Actions.md#update_project_provisioning) action you can modify your Xcode project's targets to use a specific provisioning profile. 

```ruby
update_project_provisioning(
  xcodeproj: "Project.xcodeproj",
  profile: "./AppStore.mobileprovision", # optional if you use sigh
  build_configuration_filter: ".*WatchKit Extension.*"
)
```

As this will modify the project file, you'll have to reset the git changes of the project files after successfully building your application:
```ruby
ensure_git_status_clean
sigh
update_project_provisioning(...)
reset_git_repo(files: ["Project.xcodeproj/project.pbxproj"])
```
