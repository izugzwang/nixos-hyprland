{
  description = "Mustafa NixOS Flake Yapilandirmasi";

  inputs = {
    # Resmi NixOS paket deposu (Unstable - en güncel paketler için)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}

