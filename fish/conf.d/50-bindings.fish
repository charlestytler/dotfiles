function fish_user_key_bindings

  # Bindings for all modes
  for mode in insert default visual
      # This binds Ctrl-Space to accept a fish autocomplete suggestion (same as right-arrow).
    bind -M $mode -k nul forward-char
    bind -M $mode \cp open_files_in_nvim
  end

end
