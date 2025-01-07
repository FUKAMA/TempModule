#include <gtest/gtest.h>
#include "TestMod.hpp"

// サンプルテスト
// テストフレームワークが正常に動作していることを確認するためのテスト
TEST(_BeginTest, GoogleTest)
{
  EXPECT_EQ(1 + 1, 2);  // 成功
  EXPECT_TRUE(true);    // 成功
}
