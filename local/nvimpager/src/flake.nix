{
  description = "Developmet flake for nvimpager";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
#    neovim.inputs.neovim-flake.inputs.nixpkgs.follows = "nixpkgs";
#    neovim.inputs.neovim-flake.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, neovim, ... }: {
    overlay = final: prev: {
      nvimpager = prev.nvimpager.overrideAttrs (oa: {
        version = "dev";
        src = ./.;
        preBuild = "version=$(bash ./nvimpager -v | sed 's/.* //')";
        buildFlags = oa.buildFlags ++ [ "VERSION=\${version}-dev" ];
      });
    };
  }
  //
  flake-utils.lib.eachDefaultSystem (system:
  let
    stable = import nixpkgs { overlays = [ self.overlay ]; inherit system; };
    nightly = import nixpkgs { overlays = [ neovim.overlay self.overlay ]; inherit system; };
    mkShell = pkgs: pkgs.mkShell {
      inputsFrom = [ pkgs.nvimpager ];
      packages = with pkgs; [
        lua51Packages.luacov
        git
        tmux
        hyperfine
      ];
      shellHook = ''
        # to find nvimpager lua code in the current dir
        export LUA_PATH=./?.lua''${LUA_PATH:+\;}$LUA_PATH
        # fix for different terminals in a pure shell
        export TERM=xterm
        '';
      };
  in rec {
    packages = {
      nvimpager = stable.nvimpager;
      nvimpager-with-nightly-neovim = nightly.nvimpager;
    };
    defaultPackage = stable.nvimpager;
    apps.nvimpager = flake-utils.lib.mkApp { drv = stable.nvimpager; name = "nvimpager"; };
    defaultApp = apps.nvimpager;
    devShell = devShells.stable;
    devShells = {
      stable = mkShell stable;
      nightly = mkShell nightly;
    };
  }
  );
}
