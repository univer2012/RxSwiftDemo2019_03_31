# Podfile
# 原来的bundleID是: com.sengoln.RxSwiftDemo2019-03-31
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'ObjectMapper'

target 'RxSwiftDemo2019_03_31' do
    # Rx
    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
    pod 'RxDataSources'

    pod 'NSObject+Rx'
    
    pod 'RxAlamofire'
    
    # Moya
    pod 'Moya', '~> 13.0'
    pod 'Moya/RxSwift'

    pod 'Then'
    pod 'Kingfisher'
    pod 'SnapKit'
    pod 'Reusable', '~> 4.0.0'
    pod 'MJRefresh'
    pod 'SVProgressHUD'
    
    pod 'SwiftyJSON', '~> 4.0'
    
    ##  RxSwift的调试相关
    post_install do |installer|
      installer.pods_project.targets.each do |target|
        if target.name == 'RxSwift'
          target.build_configurations.each do |config|
            if config.name == 'Debug'
              config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
            end
          end
        end
      end
    end

end

