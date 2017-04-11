Pod::Spec.new do |s|
  s.name             = 'AppForm'
  s.version          = '0.1.0'
  s.summary          = 'Universal Form for iOS apps'
 
  s.description      = <<-DESC
Make iOS apps with UITableViewCells.
                       DESC
 
  s.homepage         = 'https://github.com/aunnnn/AppForm'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'Wirawit Rueopas' => 'aun.wirawit@gmail.com' }
  s.source           = { :git => 'https://github.com/aunnnn/AppForm.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.0'
  s.source_files = 'AppForm/Classes/**/*.swift'
 
end