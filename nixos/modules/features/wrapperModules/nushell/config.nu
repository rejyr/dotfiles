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
  mkdir $autoload_dir
  starship init nu | save -f ($autoload_dir | path join "init_starship.nu")
  atuin init nu | save -f ($autoload_dir | path join "init_atuin.nu")
  zoxide init nushell | save -f ($autoload_dir | path join "init_zoxide.nu")

  let nu_scripts_outPath = $nu_scripts_outPath
  let ignored_completions = [cargo-make pass pdm pnpm uv yarn]
  let completion_paths = $nu_scripts_outPath | path join "share/nu_scripts/custom-completions/*/*.nu" | glob $in | where $it !~ ($ignored_completions | str join '|')
  $completion_paths | each {|elt| cp --no-clobber $elt $autoload_dir}
}


fastfetch
