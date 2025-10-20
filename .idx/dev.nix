{ pkgs, ... }:
{
  channel = "unstable";

  packages = with pkgs; [
    flutter
    cmake
    android-tools
  ];

  env = {
    ANDROID_HOME = "${pkgs.android-tools}";
  };

  idx.previews = {
    enable = false;
  };
}
