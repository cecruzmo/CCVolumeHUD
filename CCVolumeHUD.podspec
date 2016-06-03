Pod::Spec.new do |s|

  s.name         = "CCVolumeHUD"
  s.version      = "0.1.0"
  s.summary      = "CCVolumeHUD changes the default volume HUD for a unobtrusive volume HUD displayed at the status bar"
  s.description  = "Ideal for video apps: change the default volume HUD for a small line volume indicator displayed at the status bar"

  s.homepage     = "https://github.com/cecruzmo/CCVolumeHUD"
  s.screenshots  = "https://raw.githubusercontent.com/cecruzmo/CCVolumeHUD/master/screenshot.png"

  s.license      = "MIT"

  s.author             = { "Cesar Felipe Cruz Morales" => "cecruzmo@gmail.com" }
  s.social_media_url   = "http://twitter.com/cecruzmo"

  s.platform     = :ios, "8.0"

  s.requires_arc = true

  s.source       = { :git => "https://github.com/cecruzmo/CCVolumeHUD.git", :tag => "0.1.0" }

  s.source_files  = "CCVolumeHUD"
  s.exclude_files = "CCVolumeHUDTests"

end
