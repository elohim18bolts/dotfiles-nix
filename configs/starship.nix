{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        [░▒▓](#a3aed2)$os$username$hostname[](bg:#769ff0 fg:#a3aed2)$directory[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$c$elixir$elm$golang$haskell$java$julia$nodejs$nim$rust$golang$php[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)
        $character'';
      command_timeout = 1000;
      # You can also replace your username with a neat symbol like  to save some space
      username = {
        show_always = true;
        style_user = "bg:#a3aed2 fg:#090c0c"; #3B4252"
        style_root = "bg:#3B4252";
        format = "[$user ]($style)";
      };
      hostname = {
        ssh_only = false;
        ssh_symbol = "󰣀 ";
        format = "[$ssh_symbol](bold blue)[󰹻 $hostname](bold fg:#04029e bg:#a3aed2)";
      };
      directory = {
        style = "fg:#e3e5e5 bg:#769ff0";
        format = "[ $path ]($style)";
        truncation_length = 10;
        truncation_symbol = "󰇘/";
        home_symbol = "";
        substitutions = {
          "Documents" = "";
          "Downloads" = "";
          "Music" = "";
          "Pictures" = "";
        };
      };
      git_branch = {
        symbol = "";
        style = "bg:#394260";
        format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
      };
      git_status = {
        style = "bg:#394260";
        format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
      };
      nodejs = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      golang = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      php = {
        symbol = " ";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      time = {
        disabled = true;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:#1d2230";
        format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
      };
      c = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };
      docker_context = {
        symbol = " ";
        style = "bg:#06969A";
        format = "[ $symbol $context ]($style) $path";
      };
      elixir = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };
      elm = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };
      haskell = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };
      java = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };
      julia = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };
      nim = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };
      os = {
        disabled = false;
        style = "bg:#a3aed2 fg:#090c0c";
        format = "[ $symbol ]($style)";
        symbols = {
          Arch = "󰣇";
          Macos = "";
        };
      };
    };
  };

}
