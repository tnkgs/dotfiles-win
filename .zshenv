# Arch Linuxの場合のみ設定
if [ -f /etc/arch-release ]; then
  # WSLでGPUビデオアクセラレーションレンダリングを有効にする
  export GALLIUM_DRIVER=d3d12
  export LIBVA_DRIVER_NAME=d3d12
  export MESA_LOADER_DRIVER_OVERRIDE=d3d12
  export MESA_D3D12_DEFAULT_ADAPTER_NAME=NVIDIA
  
  # GTK設定 - X11を優先使用
  export GDK_BACKEND=x11
  export GDK_GL=gles
  
  # GTK4固有の設定
  export GTK_CSD=0 # クライアントサイド装飾を無効化
  export GTK_USE_PORTAL=0 # ポータル経由のダイアログを無効化

  # GUI環境（$DISPLAYが設定されている）の場合のみIME設定
  if [ -n "$DISPLAY" ]; then
    # Wayland環境変数設定
    export QT_QPA_PLATFORM=xcb

    # IME環境変数設定
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
  fi
fi

export LANG=ja_JP.UTF-8
