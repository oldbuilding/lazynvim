return {
  "chrisgrieser/nvim-recorder",
  dependencies = "rcarriga/nvim-notify",
  keys = {
    -- these must match the keys in the mapping config below
    { "@@", desc = " Start Recording" },
    { "@", desc = " Play Recording" },
    { "c@", desc = " Edit Recording" },
    { "d@", desc = " Delete All Recordings" },
    { "y@", desc = " Yank Recording" },
  },
  opts = {
    mapping = {
      startStopRecording = "@@",
      playMacro = "@",
      switchSlot = "<C-@>",
      editMacro = "c@",
      deleteAllMacros = "d@",
      yankMacro = "y@",
    },
  },
  config = function(_, opts) require("recorder").setup(opts) end,
}
