MRuby::Gem::Specification.new('mjava') do |spec|
  spec.license = 'MIT'
  spec.author  = 'Joe Kutner'
  spec.summary = 'mjava'
  spec.bins    = ['mjava']

  spec.add_dependency 'mruby-jvm', :github => 'jkutner/mruby-jvm'
end
