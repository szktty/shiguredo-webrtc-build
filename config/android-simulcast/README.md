Android 用サイマルキャストの実装用のディレクトリです。
libwebrtc に追加するコードは `src` 以下にあります。
ブランチは M88 をベースにしています。

`make android-simulcast` で WebRTC のソースコードをダウンロードしたあとに `config/android-simulcast/build.sh` を実行してください。
引数にパスを指定すると、ビルドされた libwebrtc.aar がそのパスにコピーされます。

```
$ ./config/android-simulcast/build.sh [libwebrtc.aar のコピー先]
```

