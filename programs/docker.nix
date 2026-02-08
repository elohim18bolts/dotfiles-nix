{ pkgs, config, ... }: {
  programs.docker-cli = {
    enable = true;
    settings = {
      "auths" = { };
      "hosts" = [
        "unix:///${config.home.homeDirectory}/.lima/docker/sock/docker.sock"
      ];
    };
  };
}
