lua require("clang-format")

function! ClangFormat() range
  " Inside LuaClangFormat the arguments from range are used.
  lua LuaClangFormat()
endfunction

