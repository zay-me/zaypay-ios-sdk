Pod::Spec.new do |s|
  s.name             = 'zaypay_flutter'
  s.version          = '1.0.0'
  s.summary          = 'Flutter wrapper for Zay Pay SDK'
  s.description      = 'Flutter wrapper for Zay Pay SDK'
  s.homepage         = 'https://github.com/zay-me/zaypay-ios-sdk'
  s.license          = { :file => '../../LICENSE' }
  s.author           = { "Aleksandr Goremykin"=>"sanllier@onside.io" }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'ZayPay', '~> 1.0.0'
  s.platform = :ios, '16.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
