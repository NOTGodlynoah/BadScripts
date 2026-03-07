task=task or setmetatable({},{__index=function()end})task.wait=task.wait or wait or function()end task.spawn=task.spawn or spawn or coroutine.wrap or function(f)f()end
local recurrence,recursions=1,{}local function recurser()local recurrable=0 return function()recurrable=recurrable+1
if recurrable>#recursions then recurrable=1 end local recursioned=recursions[recurrable]
task.spawn(function()if recursioned then recursioned(recurser())end end)task.spawn(function()print('recursion is my passion #'..recurrence)
recurrence=recurrence+1 local recurring=string.rep("recurringrecursiverecursionrecurs",20).." #"..recurrence
local recurred="return function(recurse)while true do task.spawn(function()print('Running "..recurring.."')recurse()end)end end"
local newrecurse=(loadstring or load)(recurred)() recursions[#recursions+1]=newrecurse end)end end
local function recurse1(recurse)while true do task.wait()task.spawn(function()recurse()end)end end recursions[1]=recurse1 recurse1(recurser())
