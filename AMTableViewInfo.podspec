#
# Be sure to run `pod lib lint AMTableViewInfo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AMTableViewInfo'
  s.version          = '0.1.0'
  s.summary          = '简单快捷的创建 tableView'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
快速创建tableview, cell 高度有自动高度和固定高度两种方式,三方组件MJRefresh,DZNEmptyDataSet可选.
                       DESC

  s.homepage         = 'https://github.com/askmegit/AMTableViewInfo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'askmegit' => '83076130@qq.com' }
  s.source           = { :git => 'https://github.com/askmegit/AMTableViewInfo.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'AMTableViewInfo/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AMTableViewInfo' => ['AMTableViewInfo/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'DZNEmptyDataSet', '~> 1.8.1'
  s.dependency 'MJRefresh', '~> 3.1.15.7'
end
