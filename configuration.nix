{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader (systemd-boot)
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel ve Zram Swap
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  zramSwap.enable = true;

  # Ağ ve Hostname
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Zaman Dilimi ve Türkçe Dil/Klavye Ayarları
  time.timeZone = "Europe/Istanbul";
  i18n.defaultLocale = "en_US.UTF-8"; # Sistem dili İngilizce (hataları aratmak için en iyisi), formatlar Türkçe
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };
  console.keyMap = "trq";

  # Ses (PipeWire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Donanım, Grafik ve NVIDIA (RTX 4060)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true; # RTX 40 serisi için önerilen açık kaynak modül
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Hyprland ve Giriş Yöneticisi (tuigreet)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extest.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.gamemode.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # GTK tema, ikon, imleç ve font ayarları
  programs.dconf = {
    enable = true;

     };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd 'uwsm start hyprland-uwsm.desktop'";
        user = "greeter";
      };
    };
  };

  # Nix Flakes ve Özgür Olmayan Paket İzni
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Standart Linux binary'lerinin (Mason vb.) çalışması için hayat kurtarıcı nix-ld
  programs.nix-ld.enable = true;

  # Kullanıcı Tanımı
  users.users.mustafa = {
    isNormalUser = true;
    description = "Mustafa";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
    ];
    initialPassword = "123"; # İlk girişte 'passwd' komutuyla değiştireceksin
  };

  # Sistem Paketleri (Hyprland + Neovim + Lua Geliştirme Seti)
  environment.systemPackages = with pkgs; [
    # Editör ve Derleme/Arama Araçları
    neovim
    git
    wget
    curl
    ripgrep
    fd
    unzip
    gcc
    gnumake
    nodejs
    # discord
    spotify
    vesktop # modlu discord
    gh
    # UYGULAMALAR

    spotify
    vesktop # modlu discord
    glib
    gsettings-desktop-schemas
    btop

    # Lua ve Nix LSP / Formatlayıcılar (Neovim'de doğrudan hazır!)
    lua-language-server
    stylua
    nixd # Nix dili için LSP
    nixfmt
    # Hyprland ve Masaüstü Araçları
    kitty
    waybar
    rofi
    awww
    waypaper
    wl-clipboard
    grim
    slurp
    pavucontrol
    brightnessctl
    networkmanagerapplet
    btop
    fastfetch
    # Pano geçmişi
    cliphist
    wl-clip-persist

    # Ekran görüntüsü, renk seçici ve kayıt
    grimblast
    hyprpicker
    wf-recorder
    # GTK teması, ikonlar ve imleç
    colloid-gtk-theme
    papirus-icon-theme
    bibata-cursors

    # Bildirim merkezi
    swaynotificationcenter
    libnotify
    # Tarayıcı ve Dosya Yöneticisi
    (brave.override {
      commandLineArgs = "--enable-blink-features=MiddleClickAutoscroll --ozone-platform=wayland";
    })
    thunar
  ];

  # Fontlar (Neovim ikonları için Nerd Fonts şart)
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    maple-mono.Normal-TTF
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  system.stateVersion = "24.11"; # Bunu ileride de değiştirme

  }
