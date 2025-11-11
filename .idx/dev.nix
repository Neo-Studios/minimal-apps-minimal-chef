{ pkgs, ... }:
{
  channel = "unstable";

  packages = with pkgs; [
    # Web (TypeScript/Next.js)
    nodejs_20
    nodePackages.npm
    nodePackages.typescript
    nodePackages.pnpm
    
    # Android (Kotlin)
    android-tools
    gradle
    kotlin
    jdk17
    
    # Build tools
    cmake
    git
  ];

  env = {
    ANDROID_HOME = "/home/user/android-sdk";
    JAVA_HOME = "${pkgs.jdk17}";
  };

  idx.previews = {
    enable = true;
    previews = {
      web = {
        command = ["npm" "run" "dev" "--prefix" "web"];
        manager = "web";
        env = {
          PORT = "3000";
        };
      };
    };
  };
}
