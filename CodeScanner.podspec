Pod::Spec.new do |s|
  s.name                  = "CodeScanner"
  s.version               = "1.7.0"
  s.summary               = "CodeScanner is easy to scan a barcode or QR code."
  s.homepage              = "https://github.com/masashi-sutou/CodeScanner"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.source                = { :git => "https://github.com/masashi-sutou/CodeScanner.git", :tag => s.version }
  s.source_files          = "CodeScanner", "CodeScanner/**/*.{swift}"
  s.requires_arc          = true
  s.platform              = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.ios.frameworks        = ['UIKit', 'Foundation', 'AVFoundation', 'CoreImage']
  s.author                = { "masashi-sutou" => "sutou.masasi@gmail.com" }
end
