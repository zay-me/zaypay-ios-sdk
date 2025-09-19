Pod::Spec.new do |s|
  s.name                = 'ZayPay'
  s.version             = '1.0.0'
  s.summary             = 'Zay Pay SDK'
  s.authors             = {"Aleksandr Goremykin"=>"sanllier@onside.io"}
  s.license             = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage            = 'https://github.com/zay-me/zaypay-ios-sdk'
  s.description         = 'Zay Pay SDK'
  s.source              = { :git => 'https://github.com/zay-me/zaypay-ios-sdk', :tag => '1.0.0' }
  s.platform            = :ios, '16.0'
  s.vendored_frameworks = 'ZayPay.xcframework'
end
