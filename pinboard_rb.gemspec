Gem::Specification.new do |s|
  s.name                = 'pinboard_rb'
  s.version             = '0.0.3'
  s.date                = '2012-06-23'
  s.summary             = "Pinboard for Ruby"
  s.description         = "A thin wrapper around Pinboard API V1"
  s.authors             = ["Tommi Lew"]
  s.email               = 'cs.lew.1111@gmail.com'
  s.files               = ["lib/pinboard.rb"]
  s.homepage            = 'http://github.com/cslew/pinboard_rb'

  s.rubyforge_project   = "pinboard_rb"

  s.files               = Dir["{lib}/**/*.rb"]
  s.require_path        = 'lib'

  s.add_development_dependency "rspec"                , "~> 2.10.0"
  s.add_development_dependency "webmock"              , "~> 1.8.7"
  s.add_development_dependency "travis-lint"          , "~> 1.4.0"
  s.add_development_dependency "nyan-cat-formatter"   , "~> 0.0.6"

  s.add_runtime_dependency     "httparty"             , "~> 0.8.3"
end
