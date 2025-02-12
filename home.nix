{ inputs, config, pkgs, hyprland, hy3, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.username      = "n3rdium";
  home.homeDirectory = "/home/n3rdium";
  home.stateVersion  = "24.05"; # Please don't touch

  home.packages = with pkgs; [
    # Essentials
    yazi
    floorp
    imagemagick
    xfce.thunar
    rpi-imager

    # Astro
    wine
    gimp
    # siril
    stellarium

    # Code
    trashy
    ripgrep
    lua5_1
    nixd
    ruff
    rustup
    python3
    isort
    black
    stylua
    luarocks
    prettierd
    gcc
    tree-sitter

    # Music
    musescore
    muse-sounds-manager
    lmms
    audacity
    pavucontrol
    youtube-music

    # Prod
    krita
    # blender
    ffmpeg
    obsidian
    kdenlive
    syncthing
    inkscape-with-extensions

    # Rice Stuff
    cava
    wofi
    swww
    dunst
    kooha
    cmatrix
    hyprshot
    fastfetch
    playerctl
    obs-studio
    hyprpicker
    inputs.hyprsunset.packages.${system}.default

    # Fonts
    fira-code
    jetbrains-mono

    # Shell Stuff
    fzf
    fd
    jq
    ripgrep-all
    imagemagick
    poppler
    atuin
    pure-prompt
    oh-my-zsh
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
    git-credential-oauth

    # Miscellaneous
    ollama
    discord-canary
    ani-cli
    mangal
  ];


  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    plugins = [ inputs.hy3.packages.x86_64-linux.hy3 ];
    extraConfig = builtins.readFile (builtins.path {
        path = ./configs/hypr/hyprland.conf;
    });
  };

  programs.ags = {
    enable    = true;
    configDir = ./shell;

    # additional packages to add to gjs's runtime
    extraPackages = [
      inputs.ags.packages.${pkgs.system}.astal3
      inputs.ags.packages.${pkgs.system}.apps
      inputs.ags.packages.${pkgs.system}.mpris
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.tray
    ];
  };

  programs.zoxide = {
    enable               = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable      = true;
    userName    = "n3rdium";
    userEmail   = "n3rdium@gmail.com";
    extraConfig = { credential.helper = "oauth"; };
  };

  gtk = {
    enable = true;

    theme = {
      name    = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };

    iconTheme = {
      name    = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
  };

  qt = {
    enable             = true;
    platformTheme.name = "gtk";
  };

  home.file = {
    ".config/kitty/".source            = ./configs/kitty;
    ".config/fastfetch/".source        = ./configs/fastfetch;
    ".config/cava/".source             = ./configs/cava;
    ".config/atuin/".source            = ./configs/atuin;
    ".config/nvim/lua".source          = ./configs/nvim/lua;
    ".config/nvim/init.lua".source     = ./configs/nvim/init.lua;
    ".config/siril/".source            = ./configs/siril;
    ".zshrc".source                    = ./configs/.zshrc;
    "wallpapers/".source               = ./theming/wallpapers;
    ".hyprshaders/".source             = ./configs/hypr/shaders;
    ".shellassets/".source             = ./shell/assets;
    "n3rdium.jpg".source               = ./n3rdium.jpg;
    "n3rdium.png".source               = ./n3rdium.png;
    "n3rdite.png".source               = ./n3rdite.png;
    "n3rdite.jpg".source               = ./n3rdite.jpg;
  };

  home.sessionVariables = { EDITOR = "zed --wait"; };

  programs.home-manager.enable = true;
}
