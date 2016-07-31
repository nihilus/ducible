local cc = require "rules.cc"

local pepatch = cc.binary {
    name = "pepatch",
    srcs = glob { "src/*.cpp", "src/*.c" },
    warnings = {"all", "error"},
    compiler_opts = {"-g"},
}

--
-- Test pepatch
--
local tests = {
    {image = "vs/vs2015/Debug/test_dll.dll", pdb = "vs/vs2015/Debug/test_dll.pdb"},
    {image = "vs/vs2015/Release/test_dll.dll", pdb = "vs/vs2015/Release/test_dll.pdb"},
    {image = "vs/vs2015/x64/Debug/test_dll.dll", pdb = "vs/vs2015/x64/Debug/test_dll.pdb"},
    {image = "vs/vs2015/x64/Release/test_dll.dll", pdb = "vs/vs2015/x64/Release/test_dll.pdb"},

    {image = "vs/vs2015/Debug/test_exe.exe", pdb = "vs/vs2015/Debug/test_exe.pdb"},
    {image = "vs/vs2015/Release/test_exe.exe", pdb = "vs/vs2015/Release/test_exe.pdb"},
    {image = "vs/vs2015/x64/Debug/test_exe.exe", pdb = "vs/vs2015/x64/Debug/test_exe.pdb"},
    {image = "vs/vs2015/x64/Release/test_exe.exe", pdb = "vs/vs2015/x64/Release/test_exe.pdb"},
}

for _,t in ipairs(tests) do
    rule {
        inputs = {pepatch:path()},
        task = {{pepatch:path(), t.image, t.pdb}},
        outputs = {},
    }
end

rule {
    inputs = {pepatch:path()},
    task = {{pepatch:path(), "--help"}},
    outputs = {},
}
