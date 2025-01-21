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

# Visual Studio固有の設定
if(MSVC)
    set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT test)
endif()



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
add_subdirectory(main)

# テストプロジェクトを作成
#----------------------------

add_subdirectory(test)

# テストプロジェクトをスタートアッププロジェクトに設定
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT test)
