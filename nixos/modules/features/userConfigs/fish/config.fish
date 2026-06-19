# fish_greeting
function fish_greeting
    fastfetch
end

# yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end

# env vars
set -Ux VISUAL nvim
set -Ux EDITOR nvim
set -Ux MANPAGER "nvim +Man!"

# user paths
fish_add_path -g ~/.cargo/bin

if status is-interactive
    # abbrs
    abbr -a -- bltcl "bluetoothctl"
    abbr -a -- cl "clear"
    abbr -a -- clf "clear; fastfetch"
    abbr -a -- clg "clear; fish_greeting"
    abbr -a -- l "eza -lg"
    abbr -a -- la "eza -lga"
    abbr -a -- ll "eza -lga"
    abbr -a -- ln "ln -s"
    abbr -a -- ls "eza -F"
    abbr -a -- lt "eza -lga --sort=modified"
    abbr -a -- mkdir "mkdir -p"
    abbr -a -- n "nvim"
    abbr -a -- nn "nvim (sk)"
    abbr -a -- rc "rmpc"
    abbr -a -- systl "systemctl"
    abbr -a -- tree "eza -TF"
    abbr -a -- za "zathura"
    abbr -a -- zz "zathura (sk) &"

    # addon startups
    atuin init fish | source
    starship init fish | source
    zoxide init fish | source
end
