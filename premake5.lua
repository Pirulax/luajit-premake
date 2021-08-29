-- Used in BuildVM
GC64 = true -- Use 64 bit GC. Only available in x64 
FFI  = true -- Enable FFI

function getrootpath()
    return "%{wks.location}.."
end

function buildpath(p) 
    return "%{getrootpath()}/bin/%{cfg.shortname}/" .. (p or "")
end

function srcpath(p)
    return "%{getrootpath()}/src/" .. (p or "")
end

workspace "LuaJIT"
    cppdialect "C++17"
    toolset "v143"
    symbols "On"
    location "build"
    
    platforms {"x86", "x64"}
    configurations { "Debug", "Release" }

    filter "configurations:Debug"
        defines { "DEBUG" }
        runtime "Release"
        --targetsuffix "_d"
        targetdir "bin/debug"


    filter "configurations:Release"
        defines { "NDEBUG" }
        runtime "Debug"
        optimize "On"
        targetsuffix ""   
        targetdir "bin/release"

    filter {}

    staticruntime "On" -- /MD switch

    include "src/host/buildvm.premake5.lua"
    include "src/host/minilua.premake5.lua"
    include "luajit.premake5.lua"
