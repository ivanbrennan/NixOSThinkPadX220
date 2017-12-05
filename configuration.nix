# For help, see ‘man configuration.nix’ and ‘nixos-help’.

{ config, pkgs, ... }:

{
  imports =
    [
      ./environment/default.nix
      ./hardware-configuration.nix
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

  programs.bash.enableCompletion = true;

  fonts.fonts = [
    pkgs.source-code-pro
    pkgs.emacs-all-the-icons-fonts
  ];

  services.emacs.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "shift:both_capslock,caps:ctrl_modifier";

  services.xserver.displayManager.sessionCommands = ''
    # tap caps to escape
    xcape -e 'Caps_Lock=Escape' &
  '';

  # Gnome desktop
  services.xserver.desktopManager = {
    gnome3 = {
      enable = true;

      # Figure out why this isn't working
      # extraGSettingsOverrides = ''
      #   [org.gnome.desktop.interface]
      #   gtk-key-theme="Emacs"
      # '';
    };
    default = "gnome3";
  };

  users.extraUsers.ivan = {
    isNormalUser = true;
    uid = 1000;
    createHome = true;
    home = "/home/ivan";
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "$6$WkpnVqs.$w7ssbDvpNB2yaetz83gNCGadcykUJMUL1yDLjmnuviU3mxWTGMfAJ0p88n7bNtd.MFlObMawgmALsVOBSPPXT.";
  };
  users.mutableUsers = false;

  nix.gc.automatic = true;
  nix.gc.dates = "03:15";

  system.autoUpgrade.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?
}
