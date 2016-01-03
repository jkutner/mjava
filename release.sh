set -e

docker-compose run clean

docker-compose run compile

mkdir -p target

cd mruby/build/

cd i386-apple-darwin14/bin
zip mjava_macosx_bin.zip mjava
mv *.zip ../../../../target
cd ../..

cd x86_64-apple-darwin14/bin
zip mjava_macosx_x86_64_bin.zip mjava
mv *.zip ../../../../target
cd ../..

cd i686-pc-linux-gnu/bin
zip mjava_linux_bin.zip mjava
mv *.zip ../../../../target
cd ../..

cd x86_64-pc-linux-gnu/bin
zip mjava_linux_x86_64_bin.zip mjava
mv *.zip ../../../../target
cd ../..

cd i686-w64-mingw32/bin
zip mjava_win_exe.zip mjava.exe
mv *.zip ../../../../target
cd ../..

cd x86_64-w64-mingw32/bin
zip mjava_win_x86_64_exe.zip mjava.exe
mv *.zip ../../../../target
cd ../..
