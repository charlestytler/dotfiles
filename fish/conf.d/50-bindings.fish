function fish_user_key_bindings

  # Bindings for all modes
  for mode in insert default visual
      # This binds Ctrl-Space to accept a fish autocomplete suggestion (same as right-arrow).
    bind -M $mode ctrl-space accept-autosuggestion
    bind -M $mode ctrl-p open_files_in_nvim
    bind -M $mode ctrl-e edit_command_buffer

    # Alternate binding method, for terminals that read Ctrl+Space as nul.
    bind -M $mode --key nul accept-autosuggestion
    bind -M $mode \cp open_files_in_nvim
    bind -M $mode \ce edit_command_buffer
  end

end
