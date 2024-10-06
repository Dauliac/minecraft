{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "les-chiens";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICB4/43J0s1YooaIDSVhq0tLKRaEJpQsUZ1ttzCJziuJ dauliac@nixos''
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAI55gPg4K1YzSzJi2kjo6n6V+BtqtJjMku4qujFsKAb aurelien.satger@fake''
  ];
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
    unzip
    fd
    nvim
  ];
  networking.firewall.enable = true;
  services.minecraft-server = {
    enable = true;
    eula = true;
    package = pkgs.paperServers.paper-1_21_1;
    openFirewall = true;
    dataDir = "/srv/minecraft";

    whitelist = {
      dauliac = "ea017fcd-02a7-4b04-9895-7e11eb58c529";
      aaronky = "69d16278-23bb-491b-b7a3-11c0c17d9a73";
    };
    serverProperties = {
      motd = "Les chiens";
      online-mode = false;
      white-list = true;
      max-players = 4;
      difficulty = "normal";
      gamemode = "survival";
      # enable-rcon = true;
      # "rcon.password" = "longview";
      view-distance = 64;
      simulation-distance = 32;
      spawn-protection = 5;
      allow-flight = true;
    };
  };
}
