{ config, pkgs, ... }:

{
  home.username = "aryan";
  home.homeDirectory = "/home/aryan";

  home.packages = with pkgs; [
    htop
    ripgrep
    fzf
    bat
    delta
  ];

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  programs = {
    git = {
      enable = true;
      userName = "geneticglitch";
      userEmail = "s.aryan0327@gmail.com";
    };

    bash = {
      enable = true;
      shellAliases = {
        ll = "exa -l";
        la = "exa -la";
      };
      initExtra = ''
        eval "$(starship init bash)"
      '';
    };

    starship.enable = true;

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
      ];
    };
  };

  xdg.configFile = {
    "hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;
    "hypr/xdg-portal-hyprland".source = ./dotfiles/hypr/xdg-portal-hyprland;
    "kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
    "kitty/mocha.conf".source = ./dotfiles/kitty/mocha.conf;
    "mako/config".source = ./dotfiles/mako/config;
    "swaylock/config".source = ./dotfiles/swaylock/config;
    "waybar/config".source = ./dotfiles/waybar/config.jsonc;
    "waybar/style.css".source = ./dotfiles/waybar/style.css;
    "wofi/config".source = ./dotfiles/wofi/config;
    "wofi/style.css".source = ./dotfiles/wofi/style.css;
  };

  services.mako.enable = true;

  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/kitty/kitty.conf;
  };

  programs.waybar.enable = true;
}
