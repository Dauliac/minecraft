{
  lib,
  inputs,
  ...
}: let
  inpt = inputs;
in {
  config.perSystem = {pkgs, ...}: {
    packages = {
      dev = pkgs.nixosTest {
        name = "test-infra-nixos";
        nodes.nixos = {config, ...}: {
          imports = [
            inputs.nix-minecraft.nixosModules.minecraft-servers
            inputs.comin.nixosModules.comin
            ../nixos/configuration.nix
          ];
          services.openssh.settings.PermitRootLogin = "yes";
          services.xserver.displayManager.autoLogin.enable = true;
          services.xserver.displayManager.autoLogin.user = "root";
          services.xserver.displayManager.gdm.enable = lib.mkForce false;
          virtualisation = {
            graphics = true;
            qemu.options = ["-vga none -device virtio-gpu-pci"];
            # NOTE: these are finetuned for my personal computer only
            memorySize = 3000;
            cores = 5;
            sharedDirectories = {
              sources = {
                source = builtins.toString ../../.;
                target = "/mnt/sources";
              };
            };
          };
        };
        testScript = ''
          nixos.succeed("ls")
        '';
      };
    };
  };
}
