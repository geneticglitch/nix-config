{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  # Time zone
  time.timeZone = "America/Chicago";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # X11 keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # User account
  users.users.aryan = {
    isNormalUser = true;
    description = "Aryan Singh";
    extraGroups = [ "networkmanager" "wheel" "audio" "libvirtd" "kvm" ];
    packages = with pkgs; [];
  };

  # Automatic login
  services.getty.autologinUser = "aryan";

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable Thunar
  programs.thunar.enable = true;

  # Enable dconf
  programs.dconf.enable = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Touchpad support
  services.libinput.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    kitty
    waybar
    swaybg
    swaylock-effects
    wofi
    wlogout
    mako
    polkit_gnome
    python3
    starship
    swappy
    grim
    slurp
    pamixer
    brightnessctl
    gvfs
    bluez
    bluez-tools
    lxappearance
    xfce.xfce4-settings
    dracula-theme
    dracula-icon-theme
    xdg-desktop-portal-hyprland
    neofetch
    git
    firefox
    vscode
    github-desktop
    obs-studio
    alsa-utils
    pavucontrol
    virt-manager
    qemu_full
    libvirt
    spice-vdagent
  ];

  #qemu
    virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  security.polkit.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["VictorMono"]; })
    victor-mono
    noto-fonts-emoji
  ];

  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Victor Mono" ];
      sansSerif = [ "Victor Mono" ];
      serif = [ "Victor Mono" ];
    };
    
    localConf = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <match target="font">
          <test name="family" compare="contains">
            <string>Victor Mono</string>
          </test>
          <edit name="weight" mode="assign">
            <const>semibold</const>
          </edit>
        </match>
      </fontconfig>
    '';
  };

  # GTK Theme
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name = Dracula
    gtk-icon-theme-name = Dracula
  '';

  # OpenSSH
  services.openssh.enable = true;

  # Power profiles daemon
  services.power-profiles-daemon.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nix settings
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Home Manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.aryan = { pkgs, ... }: {
      home.stateVersion = "24.05";
      imports = [ ./home.nix ];
    };
  };

  # Enable ALSA
  hardware.enableAllFirmware = true;

  # Enable realtime capabilities for audio users
  security.rtkit.enable = true;

  # State version
  system.stateVersion = "24.05";
}
