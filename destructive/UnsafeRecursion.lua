-- UnsafeRecursion.lua -- A very funny script made by NOTGodlynoah to fuck with Lua/Luau sandboxxes, this one does not immediately die from stack overflow. --
local recursed=task and task.wait or wait or function()end local recurqueue={}local recurspawn=task and task.spawn or spawn
local recurrent=recurspawn or function(f)recurqueue[#recurqueue+1]=f end local recurrence,recursions=1,{}
local recurrency=setmetatable({recurrent=recurrent,recursed=recursed},{__index=_G})
pcall(function()_G.recurrent=recurrent _G.recursed=recursed end)local function recur(recursor)local recursable,recurral=pcall(function()
return load(recursor,"recurse","t",recurrency)()end)if recursable and recurral then return recurral end recursable,recurral=pcall(function()
return(loadstring or load)(recursor)()end)if recursable and recurral then return recurral end end
local function recurser()local recurrable=0 return function()recurrable=#recursions local recursioned=recursions[recurrable]
recurrent(function()if recursioned then recursioned(recurser())end end)recurrent(function()print('recursion is notgodlynoah\'s passion #'..recurrence)
recurrence=recurrence+1 local recurring=string.rep("RecurringRecursiveRecursionsRecurRecurrences",recurrence).." #"..recurrence
local recursive=recur("return function(recurse)recurrent(function()print('Running "
..recurring.."')recurse()end)end")if recursive then recursions[#recursions+1]=recursive end end)end end
local function recurse1(recurse)recursed()recurrent(function()recurse()end)end recursions[1]=recurse1
recurrent(function()recurse1(recurser())end)while recurqueue[1] do local recurnext=table.remove(recurqueue)recurnext()recursed()end
