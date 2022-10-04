sheldon_cache=$ZCACHEDIR/sheldon.zsh
if [[ ! -r "$sheldon_cache" || "$XDG_CONFIG_HOME/sheldon/plugins.toml" -nt "$sheldon_cache" ]]; then
  mkdir -p $ZCACHEDIR
  sheldon source > $sheldon_cache
fi
source $sheldon_cache
