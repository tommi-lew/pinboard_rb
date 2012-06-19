Gem::Specification.new do |s|
  s.name                = 'pinboard_rb'
  s.version             = '0.0.1'
  s.date                = '2012-06-19'
  s.summary             = "Pinboard for Ruby"
  s.description         = "A thin wrapper around Pinboard API V1"
  s.authors             = ["Tommi Lew"]
  s.email               = 'cs.lew.1111@gmail.com'
  s.files               = ["lib/pinboard.rb"]
  s.homepage            =     'http://rubygems.org/gems/pinboard_rb'

  s.rubyforge_project   = "pinboard_rb"

  s.files               = Dir["{lib}/**/*.rb"]
  s.require_path        = 'lib'
end
