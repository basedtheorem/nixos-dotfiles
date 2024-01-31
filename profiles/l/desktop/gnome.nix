{pkgs, ...}: {
  # TODO: Put dconf2nix output here, backup gnome keybinds and misc conf.

  xdg.configFile."paperwm/user.css".source = ../sources/paperwm.css;

  home.packages = with pkgs; [
    qogir-icon-theme
    flat-remix-icon-theme
    flat-remix-gnome
    flat-remix-gtk
  ];

  home.sessionVariables.GTK_THEME = "Flat-Remix-GTK-Red-Darkest-Solid";

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    cursorTheme.name = "Qogir";
    iconTheme.name = "Flat-Remix-Red-Dark";
    theme.name = "Flat-Remix-GTK-Red";
  };
}
