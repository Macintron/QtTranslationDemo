cmake_minimum_required(VERSION 3.17)
project(QtTranslationDemo LANGUAGES CXX)

find_package(Qt5
  COMPONENTS
    LinguistTools Core
  REQUIRED
)

option(UPDATE_TRANSLATIONS "Enable rescanning sources to update .ts files" OFF)


set(_tsFiles en.ts de.ts)
if(UPDATE_TRANSLATIONS)
  message("** parse sources for new translations")
  qt5_create_translation(_qmFiles
    main.cpp
    ${_tsFiles}
  )
else()
  message("** update qm files")
  qt5_add_translation(_qmFiles
    ${_tsFiles}
  )
endif()

add_custom_target(demoTranslations DEPENDS ${_qmFiles})


add_executable(demo
  main.cpp
  ${_qmFiles}
)

target_link_libraries(demo
  PUBLIC
    Qt5::Core
)
