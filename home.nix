{ config, pkgs, ... }:

let
  # Dotfiles klasörünü canlı (düzenlenebilir) bağlamak için kısayol
  dotfiles = "${config.home.homeDirectory}/nixos/dots";
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.username = "mustafa";
  home.homeDirectory = "/home/mustafa";
  home.stateVersion = "24.11"; # Sakın değiştirme

  # ~/nixos/dots içindeki klasörleri ~/.config altına canlı symlink yapar
  # Dosyaları değiştirdiğinde rebuild yapmana gerek kalmaz!
  xdg.configFile = {
    "hypr".source = link "${dotfiles}/hypr";
    "waybar".source = link "${dotfiles}/waybar";
    "rofi".source = link "${dotfiles}/rofi";
  };

home.pointerCursor = {
    enable = true; # Uyarıyı susturmak için eklendi
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };



  # İmleç Ayarları (Hem GTK hem Hyprland/Wayland için)
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # GTK Tema, İkon ve Font Ayarları (configuration.nix'te bozuk yazdığın yerin doğrusu)
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

  # Sadece senin kullanacağın masaüstü ve geliştirme paketleri
  home.packages = with pkgs; [
    # Uygulamalar (Kopyalar temizlendi)
    (brave.override {
      commandLineArgs = "--enable-blink-features=MiddleClickAutoscroll --ozone-platform=wayland";
    })
    spotify
    vesktop
    thunar
    pavucontrol
    waypaper

    # Geliştirme ve LSP
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

    # Hyprland & Masaüstü Araçları
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

  # Kısayollar (Alias)
  home.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/nixos#nixos";
    nconf = "nvim ~/nixos/configuration.nix";
    hmconf = "nvim ~/nixos/home.nix";
    hconf = "nvim ~/nixos/dots/hypr/hyprland.conf"; # .lua saçmalığı düzeltildi
  };

  programs.bash.enable = true; # Kısayolların çalışması için kabuğu HM yönetmeli
  programs.home-manager.enable = true;
}
