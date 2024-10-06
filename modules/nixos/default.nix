{inputs, ...}: {
  config = {
    flake.nixosConfigurations.les-chiens = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.nix-minecraft.nixosModules.minecraft-servers
        inputs.comin.nixosModules.comin
        ./configuration.nix
        ./hardware-configuration.nix
        {
          nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
        }
      ];
    };
  };
}
