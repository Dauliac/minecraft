{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    # ./networking.nix # generated at runtime by nixos-infect
    ./minecraft.nix
  ];
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "les-chiens";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICB4/43J0s1YooaIDSVhq0tLKRaEJpQsUZ1ttzCJziuJ dauliac@nixos'' ];
  system.stateVersion = "23.11";
  nix = {
    settings = {
      system-features = [
        "benchmark"
        "big-parallel"
        "nixos-test"
      ];
      experimental-features = ["nix-command" "flakes"];
    };
    optimise.automatic = true;
    gc = {
      automatic = true;
      persistent = true;
      dates = "012:15";
      options = "-d";
    };
  };
  environment.systemPackages = with pkgs; [
    git
    curl
    htop
    systemctl-tui
  ];
  networking.firewall.enable = true;
  services.minecraft-server = {
    enable = true;
    eula = true;
    package = pkgs.paperServers.paper-1_20_1;
    openFirewall = true;
    dataDir = "/srv/minecraft";

    # whitelist = {
    # };
    serverProperties = {
      motd = "Les chiens";
      server-port = 43000;
      online-mode = false;
      max-players = 2;
      difficulty = "normal";
      gamemode = "survival";
      enable-rcon = true;
      "rcon.password" = "longview";
      view-distance = 20;
      simulation-distance = 20;
      spawn-protection = 5;
      allow-flight = true;
    };
  };
}
