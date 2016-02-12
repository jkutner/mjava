def __main__(argv)
  command = argv.shift

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
    else
      false
    end
  end

  if mjava_zip
    Dir.mkdir(mjava_unzip_dir) unless Dir.exists?(mjava_unzip_dir)
    Miniz.unzip(mjava_zip, mjava_unzip_dir)

    mjava_home = "#{mjava_unzip_dir}/#{mjava_home}"
    mjava_bin_dir = "#{mjava_home}/bin"
    Dir.foreach(mjava_bin_dir) do |f|
      File.chmod2("0755", "#{mjava_bin_dir}/#{f}") unless f.start_with?(".")
    end
  end

  puts "mjava_home = #{mjava_home}"
  puts "mjava_zip  = #{mjava_zip}"

  if mjava_home
    JavaSupport.custom_java(mjava_home, argv)
  else
    JavaSupport.system_java(argv)
  end
end
