{
  description = "Mustafa NixOS Flake Yapilandirmasi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager (unstable kanalı)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix

        # Home Manager NixOS Modülü
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup"; # Mevcut config dosyaların çakışırsa .backup yapıp geçer, hata vermez
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.mustafa = import ./home.nix;
        }
      ];
    };
  };
}
