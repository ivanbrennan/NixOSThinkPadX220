# For help, see ‘man configuration.nix’ and ‘nixos-help’.

{ config, pkgs, ... }:

{
  imports =
    [
      ./environment/default.nix
      ./hardware-configuration.nix
      ./programs/default.nix
      ./services/default.nix
      ./users/default.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sda2";
      preLVM = true;
    }
  ];

  networking.hostName = "littleThinkPad";

  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/New_York";

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;

  fonts.fonts = [
    pkgs.source-code-pro
    pkgs.emacs-all-the-icons-fonts
  ];

  nix.gc.automatic = true;
  nix.gc.dates = "03:15";

  system.autoUpgrade.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?
}
