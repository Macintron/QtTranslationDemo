#!/bin/sh

set -e
thisdir=$(dirname $0)

qt_root=/usr/local/Trolltech/Qt5.15/5.15.1/clang_64

#cmaketool=/usr/local/Cellar/cmake/3.16.8/bin/cmake
cmaketool=cmake


# easier setup
rm -Rf en.qm de.qm CMakeFiles CMakeCache.txt cmake_install.cmake build.ninja .ninja_* > /dev/null 2>&1
git checkout $thisdir/de.ts $thisdir/en.ts  # restore files
$cmaketool --version
$cmaketool -G Ninja -DCMAKE_PREFIX_PATH=$qt_root ../QtTranslationDemo
ninja
./demo
rm -f demo

echo "Starting CMake with DUPDATE_TRANSLATIONS..."
$cmaketool -DUPDATE_TRANSLATIONS=ON $thisdir

echo
echo "Updating translation files..."
ninja demoTranslations

echo
echo "Restore CMake configuration..."
$cmaketool -DUPDATE_TRANSLATIONS=OFF $thisdir

ninja
./demo

exit 0
