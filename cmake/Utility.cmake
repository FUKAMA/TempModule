# ソースファイルを再帰的に収集する関数
function(CollectFiles BASE_DIR OUTPUT_VAR)
  file(GLOB_RECURSE FILE_LIST "${BASE_DIR}/*")
  set(${OUTPUT_VAR} ${FILE_LIST} PARENT_SCOPE)
endfunction()


# 指定したディレクトリ以下のすべてのファイルを収集し、ディレクトリ構造に基づいてフィルタを設定する関数
function(CreateFilters BASE_DIR)
  # ファイルを再帰的に収集
  file(GLOB_RECURSE FILE_LIST "${BASE_DIR}/*")
  
  # 引数の一つ上の階層のパスをディレクトリのパスを取得
  get_filename_component(PARENT_DIR "${BASE_DIR}" PATH)

  # 各ファイルについてフィルタを作成
  foreach(FILE_PATH IN LISTS FILE_LIST)
    # BASE_DIRを基準とした相対パスを取得
    file(RELATIVE_PATH RELATIVE_PATH "${PARENT_DIR}" "${FILE_PATH}")

    # フィルタ名を作成（スラッシュをバックスラッシュに変換）
    string(REGEX REPLACE "/" "\\\\" FILTER_NAME "${RELATIVE_PATH}")
    get_filename_component(FILTER_NAME "${FILTER_NAME}" PATH)

    # フィルタを作成
    source_group("${FILTER_NAME}" FILES "${FILE_PATH}")
  endforeach()
  
endfunction()
