$env.config.show_banner = false
$env.config.table.mode = "psql"
$env.config.completions.algorithm = "fuzzy"
$env.VISUAL = "nvim"
$env.EDITOR = "nvim"
$env.MANPAGER = "nvim +Man!"

alias blctl = bluetoothctl
alias n = nvim
alias nf = nvim (sk)
alias rc = rmpc
alias systl = systemctl
alias tree = eza -TF
alias za = zathura
alias zf = zathura (sk) &

do {
  let autoload_dir = ($nu.data-dir | path join "vendor/autoload")
  rm -rf $autoload_dir
  mkdir $autoload_dir

  starship init nu | save -f ($autoload_dir | path join "init_starship.nu")
  atuin init nu | save -f ($autoload_dir | path join "init_atuin.nu")
  $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
  carapace _carapace nushell | save -f ($autoload_dir | path join "init_carapace.nu")
  zoxide init nushell | save -f ($autoload_dir | path join "init_zoxide.nu")
}


fastfetch
