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
