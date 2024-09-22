# Uncomment the next line to define a global platform for your project
# platform :ios, '17.2'

target 'NihonGo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NihonGo
  pod 'GoogleMLKit/DigitalInkRecognition', '3.2.0'
  pod 'GoogleMLKit/Translate', '3.2.0'
  target 'NihonGoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'NihonGoUITests' do
    # Pods for testing
  end

end

 post_install do |installer|
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
             config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
             config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
             config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
         end
     end
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
      end
    end
  end
  end
