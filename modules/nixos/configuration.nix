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
    vim
  ];
  networking.firewall.enable = true;
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    # DOCS: https://github.com/Infinidoge/nix-minecraft/issues/119
    managementSystem.systemd-socket.enable = true;

    servers.leschiens = {
      enable = true;
      autoStart = true;
      package = pkgs.paperServers.paper-1_21_4;
      whitelist = {
        Dauliac = "ea017fcd-02a7-4b04-9895-7e11eb58c529";
        aaronky = "69d16278-23bb-491b-b7a3-11c0c17d9a73";
        Walalak = "f70899d1-3d0e-4d70-9a68-bf535c196eea";
        abitbolide = "d794f148-e9d8-4dfe-90d4-4ed6c5fd38f5";
        Happinessmanager = "bda029c5-cc14-42c2-9347-cc24ebb4a0bc";
      };
      symlinks = {
        "ops.json" = {
          value = [
            {
              uuid = "d794f148-e9d8-4dfe-90d4-4ed6c5fd38f5";
              name = "abitbolide";
              level = 4;
              bypassesPlayerLimit = false;
            }
            {
              uuid = "f70899d1-3d0e-4d70-9a68-bf535c196eea";
              name = "Walalak";
              level = 4;
              bypassesPlayerLimit = false;
            }
            {
              uuid = "bda029c5-cc14-42c2-9347-cc24ebb4a0bc";
              name = "Happinessmanager";
              level = 4;
              bypassesPlayerLimit = false;
            }
            {
              uuid = "69d16278-23bb-491b-b7a3-11c0c17d9a73";
              name = "aaronkyd";
              level = 1;
              bypassesPlayerLimit = false;
            }
            {
              uuid = "ea017fcd-02a7-4b04-9895-7e11eb58c529";
              name = "Dauliac";
              level = 4;
              bypassesPlayerLimit = false;
            }
          ];
        };

        # plugins = pkgs.linkFarmFromDrvs "plugins" (builtins.attrValues {
        #   worldedit = pkgs.fetchurl {
        #     url = "https://cdn.modrinth.com/data/1u6JkXh5/versions/txgouwkE/worldedit-bukkit-7.3.14.jar";
        #     sha512 = "562c87a50f380c6cd7312f90b957f369625b3cf5f948e7bee286cd8075694a7206af4d0c8447879daa7a3bfe217c5092a7847247f0098cb1f5417e41c678f0c1";
        #   };
        # });
      };

      serverProperties = {
        motd = "Les chiens";
        # online-mode = false;
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
  };
}
