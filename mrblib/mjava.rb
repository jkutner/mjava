def __main__(argv)
  command = argv.shift
  java_class = argv.shift
  java_opts = []
  while argv.first != "--" and !argv.empty?
    java_opts << argv.shift
  end
  argv.shift
  JavaSupport.system_java(java_opts, java_class, argv)
end
