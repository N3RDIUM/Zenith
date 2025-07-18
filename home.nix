{ inputs, pkgs, ... }:

{
	imports = [ inputs.ags.homeManagerModules.default ];

	home.username = "n3rdium";
	home.homeDirectory = "/home/n3rdium";
	home.stateVersion = "24.05"; # Please don't touch

	home.packages = with pkgs; [
		# Essentials
		superfile
		xfce.thunar
		zathura
		kdePackages.okular
		gcr
		inputs.zen-browser.packages."${system}".specific
        wayvnc
        btop
        gnome-pomodoro

		# Astro
        # gimp # Won't build, currently installed using nix-env.
		wine64Packages.wayland
		stellarium
        kdePackages.filelight

		# Code
		trashy
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

		# Pwnage
		wireshark

		# Music
        lmms
		audacity
		pavucontrol
		youtube-music

		# Prod
		ffmpeg
		kdePackages.kdenlive
		blender
		obsidian

		# Rice Stuff
		cava
		wofi
		swww
		kooha
		cmatrix
		pipes-rs
		hyprshot
		fastfetch
		libnotify
		hollywood
		playerctl
		obs-studio
		hyprpicker

		# Fonts
		iosevka-bin
		font-awesome

		# Shell Stuff
		sl
		fzf
		atuin

		# Oxidised shell stuff
		starship
		zoxide
		fd
		du-dust
		ripgrep
		ripgrep-all
		tokei
		mprocs

		# Miscellaneous
        # ollama
		discord
		ani-cli
		mangal

        # Shell stuff
        inputs.astal.packages.${pkgs.system}.io
        inputs.astal.packages.${pkgs.system}.notifd
	];

	wayland.windowManager.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		extraConfig = builtins.readFile (builtins.path {
			path = ./configs/hypr/hyprland.conf;
		});
	};

	programs.ags = {
		enable = true;
		configDir = ./shell;
		extraPackages = [
			inputs.ags.packages.${pkgs.system}.notifd
		];
	};

    i18n.inputMethod = {
        type = "fcitx5";
        enable = true;
        fcitx5 = {
            waylandFrontend = true;
            addons = with pkgs; [
                fcitx5-mozc
                fcitx5-gtk
            ];
        };
    };

	programs.git = {
		enable = true;
		userName = "n3rdium";
		userEmail = "n3rdium@gmail.com";
		extraConfig = {
			credential.helper = "${
				pkgs.git.override { withLibsecret = true; }
			}/bin/git-credential-libsecret";
		};
	};

	gtk = {
		enable = true;

		theme = {
			name = "Gruvbox-Dark";
			package = pkgs.gruvbox-gtk-theme;
		};

		iconTheme = {
			name = "oomox-gruvbox-dark";
			package = pkgs.gruvbox-dark-icons-gtk;
		};
	};

	qt = {
		enable = true;
		platformTheme.name = "gtk";
	};

	home.file = {
		".config/kitty/".source = ./configs/kitty;
		".config/fastfetch/".source = ./configs/fastfetch;
		".config/cava/".source = ./configs/cava;
		".config/atuin/".source = ./configs/atuin;
		".config/nvim/lua".source = ./configs/nvim/lua;
		".config/nvim/init.lua".source = ./configs/nvim/init.lua;
		".config/siril/".source = ./configs/siril;
		".config/superfile/".source = ./configs/superfile;
		"wallpapers/".source = ./theming/wallpapers;
		".zenithassets/".source = ./assets;
		".zenithscripts/".source = ./scripts;
		".config/fish/config.fish".source = ./configs/config.fish;
	};

	home.sessionVariables = { EDITOR = "nvim"; };
	services.gnome-keyring.enable = true;
	programs.home-manager.enable = true;
}
