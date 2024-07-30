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
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # User account
  users.users.aryan = {
    isNormalUser = true;
    description = "Aryan Singh";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Automatic login
  services.getty.autologinUser = "aryan";

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable dconf
  programs.dconf.enable = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Touchpad support
  services.xserver.libinput.enable = true;

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
    thunar
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
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
    noto-fonts-emoji
  ];

  # GTK Theme
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name = Dracula
    gtk-icon-theme-name = Dracula
  '';

  # OpenSSH
  services.openssh.enable = true;

  # Printing
  services.printing.enable = true;

  # Flatpak
  services.flatpak.enable = true;

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
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.aryan = import ./home.nix;

  # State version
  system.stateVersion = "24.05";
}
