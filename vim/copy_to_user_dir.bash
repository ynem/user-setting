user_dir=~
script_dir=$(cd $(dirname $0); pwd)
cp "$script_dir"/.vimrc "$user_dir"

user_vim_plugin_dir="$user_dir"/.vim/plugin
if [ ! -d "$user_vim_plugin_dir" ]; then
    mkdir -p "$user_vim_plugin_dir"
fi
cp "$script_dir"/plugin/* "$user_vim_plugin_dir"

