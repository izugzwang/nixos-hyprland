{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos/dots";
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.username = "mustafa";
  home.homeDirectory = "/home/mustafa";
  home.stateVersion = "24.11";

  xdg.configFile = {
    "hypr".source = link "${dotfiles}/hypr";
    "waybar".source = link "${dotfiles}/waybar";
    "rofi".source = link "${dotfiles}/rofi";
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
    };
    gtk4.theme = config.gtk.theme;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Maple Mono Normal";
      size = 12;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      monospace-font-name = "Maple Mono Normal 12";
    };
  };

  home.packages = with pkgs; [
    (brave.override {
      commandLineArgs = "--enable-blink-features=MiddleClickAutoscroll --ozone-platform=wayland";
    })
    spotify
    vesktop
    thunar
    pavucontrol
    waypaper
    neovim
    gh
    ripgrep
    fd
    gcc
    gnumake
    nodejs
    lua-language-server
    stylua
    nixd
    nixfmt
    kitty
    waybar
    rofi
    awww
    wl-clipboard
    cliphist
    wl-clip-persist
    grim
    slurp
    grimblast
    hyprpicker
    wf-recorder
    brightnessctl
    networkmanagerapplet
    swaynotificationcenter
    libnotify
    btop
    fastfetch
  ];

  home.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/nixos#nixos";
    nconf = "nvim ~/nixos/configuration.nix";
    hmconf = "nvim ~/nixos/home.nix";
    hconf = "nvim ~/nixos/dots/hypr/hyprland.conf";
  };

  programs.bash.enable = true;
  programs.home-manager.enable = true;
}
