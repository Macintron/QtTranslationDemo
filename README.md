# CMake 3.17 deletes Qt translations when updating the TS files


With CMake 3.16.8 or less, the following workflow was working, but 3.17+ deletes the Qt's TS files.
The idea is taken from [Professional CMake, 7th Edition by Craig Scott](https://crascit.com/professional-cmake/) 

## Requirements

cmake 3.17+, Qt 5.9+, ninja


## Concept

To update the translation files for Qt, `UPDATE_TRANSLATIONS` can be enabled. When finished, disable it.
CMake 3.17+ deletes the updated TS files.

Adjust paths in the script `update_translation.sh` to automate the workflow.


## Steps to reproduce

```
git clone https://github.com/Macintron/QtTranslationDemo.git # or create files from below in QtTranslationDemo.
mkdir build  # NOT in QtTranslationDemo
cd build
cmake -G Ninja -DCMAKE_PREFIX_PATH=[pathToQtDir/5.15.1/clang_64] ../QtTranslationDemo
ninja
./demo
```
Output should be:

        Demo
        de.qm: 85 bytes
          Language: 'Deutsch'
          greeting: ''
        en.qm: 85 bytes
          Language: 'English'
          greeting: ''

```
cmake -DUPDATE_TRANSLATIONS=ON ../QtTranslationDemo
ninja demoTranslations
cmake -DUPDATE_TRANSLATIONS=OFF ../QtTranslationDemo
# new strings ("greeting") should haven been added to the ts files, but TS files are deleted instead!
```


Why are the TS files get deleted? Is this a bug in CMake 3.17+ or a bug in my workflow?


## build info

The build directory must NOT be inside the sources.
