sheldon_cache=$ZCACHEDIR/sheldon.zsh
if [[ ! -r "$sheldon_cache" || "$XDG_CONFIG_HOME/sheldon/plugins.toml" -nt "$sheldon_cache" ]]; then
  mkdir -p $ZCACHEDIR
  sheldon source > $sheldon_cache
fi
source $sheldon_cache


source ~/.config/zsh/.p10k.zsh



# pnpm
export PNPM_HOME="/Users/yousuke.komada.789/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"

# >>> ghost-complete initialize >>> !! Contents within this block are managed by 'ghost-complete install' !!
#if [[ -f '/Users/yousuke.komada.789/.config/ghost-complete/shell/init.zsh' ]]; then
#  builtin source '/Users/yousuke.komada.789/.config/ghost-complete/shell/init.zsh'
#else
#  echo "ghost-complete: init script missing: "'/Users/yousuke.komada.789/.config/ghost-complete/shell/init.zsh' >&2
#  echo "ghost-complete: run 'ghost-complete install' to restore it" >&2
#fi
# <<< ghost-complete initialize <<<
# >>> microsandbox >>>
export PATH="$HOME/.microsandbox/bin:$PATH"
export DYLD_LIBRARY_PATH="$HOME/.microsandbox/lib${DYLD_LIBRARY_PATH:+:$DYLD_LIBRARY_PATH}"
# <<< microsandbox <<<
# >>> ghost-complete shell integration >>>
# !! Contents within this block are managed by 'ghost-complete install' !!
#source '/Users/yousuke.komada.789/.config/ghost-complete/shell/ghost-complete.zsh'
# <<< ghost-complete shell integration <<<

