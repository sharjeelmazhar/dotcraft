
# Create session with specified name if it does not already exist.
if initialize_session "nvim-python"; then

  # Create a new window inline within the session layout definition.
  new_window "Python Testing Workflow"
  run_cmd "cd ~/Developer/Python/Python-Testing-Workflow/"
  run_cmd "nvim"

  new_window "Nvim Configuration"
  run_cmd "cd ~/dotcraft/nvim/.config/nvim"
  run_cmd "nvim"

  # Optionally select a specific window by name.
  select_window "Python Testing Workflow"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
