#==================================================================
# テストを実行するためのプロジェクトを作成するCmakeLists
#==================================================================
# ・引数
# PROJ_NAME: プロジェクトの名前
# PROJ_TYPE: プロジェクトのタイプ　動的ライブラリか静的ライブラリか実行ファイルか
#-------------------------------
# ・実行方法
#-------------------------------


cmake_minimum_required(VERSION 3.29.3)

# include("../cmake/Utility.cmake")
include("../cmake/Utility/FileFilter.cmake")


# GoogleTestのインポート
#---------------------------------------

set(CMAKE_FETCHCONTENT_BASE_DIR "${CMAKE_BINARY_DIR}/Import/GoogleTest")

include(FetchContent)
FetchContent_Declare(
  googletest
  # Specify the commit you depend on and update it regularly.
  URL https://github.com/google/googletest/archive/609281088cfefc76f9d0ce82e1ff6c30cc3591e5.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# GoogteTest関係のプロジェクトを専用のソリューションフォルダに隔離
set_target_properties(gmock PROPERTIES FOLDER "Import/GoogleTest")
set_target_properties(gtest PROPERTIES FOLDER "Import/GoogleTest")
set_target_properties(gmock_main PROPERTIES FOLDER "Import/GoogleTest")
set_target_properties(gtest_main PROPERTIES FOLDER "Import/GoogleTest")





# 仮のテストファイルを生成
file(WRITE ./src/BeginTest.cpp
"#include <gtest/gtest.h>
#include \"${PROJ_NAME}.hpp\"

// サンプルテスト
// テストフレームワークが正常に動作していることを確認するためのテスト
TEST(_BeginTest, GoogleTest)
{
  EXPECT_EQ(1 + 1, 2);  // 成功
  EXPECT_TRUE(true);    // 成功
}
")

# TESTS_FILESにsrc以下のファイルをすべて格納
CollectFiles("${CMAKE_CURRENT_SOURCE_DIR}/src" TESTS_FILES)

# srcディレクトリ以下の構成をフィルタに変換
CreateFilters("${CMAKE_CURRENT_SOURCE_DIR}/src")



# テスト用プロジェクトを作成、名前をプロジェクト名＋googleTestに変更
# GoogleTestのインクルードファイルをリンク
add_executable(test ${TESTS_FILES})
# インポートしたGoogleTestのライブラリをテストプロジェクトにリンク
target_link_libraries(test gtest_main)

# メインプロジェクトのインクルードディレクトリとソースのルートディレクトリをインクルードディレクトリに追加
target_include_directories(test PRIVATE "${CMAKE_SOURCE_DIR}/main/include" "${CMAKE_SOURCE_DIR}/main/src" "${googletest_SOURCE_DIR}/googletest/include")


# テストターゲットの出力ディレクトリを指定
# GoogleTest関連ターゲットの出力ディレクトリを指定
set_target_properties(test gmock gtest gmock_main gtest_main PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/build/tests/bin"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/build/tests/lib"
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/build/tests/lib"
)


# テストターゲットの出力ディレクトリを統一
set(GLOBAL_TEST_BIN_DIR "${CMAKE_BINARY_DIR}/tests/bin")
set(GLOBAL_TEST_LIB_DIR "${CMAKE_BINARY_DIR}/tests/lib")

# ビルド結果を格納するディレクトリを指定
set_target_properties(test PROPERTIES
RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/build/bin"
LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/build/lib"
ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/build/lib"
)


# 必ず使用するヘッダを設定
target_compile_options(test PRIVATE 
/FI"${PROJ_NAME}.hpp"
)


# ファイルをひとつづつ取り出してテストを追加する
foreach(FILE_PATH IN LISTS TESTS_FILES)
add_test(NAME ${FILE_PATH} COMMAND test)
endforeach()

enable_testing()