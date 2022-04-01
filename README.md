# stockcomputer-ios
https://developer.apple.com/sf-symbols/?fbclid=IwAR0oxmTeWm1YVjhe_MVXw5OQRSYPWWAHnr89amgS8CM5SmspZfyOG9aOtig


swift横竖屏切换 https://www.jianshu.com/p/9683316fd82a


dSYM檔案生成 https://www.gushiciku.cn/pl/pSc4/zh-tw

https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E6%95%99%E5%AE%A4/autolayout-programmatically%E8%A1%A8%E7%A4%BA-d27c3274f2f5



https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E5%95%8F%E9%A1%8C%E8%A7%A3%E7%AD%94%E9%9B%86/%E5%9C%A8-ios-app-%E5%8A%A0%E5%85%A5%E6%94%B6%E9%9B%86%E9%96%83%E9%80%80-log-%E7%9A%84-firebase-crashlytics-b884b9790527



# 下面两行是指明依赖库的来源地址
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Artsy/Specs.git'

# 说明平台是ios，版本是9.0
platform :ios, '9.0'

# 忽略引入库的所有警告（强迫症者的福音啊）
inhibit_all_warnings!

# 针对MyApp target引入AFNetworking
# 针对MyAppTests target引入OCMock，
target 'MyApp' do 
    pod 'AFNetworking', '~> 3.0' 
    target 'MyAppTests' do
       inherit! :search_paths 
       pod 'OCMock', '~> 2.0.1' 
    end
end
# 这个是cocoapods的一些配置,官网并没有太详细的说明,一般采取默认就好了,也就是不写.
post_install do |installer|       
   installer.pods_project.targets.each do |target| 
     puts target.name 
   end
end
