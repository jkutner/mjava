set -e

docker-compose run clean

docker-compose run compile

mkdir -p target

cd mruby/build/

cd i386-apple-darwin14/bin
zip mjava_i686-apple-darwin.zip mjava
mv *.zip ../../../../target
cd ../..

cd x86_64-apple-darwin14/bin
zip mjava_x86_64-apple-darwin.zip mjava
mv *.zip ../../../../target
cd ../..

cd i686-pc-linux-gnu/bin
zip mjava_i686-pc-linux-gnu.zip mjava
mv *.zip ../../../../target
cd ../..

cd x86_64-pc-linux-gnu/bin
zip mjava_x86_64-pc-linux-gnu.zip mjava
mv *.zip ../../../../target
cd ../..

cd i686-w64-mingw32/bin
zip mjava_windows_intelx86.zip mjava.exe
mv *.zip ../../../../target
cd ../..

cd x86_64-w64-mingw32/bin
zip mjava_windows_x86_64.zip mjava.exe
mv *.zip ../../../../target
cd ../..
