
Pod::Spec.new do |s|


  s.name         = "DFCommon"
  s.version      = "1.5.0"
  s.summary      = "快速开发ios app，封装了ios开发常用的功能"

  s.homepage     = "https://github.com/anyunzhong/DFCommon"

  s.license      = "Apache 2.0"



  s.author             = { "AllenZhong" => "2642754767@qq.com" }

  # s.platform     = :ios
  s.platform     = :ios, "7.0"

  s.source       = { :git => "git@github.com:cochn/DFCommon.git", :tag => s.version.to_s  }


  s.source_files  = "DFCommon/DFCommon/**/*.{h,m}"

  s.resources = "DFCommon/DFCommon/Resource/*.*"

  s.requires_arc = true


  s.dependency 'AFNetworking'
  s.dependency 'SDWebImage'
  s.dependency 'FMDB'
  s.dependency 'MBProgressHUD'
  s.dependency 'MLLabel'

  #s.dependency 'EGOTableViewPullRefresh', '~> 0.1.0'
  s.dependency 'MJRefresh'
  s.dependency 'ODRefreshControl', '~> 1.2'
  s.dependency 'MJPhotoBrowser', '~> 1.0.2'
  s.dependency 'MMPopupView'
  s.dependency 'TZImagePickerController'
  s.dependency 'lame'

  s.vendored_frameworks = "DFCommon/DFCommon/Lib/lame/lame.framework"


end
