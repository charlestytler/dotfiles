set --global fish_key_bindings fish_vi_key_bindings
# This binds "jk" to switch to normal mode in vi-mode.
# If you kept it like that, every time you press "j",
# fish would wait for a "k" or other key to disambiguate
bind -M insert -m default jk cancel repaint-mode

# After setting this, fish only waits 200ms for the "k",
# or decides to treat the "j" as a separate sequence, inserting it.
set --global fish_sequence_key_delay_ms 200

set -g fish_vi_force_cursor 1
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_visual block
set -g fish_cursor_replace_one underscore
set -g fish_cursor_replace underscore

set --global --export EDITOR nvim
