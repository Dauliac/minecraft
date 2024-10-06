{pkgs, ...}: {
  services.minecraft-servers.servers.les-chiens = {
    enable = true;
    eula = true;
    package = pkgs.paperServers.paper-1_20_1;
    autoStart = true;
    openFirewall = true;


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
