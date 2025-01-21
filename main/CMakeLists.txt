#==================================================================
# メインのプロジェクトを作成するCmakeLists
#==================================================================
# ・引数
# PROJ_NAME: プロジェクトの名前
# PROJ_TYPE: プロジェクトのタイプ　動的ライブラリか静的ライブラリか実行ファイルか
#-------------------------------
# ・実行方法
#-------------------------------


cmake_minimum_required(VERSION 3.29.3)

# Utilityをインクルード
include("../cmake/Utility/FileFilter.cmake")



# プロジェクト名を設定
if(NOT DEFINED PROJ_NAME)
    set(PROJ_NAME "MyProject") # 引数がなければデフォルト値を設定
endif()

# プロジェクトの種類を設定
if(NOT DEFINED PROJ_TYPE)
    set(PROJ_TYPE STATIC) # 引数がなければデフォルト値を設定
endif()

# プロジェクトの基本ファイルとフィルタ構成を作成
#------------------------------------

# インクルード用のヘッダファイルが無ければ作成
if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/main/include/${PROJ_NAME}.hpp")
  file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/main/include/${PROJ_NAME}.hpp" 
  "// ${PROJ_NAME}のインクルード用ヘッダ

#if defined(STATIC) // 静的ライブラリの場合は空にする
#define ${PROJ_NAME}_API
#elif defined(${PROJ_NAME}_EXPORTS) && defined(SHARED) // 動的ライブラリをエクスポート
#define ${PROJ_NAME}_API __declspec(dllexport)
#else // 動的ライブラリをインポート
#define ${PROJ_NAME}_API __declspec(dllimport)
#endif
")
endif()

# プリコンパイルヘッダが無ければ作成
if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/main/src/pch.hpp")
  file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/main/src/pch.hpp" 
"//============================================
// プリコンパイル済みヘッダ
//============================================

// インクルード用ヘッダ
#include \"${PROJ_NAME}.hpp\"
")
  file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/main/src/pch.cpp" "#include \"pch.hpp\"\n")
endif()

# pch.cppにプリコンパイル済みヘッダ作成フラグを設定
set_source_files_properties(
    "${CMAKE_CURRENT_SOURCE_DIR}/main/src/pch.cpp"
    PROPERTIES COMPILE_FLAGS "/Ycpch.hpp"
)

# ソースとヘッダーファイルを収集
CollectFiles("${CMAKE_CURRENT_SOURCE_DIR}/main/include" INCLUDE_FILES)
CollectFiles("${CMAKE_CURRENT_SOURCE_DIR}/main/src" SRC_FILES)

# # フィルタ構造を作成
CreateFilters("${CMAKE_CURRENT_SOURCE_DIR}/main/include")
CreateFilters("${CMAKE_CURRENT_SOURCE_DIR}/main/src")

# 
#--------------------------------------------------

# プロジェクト全体でプリコンパイル済みヘッダーを使用する設定
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Yupch.hpp")  # /Yuフラグで使用を設定


# ライブラリを作成
add_library(${PROJ_NAME} ${PROJ_TYPE} ${INCLUDE_FILES} ${SRC_FILES})


# エクスポート用マクロのためのプリプロセッサを追加
target_compile_definitions(${PROJ_NAME} PRIVATE 
  "${PROJ_NAME}_EXPORTS"
  ${PROJ_TYPE}
)

# インクルードディレクトリをターゲットに設定
target_include_directories(${PROJ_NAME} PUBLIC 
  "${CMAKE_CURRENT_SOURCE_DIR}/main/include"
  "${CMAKE_CURRENT_SOURCE_DIR}/main/src"
)

# 必ず使用するヘッダを設定
target_compile_options(${PROJ_NAME} PRIVATE 
  /FI"pch.hpp"
  /FI"${PROJ_NAME}.hpp"
  )
  
# projDataのmodulesにある全てのモジュールとリンク
#---------------------------------------------------------
  
# # リンクするライブラリの情報が格納されてるJsonファイルのパスを変数にセット
# set(LIBS_JSON_PATH "${CMAKE_CURRENT_SOURCE_DIR}/projData.json")
  
# # Jsonファイルを読み込む
# file(READ ${LIBS_JSON_PATH} JSON_CONTENT)
  
# # Jsonファイルを解析
# file(JSON JSON_DATA PARSE ${JSON_CONTENT})
  
# # Jsonからライブラリの情報を取得
# set(LIBRARIES_LIST)
# # librariesキーの要素をJSON_LIBRARIES変数にセット
# file(JSON JSON_LIBRARIES GET ${JSON_DATA} libraries)

# file(JSON LIBRARIES_LENGTH LENGTH JSON_LIBRARIES)
# math(EXPR LIBRARIES_LAST_INDEX "${LIBRARIES_LENGTH} - 1")

# foreach(index RANGE 0 ${LIBRARIES_LAST_INDEX})
#   file(JSON LIB_ITEM GET JSON_LIBRARIES ${index})
#   file(JSON LIB_NAME GET LIB_ITEM name)
#   file(JSON LIB_PATH GET LIB_ITEM path)
  
#   FetchContent_Declare(
#     ${LIB_NAME}
#     GIT_REPOSITORY ${LIB_PATH}
#     GIT_TAG main
#   )
#   FetchContent_MakeAvailable(${LIB_NAME})
# endforeach()

