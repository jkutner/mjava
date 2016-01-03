require 'open3'
require 'tmpdir'

BIN_PATH = File.join(File.dirname(__FILE__), "../mruby/bin/mjava")

assert('version') do
  Dir.mktmpdir do |tmp_dir|
    Dir.chdir(tmp_dir) do
      output, error, status = Open3.capture3("#{BIN_PATH} -version")
      assert_true status.success?, "Process did not exit cleanly"
      assert_include error, "OpenJDK Runtime Environment"
    end
  end
end

assert('correct number of args') do
  Dir.mktmpdir do |tmp_dir|
    Dir.chdir(tmp_dir) do
      `echo "class Main { public static void main(String[] a) { System.out.println(a.length); }}" > Main.java`
      `javac Main.java`
      output, error, status = Open3.capture3("#{BIN_PATH} Main a b c 4 e")
      assert_true status.success?, "Process did not exit cleanly"
      assert_include output, "5"
    end
  end
end

assert('receives JVM opts') do
  Dir.mktmpdir do |tmp_dir|
    Dir.chdir(tmp_dir) do
      `echo "class Main { public static void main(String[] a) { System.out.println(System.getProperty(\\"foobar\\")); }}" > Main.java`
      `javac Main.java`
      output, error, status = Open3.capture3("#{BIN_PATH} -Dfoobar=abc123 Main")
      assert_true status.success?, "Process did not exit cleanly"
      assert_include output, "abc123"
    end
  end
end
