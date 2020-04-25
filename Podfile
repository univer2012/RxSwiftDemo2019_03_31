# Podfile
# 原来的bundleID是: com.sengoln.RxSwiftDemo2019-03-31
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'ObjectMapper'

target 'RxSwiftDemo2019_03_31' do
  
  # 基于RxSwift的工作流
  #pod 'RxFlow'

  pod 'URLNavigator'

  # 网络请求
#  pod 'Moya/RxSwift', '~> 12.0.1'

  pod 'Alamofire-Synchronous', '~> 4.0'
  
  # 键盘管理类
  pod 'IQKeyboardManagerSwift', '~> 6.2.0'

  # Swift json
  pod 'SwiftyJSON', '~> 4.2.0'

  # 图片缓存库，支持OC 和 Swift
  pod 'SDWebImage', '~> 5.0'
  
  # 支持OC，对Swift支持度未知
  pod 'SDCycleScrollView', '~> 1.80'
  
#  pod 'MJRefresh', '3.2.0'
  pod 'CYLTabBarController', '~> 1.28.0'
  #pod 'MLeaksFinder'
  pod 'SAMKeychain'
  pod 'YYText'
  pod 'UITableView+FDTemplateLayoutCell', '~> 1.6'
  pod 'Protobuf'
  pod 'CocoaAsyncSocket'
  pod 'PPSPing', '~> 0.3.0'
  pod 'SwiftProtobuf', '~> 1.4.0'
  pod 'MMKV'
  pod 'DZNEmptyDataSet'

  #AppDelegate瘦身类
  pod 'PluggableApplicationDelegate', :git => 'https://github.com/fmo91/PluggableApplicationDelegate.git'
  
  #zip压缩和解压库
  pod 'SSZipArchive'

  #WCDB是一个高效、完整、易用的移动数据库框架，基于SQLCipher，支持iOS, macOS和Android
  pod 'WCDB'

  #Powerful, Easy to use alert view or popup view on controller and window, support blur effects,custom view and animation,for objective-c,support iphone, ipad
  pod 'TYAlertController'

  #图表绘制软件
  pod 'Charts'

  #神策数据分析
#  pod 'SensorsAnalyticsSDK'

  #SnapKit is a DSL to make Auto Layout easy on both iOS and OS X.
#  pod 'SnapKit', '~> 4.2.0'

#  pod 'Masonry'

  # QMUI模块
  #pod 'QMUIKit'

  # Lottie动画
  pod 'lottie-ios'

  # 富文本处理框架
  pod 'DTCoreText', '~> 1.6.21'

  # HUD模块
  pod 'MBProgressHUD'

  # R.swift 自动生成资源文件方法
  pod 'R.swift'

  # swift版本的加密库
  #pod 'CryptoSwift'

  pod 'YYModel'

#  pod 'RxDataSources', '~> 3.1.0'

  # 私有库
  #pod 'YXKit', :git => 'ssh://git@szgitlab.youxin.com:222/YXPods/YXKit.git'
  #pod 'YXKit', :path => '../../YXKit/'

  pod 'SwifterSwift'

  #pod 'QQ_XGPush', '~> 3.3.7'

#  pod 'AppsFlyerFramework'
  
  ###=======================================
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
    
#    pod 'SwiftyJSON', '~> 4.0'
    
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

