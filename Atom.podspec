Pod::Spec.new do |s|
    s.name         = "Atom"
    s.version      = "0.0.1"
    s.summary      = "The framework on top of MVC, inspired by React"
    s.description  = <<-DESC
        The framework on top of MVC, inspired by React. TBA.
    DESC
    s.homepage     = "https://github.com/alleycat-at-git/atom"
    s.license      = "MIT"
    s.authors      = { "Alexey Karasev" => "karasev.alexey@gmail.com",
                       "Ilya Saldin" => "saldin.iliya@gmail.com" }
    # s.social_media_url   = TBA
    s.platform     = :ios, "8.0"
    s.source       = { :path => "." }
    s.source_files  = "Atom/Classes/*.swift"
    s.exclude_files = "Atom/Classes/Exclude"
end