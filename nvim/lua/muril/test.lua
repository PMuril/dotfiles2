-- -- If Makefile is at top of the project root, do this instead
-- let g:test#cpp#catch2#suite_command = "ctest --ouput-on-failure" 

vim.g['test#cpp#catch2#make_command'] = 'make controllermanager-test'
vim.g['test#cpp#catch2#file_pattern'] = '.*TestSuite.cpp'
vim.g['test#cpp#catch2#relToProject_build_dir'] = 'build_simulator'
vim.g['test#cpp#catch2#bin_dir'] = 'build_simulator'
