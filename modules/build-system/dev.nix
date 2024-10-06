{
  inputs,
  lib,
  ...
}: {
  config.perSystem = {
    config,
    inputs',
    pkgs,
    ...
  }: {
    nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
    devShells.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs;
        [
          lefthook
        ]
        ++ config.linters
        ++ config.formatterPackages;
    };
  };
}
