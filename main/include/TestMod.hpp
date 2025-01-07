// TestModのインクルード用ヘッダ

#if defined(STATIC) // 静的ライブラリの場合は空にする
#define TestMod_API
#elif defined(TestMod_EXPORTS) && defined(SHARED) // 動的ライブラリをエクスポート
#define TestMod_API __declspec(dllexport)
#else // 動的ライブラリをインポート
#define TestMod_API __declspec(dllimport)
#endif
