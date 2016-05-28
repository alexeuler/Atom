Pod::Spec.new do |s|
    s.name         = "Atom"
    s.version      = "0.0.1"
    s.summary      = "The framework on top of MVC, inspired by React"
    s.description  = <<-DESC
        The framework on top of MVC, inspired by React
    DESC
    s.homepage     = "http://EXAMPLE/Atom"
    s.license      = "MIT"
    s.authors      = { "Alexey Karasev" => "karasev.alexey@gmail.com",
                       "Ilya Saldin" => "saldin.iliya@gmail.com" }
    # s.social_media_url   = TBA
    s.platform     = :ios, "8.0"
    s.source       = { :git => "https://github.com/alleycat-at-git/atom", :tag => "0.0.1" }
    s.source_files  = "Classes/*.swift"
    s.exclude_files = "Classes/Exclude"
end