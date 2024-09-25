{ pkgs, lib, ... }:
let
  nord0 = "#2e3440";
  nord1 = "#3b4252";
  nord2 = "#434c5e";
  nord3 = "#4c566a";
  nord4 = "#d8dee9";
  nord5 = "#e5e9f0";
  nord6 = "#eceff4";
  nord7 = "#8fbcbb";
  nord8 = "#88c0d0";
  nord9 = "#81a1c1";
  nord10 = "#5e81ac";
  nord11 = "#bf616a";
  nord12 = "#d08770";
  nord13 = "#ebcb8b";
  nord14 = "#a3be8c";
  nord15 = "#b48ead";
  block1 = "[░▒▓](${nord4})$os$username$hostname[](bg:${nord3} fg:${nord4})";
  block2 = "$directory[](fg:${nord3} bg:${nord2})";
  block3 = "$git_branch$git_status[](fg:${nord2} bg:${nord3})";
  block4 = "$c$elixir$elm$golang$haskell$java$julia$nodejs$nim$rust$golang$php[](fg:${nord3} bg:${nord8})";
  block5 = "$time$status[](fg:${nord8})\n";
  block6 = "$character";
in
{
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [ block1 block2 block3 block4 block5 block6 ];
      command_timeout = 1000;
      # You can also replace your username with a neat symbol like  to save some space
      username = {
        show_always = true;
        style_user = "bg:${nord4} fg:${nord3}"; #3B4252"
        style_root = "bg:${nord11}";
        format = "[$user ]($style)";
      };
      hostname = {
        ssh_only = false;
        ssh_symbol = "󰣀 ";
        format = "[$ssh_symbol](bold ${nord3})[󰹻 $hostname](bold fg:${nord3} bg:${nord4})";
      };
      status = {
        disabled = false;
        format = "[ $symbol(bold ${nord11}) $status]($style)";
        symbol = "";
        success_symbol = "";
        not_executable_symbol = "";
        not_found_symbol = "";
        sigint_symbol = "";
        signal_symbol = "󱍖";
        style = "fg:${nord11} bg:${nord8}";


      };
      directory = {
        style = "fg:${nord14} bg:${nord3}";
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
        style = "bg:${nord2}";
        format = "[[ $symbol $branch ](fg:${nord13} bg:${nord2})]($style)";
      };
      git_status = {
        style = "bg:${nord14}";
        format = "[[($all_status$ahead_behind )](fg:${nord13} bg:${nord2})]($style)";
      };
      nodejs = {
        symbol = "";
        style = "bg:${nord3}";
        format = "[[ $symbol ($version) ](fg:${nord9} bg:${nord3})]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:${nord3}";
        format = "[[ $symbol ($version) ](fg:${nord9} bg:${nord3})]($style)";
      };
      golang = {
        symbol = "";
        style = "bg:${nord3}";
        format = "[[ $symbol ($version) ](fg:${nord9} bg:${nord3})]($style)";
      };
      php = {
        symbol = " ";
        style = "bg:${nord3}";
        format = "[[ $symbol ($version) ](fg:${nord9} bg:${nord3})]($style)";
      };
      time = {
        disabled = true;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:${nord8}";
        format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
      };
      c = {
        symbol = " ";
        style = "bg:${nord3}";
        format = "[ $symbol ($version) ]($style)";
      };
      docker_context = {
        symbol = " ";
        style = "bg:${nord3}";
        format = "[ $symbol $context ]($style) $path";
      };
      elixir = {
        symbol = " ";
        style = "bg:${nord3}";
        format = "[ $symbol ($version) ]($style)";
      };
      elm = {
        symbol = " ";
        style = "bg:${nord3}";
        format = "[ $symbol ($version) ]($style)";
      };
      haskell = {
        symbol = " ";
        style = "bg:${nord3}";
        format = "[ $symbol ($version) ]($style)";
      };
      java = {
        symbol = " ";
        style = "bg:${nord3}";
        format = "[ $symbol ($version) ]($style)";
      };
      julia = {
        symbol = " ";
        style = "bg:${nord3}";
        format = "[ $symbol ($version) ]($style)";
      };
      nim = {
        symbol = " ";
        style = "bg:${nord3}";
        format = "[ $symbol ($version) ]($style)";
      };
      os = {
        disabled = false;
        style = "bg:${nord4} fg:${nord3}";
        format = "[ $symbol ]($style)";
        symbols = {
          Arch = "󰣇";
          Macos = "";
        };
      };
    };
  };

}
