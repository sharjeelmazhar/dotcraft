return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		-- Keymap to add a file to Harpoon
		vim.keymap.set("n", "<leader>A", function()
			harpoon:list():add()
		end, { desc = "Add file to harpoon" })

		-- Basic Telescope configuration with file preview and file removal

		local function toggle_telescope(harpoon_files)
			local function finder()
				local paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(paths, item.value)
				end

				return require("telescope.finders").new_table({
					results = paths,
				})
			end

			local picker = require("telescope.pickers").new({}, {
				prompt_title = "Harpoon",
				finder = finder(),
				previewer = require("telescope.config").values.file_previewer({}),
				sorter = require("telescope.config").values.generic_sorter({}),
				layout_config = {
					height = 0.9, -- Adjusted height to make preview larger
					width = 0.8, -- Adjusted width to give more space
					prompt_position = "bottom",
					preview_cutoff = 20, -- Lowered preview cutoff to show the preview sooner
				},
				attach_mappings = function(prompt_bufnr, map)
					-- Mapping to delete a file from Harpoon and refresh the picker
					map("i", "<C-d>", function()
						local state = require("telescope.actions.state")
						local selected_entry = state.get_selected_entry()
						local current_picker = state.get_current_picker(prompt_bufnr)

						-- Remove the file from the harpoon list
						table.remove(harpoon_files.items, selected_entry.index)

						-- Refresh the picker to reflect the updated list
						current_picker:refresh(finder())
					end, { desc = "delete file from harpoon telescope" })
					return true
				end,
			})

			picker:find()
		end

		-- Select specific files from Harpoon
		vim.keymap.set("n", "<leader>a", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle harpoon quick menu" })

		-- Keymap to toggle the Telescope picker for Harpoon
		vim.keymap.set("n", "<C-E>", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open harpoon telescope" })

		-- Select specific files from Harpoon
		for i = 1, 4 do
			vim.keymap.set("n", "<C-" .. i .. ">", function()
				harpoon:list():select(i)
			end, { desc = "Select ith file in harpoon" })
		end

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("i", "<hh>", function()
			harpoon:list():prev()
		end, { desc = "Next file in harpoon" })
		vim.keymap.set("i", "<ll>", function()
			harpoon:list():next()
		end, { desc = "Prev file in harpoon" })
	end,
}
