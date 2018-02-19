Pod::Spec.new do |s|
  s.name             = "CollageView"
  s.version          = '1.0.4'
  s.summary          = "Easy to use and fully customizable CollageView with multiple images inside."
  s.description      = <<-DESC
  Custom View, collageView implementation with pure Swift 4. This Library's aim is to make easily photo collage views.
                       DESC
  s.homepage         = "https://github.com/ahmetkgunay/CollageView"
  s.license          = 'MIT'
  s.author           = { "Ahmet Kazım Günay" => "ahmetkgunay@gmail.com" }
  s.source           = { :git => "https://github.com/ahmetkgunay/CollageView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ahmtgny'
  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/*.swift'
end
