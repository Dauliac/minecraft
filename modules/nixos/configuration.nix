{ ... }: {
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
}
