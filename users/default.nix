{
  users = {
    extraUsers.ivan = {
      isNormalUser = true;
      uid = 1000;
      createHome = true;
      home = "/home/ivan";
      extraGroups = [
        "docker"
        "networkmanager"
        "wheel"
      ];
      hashedPassword = "$6$WkpnVqs.$w7ssbDvpNB2yaetz83gNCGadcykUJMUL1yDLjmnuviU3mxWTGMfAJ0p88n7bNtd.MFlObMawgmALsVOBSPPXT.";
    };

    mutableUsers = false;
  };
}
