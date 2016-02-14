def debug(msg)
  puts msg if ENV['MJAVA_DEBUG']
end

def __main__(argv)
  command = argv.shift

  mjava_in_proc = false
  mjava_home = nil
  mjava_zip = nil
  mjava_unzip_dir = ".jdk"
  argv.delete_if do |arg|
    if arg.start_with?("--mjava-home=")
      mjava_home = arg["--mjava-home=".size..-1]
      true
    elsif arg.start_with?("--mjava-zip=")
      mjava_zip = arg["--mjava-zip=".size..-1]
      true
    elsif arg.start_with?("--mjava-unzip-dir=")
      mjava_unzip_dir = arg["--mjava-unzip-dir=".size..-1]
      true
    elsif arg == "--mjava-in-proc"
      mjava_in_proc = true
      true
    elsif arg == "--mjava-version"
      puts "mjava #{MJava::VERSION}"
      true
    else
      false
    end
  end

  if mjava_zip
    Dir.mkdir(mjava_unzip_dir) unless Dir.exists?(mjava_unzip_dir)
    Miniz.unzip(mjava_zip, mjava_unzip_dir)

    mjava_home = "#{mjava_unzip_dir}/#{mjava_home}"
  end

  debug "mjava_home = #{mjava_home}"
  debug "mjava_zip  = #{mjava_zip}"

  java_support = mjava_home ? JavaSupport.new(mjava_home) : JavaSupport.new

  if mjava_in_proc
    java_opts = []
    while argv.first != "--" and !argv.empty?
      java_opts << argv.shift
    end
    argv.shift
    java_class = argv.shift
    java_support.exec_java(java_opts, java_class, argv)
  else
    if mjava_zip
      mjava_bin_dir = "#{mjava_home}/bin"
      Dir.foreach(mjava_bin_dir) do |f|
        File.chmod2("0755", "#{mjava_bin_dir}/#{f}") unless f.start_with?(".")
      end
    end
    java_support.system_java(argv)
  end
end
