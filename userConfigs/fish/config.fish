# mkcd
function mkcd
  set dir $argv[1]

  # mkcd temp dir if no args
  if test -z $dir
    cd (mktemp -d /tmp/tmp.XXXX)
    return 0
  end

  mkdir -p $dir
  cd $dir
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
fish_add_path -g ~/.local/bin
fish_add_path -g ~/.cargo/bin

if status is-interactive
    # set colors
    set -g fish_color_autosuggestion brblack
    set -g fish_color_cancel --reverse
    set -g fish_color_command --reset
    set -g fish_color_comment red
    set -g fish_color_cwd green
    set -g fish_color_cwd_root red
    set -g fish_color_end green
    set -g fish_color_error brred
    set -g fish_color_escape brcyan
    set -g fish_color_history_current --bold
    set -g fish_color_host --reset
    set -g fish_color_host_remote yellow
    set -g fish_color_normal --reset
    set -g fish_color_operator brcyan
    set -g fish_color_param cyan
    set -g fish_color_quote yellow
    set -g fish_color_redirection 'cyan' '--bold'
    set -g fish_color_search_match 'white' '--bold' '--background=brblack'
    set -g fish_color_selection 'white' '--bold' '--background=brblack'
    set -g fish_color_status red
    set -g fish_color_user brgreen
    set -g fish_color_valid_path --underline=single
    set -g fish_pager_color_description 'yellow' '--italics'
    set -g fish_pager_color_prefix '--bold' '--underline=single'
    set -g fish_pager_color_progress 'brwhite' '--bold' '--background=cyan'
    set -g fish_pager_color_selected_background --reverse

    # abbrs
    abbr -a -- bltcl "bluetoothctl"
    abbr -a -- cl "clear"
    abbr -a -- clf "clear; fastfetch"
    abbr -a -- clg "clear; fish_greeting"
    abbr -a -- l "eza -lg"
    abbr -a -- la "eza -lga"
    abbr -a -- ll "eza -lga"
    abbr -a -- ln "ln -s"
    abbr -a -- ls "eza -F=always"
    abbr -a -- lt "eza -lga --sort=modified"
    abbr -a -- mkdir "mkdir -p"
    abbr -a -- n "nvim"
    abbr -a -- nn "nvim (sk)"
    abbr -a -- rc "rmpc"
    abbr -a -- systl "systemctl"
    abbr -a -- tree "eza -TF=always"
    abbr -a -- za "zathura"
    abbr -a -- zz "zathura (sk) &"

    # addon startups
    atuin init fish | source
    starship init fish | source
    zoxide init fish | source

    # manual startup
    fastfetch
end
