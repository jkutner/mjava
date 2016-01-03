MRuby::Gem::Specification.new('mjava') do |spec|
  spec.license = 'MIT'
  spec.author  = 'Joe Kutner'
  spec.summary = 'mjava'
  spec.bins    = ['mjava']

  spec.add_test_dependency 'mruby-mtest', :mgem => 'mruby-mtest'
  spec.add_dependency 'mruby-env', :mgem => 'mruby-env'
  spec.add_dependency 'mruby-dir', :mgem => 'mruby-dir'
  spec.add_dependency 'mruby-string-ext', :core => 'mruby-string-ext'
  spec.add_dependency 'mruby-io', :mgem => 'mruby-io'
  spec.add_dependency 'mruby-jvm', :github => 'jkutner/mruby-jvm'

  spec.cc.include_paths << "#{spec.build.gem_clone_dir}/mruby-io/include"
end
