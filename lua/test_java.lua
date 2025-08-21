-- Test command for Java detection - run this in Neovim with :lua require("test_java").test()
local M = {}

function M.test()
  local java_utils = require("utils.java")
  
  print("Detecting JDKs...")
  local jdks = java_utils.detect_all_jdks()
  
  if #jdks == 0 then
    print("No JDKs found!")
  else
    print(string.format("Found %d JDK(s):", #jdks))
    for i, jdk in ipairs(jdks) do
      local default = jdk.default and " [DEFAULT]" or ""
      print(string.format("  %d. %s%s", i, jdk.display_name, default))
      print(string.format("     Path: %s", jdk.path))
      print(string.format("     Version: %s", jdk.version))
    end
  end
  
  print("\nRuntime configuration for nvim-java:")
  local runtimes = java_utils.get_runtimes_config()
  for i, runtime in ipairs(runtimes) do
    local default = runtime.default and " [DEFAULT]" or ""
    print(string.format("  %s: %s%s", runtime.name, runtime.path, default))
  end
end

return M