Pod::Spec.new do |s|
    s.name             = 'AveFontHelpers'
    s.version          = '1.0.0'
    s.summary          = 'Makes working with Dynamic Type and UIFont easier'
    s.homepage         = 'https://github.com/AndreasVerhoeven/AveFontHelpers'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Andreas Verhoeven' => 'cocoapods@aveapps.com' }
    s.source           = { :git => 'https://github.com/AndreasVerhoeven/AveFontHelpers.git', :tag => s.version.to_s }
    s.module_name      = 'AveFontHelpers'

    s.swift_versions = ['5.0']
    s.ios.deployment_target = '13.0'
    s.source_files = 'Sources/*.swift'
end
