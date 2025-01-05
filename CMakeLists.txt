#==================================================================
# プロジェクトをまとめるソリューションを作成するCmakeLists
#==================================================================
# ・引数
# PROJ_NAME: プロジェクトの名前
# PROJ_TYPE: プロジェクトのタイプ　動的ライブラリか静的ライブラリか実行ファイルか
#-------------------------------
# ・実行方法
# cmake -DPROJ_NAME=HOGE -DLIB_TYPE=STATIC
#-------------------------------

cmake_minimum_required(VERSION 3.29.3)

# # ビルドディレクトリを設定
# set(GLOBAL_BIN_DIR "${CMAKE_BINARY_DIR}/build/bin")
# set(GLOBAL_LIB_DIR "${CMAKE_BINARY_DIR}/build/lib")

# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${GLOBAL_BIN_DIR}")
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${GLOBAL_LIB_DIR}")
# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${GLOBAL_LIB_DIR}")

# Visual Studio固有の設定
if(MSVC)
    set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT test)
endif()


# set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CMAKE_BINARY_DIR}/custom_temp")
# set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK "${CMAKE_BINARY_DIR}/custom_temp")

# ビルド先のディレクトリを指定
#---------------------------------

# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${GLOBAL_LIB_DIR}/liba")
# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${GLOBAL_BIN_DIR}/liba")



# 変数の初期化
#--------------------------------

# プロジェクト名を設定
if(NOT DEFINED PROJ_NAME)
    set(PROJ_NAME "MyProject") # 引数がなければデフォルト値を設定
endif()

# プロジェクト名を設定
if(NOT DEFINED PROJ_TYPE)
    set(PROJ_TYPE STATIC) # 引数がなければデフォルト値を設定
endif()



# ソリューションの作成
#----------------------------------

# ソリューション全体のプロジェクトを設定
project(${PROJ_NAME} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# メインプロジェクトを作成
#-----------------------------

# メインプロジェクトのディレクトリを保存
# set(MAIN_PROJ_DIR "${PROJ_NAME}")
# add_subdirectory("Cmake/main" ${MAIN_PROJ_DIR})
add_subdirectory(main)

# テストプロジェクトを作成
#----------------------------

# set(TEST_PROJ_DIR "test")
# add_subdirectory("CMake/test" ${TEST_PROJ_DIR})
add_subdirectory(test)

# テストプロジェクトをスタートアッププロジェクトに設定
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT test)
