{pkgs,...}:
{
   programs.neovim = {
enable = true;
viAlias = true;
vimAlias = true;
vimdiffAlias = true;
extraLuaConfig = ''
${builtins.readFile ./plugins/options.lua}
'';
};
imports = [ ./plugins.nix ./packages.nix ];
}
