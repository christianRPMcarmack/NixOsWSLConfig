{ config, lib, pkgs, ... }:

{
  imports = [
    # Include NixOS-WSL modules
	    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "ccarmack";

  system.stateVersion = "23.11";
  
  virtualisation.docker.enable = true;
  users.users."ccarmack".extraGroups = [ "docker" ];

  nix.extraOptions = ''experimental-features = nix-command flakes'';

  # Add build inputs directly to the environment
  environment.systemPackages = with pkgs; [
    openssl
    pkg-config
    eza
    fd
    neovim
    xclip
    git
    wget
    home-manager
    openssl
    htop
    pkg-config
    ripgrep
    lazygit
    bat
    nh
    dust
  ];
  
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 22 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };

  # Define shell aliases directly in the user environment
  environment.shellAliases = {
    ls = "eza";
    find = "fd";
    lg = "lazygit";
    cat = "bat -p";
  };

  programs.git.config = {
    user.name = "ccarmack";
    user.email = "christian.carmack@outlook.com";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
 
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "bira";
    };
  };

}
