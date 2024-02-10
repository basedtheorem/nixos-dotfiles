{ pkgs, inputs, lib, self, ... }: {
  imports = [
    ./apps/fish.nix
    ./apps/git.nix
    ./apps/gitui.nix
    ./apps/vivaldi.nix
    ./apps/mpv.nix
    ./apps/obsidian.nix
    ./apps/spicetify.nix
    ./apps/sioyek.nix # PDF
    ./apps/emacs.nix
    ./apps/discord.nix
    ./apps/vscodium.nix
    ./apps/micro.nix
    ./apps/firefox.nix
    ./apps/kakoune.nix
    ./apps/yazi.nix
    ./apps/kitty.nix

    ./desktop/gnome.nix
    ./desktop/flatpak.nix
    ./desktop/obs.nix

    ./services/picom.nix
    ./services/opensnitch.nix
    ./services/espanso.nix
    ./services/ulauncher.nix
    ./services/syncthing.nix
    ./services/flameshot.nix
    ./services/xbanish.nix
    ./services/sxhkd.nix
  ];

  home = {
    username = "l";
    homeDirectory = "/home/l";
    stateVersion = "22.11";
  };

  home.packages = builtins.attrValues {
    # CLI
    inherit (pkgs)
      ripgrep
      grex # generate regex
      procs # ps alt
      dua # disk usage
      tokei # sloc
      sd # sed
      ruplacer # find and replace
      skim # fzf
      hyperfine # benchmarking tool
      file
      fd
      onefetch # neofetch but for git repos
      btop # system monitor
      bandwhich # display network utilisation
      tealdeer
      ttyper # typing practice
      bat
      jq
      wget
      neofetch
      starship
      pipe-rename
      zoxide
      eza
      glow
      fuc # rmz cpz
      fontpreview
      broot # interactive tree
      kalker
      p7zip
      difftastic

    # ------------------------------------------ #

    # Desktop
      gifski
      gcolor3 # colour picker
      freetube
      bitwarden
      xclip
      imagemagick
      flameshot
      gimp
      qbittorrent
      xbanish
      chromium
      uhk-agent
      cpu-x
      vivaldi-ffmpeg-codecs
      anki
      cryptomator
      syncthing
      libreoffice
      woeusb-ng;
    inherit (pkgs.xorg)
      xset
      xev;

    # ------------------------------------------ #

    # Media
    inherit (pkgs)
      ffmpeg-full
      yt-dlp
      alsa-utils
      playerctl

    # ------------------------------------------ #

    # Dev
      git-filter-repo
      just
      nixd
      cachix
      nixfmt
      # `echo "GET <link>" | hurl -o ./out`
      hurl
      # `entr -rs <files> <commands>`
      # run commands on file change, -r(eload on each change), -s(hell envvar)
      entr;
    inherit (pkgs.bat-extras)
      batgrep;

  };

  programs = {
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    home-manager.enable = true;
  };

  nixpkgs = {
    overlays = [
      self.overlays.micro
      inputs.rust-overlay.overlays.default
      inputs.emacs-overlay.overlays.emacs
    ];
    config.allowUnfree = true;
  };

  news.display = lib.mkForce "silent";
  news.json = lib.mkForce { };
  news.entries = lib.mkForce [ ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xsession.enable = true;
  # systemd.user.startServices = true; # fixes warning: 'systemd user session is degraded'
}
