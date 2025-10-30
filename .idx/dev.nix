{ pkgs, ... }:
{
  channel = "unstable";

  packages = with pkgs; [
    flutter
    cmake
    android-tools
    jdk17
  ];

  env = {
    ANDROID_HOME = "/home/user/android-sdk";
    JAVA_HOME = "${pkgs.jdk17}";
  };

  idx.previews = {
    enable = false;
  };
}
