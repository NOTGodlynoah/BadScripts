local recurrence,recursions=1,{}local task=task or spawn or nil local w=task and task.wait or wait or function()end local s=task and task.spawn or spawn or function()end
local ldstr=loadstring or load local function recurser()local recurrable=0 return function()recurrable=recurrable+1
if recurrable>#recursions then recurrable=1 end local recursioned=recursions[recurrable]s(function()recursioned(recurser())end)s(function()
print('recursion is my passion #'..recurrence)recurrence=recurrence+1
local recurring=string.rep("RecurringRecurrencesOfRecuredRecursiveRecurrencesRecur",20)..recurrence
local recurred=[=[return function(recurse)while true do w() s(function()print('Running ]=]..recurring..[=[')recurse()end)end end]=]
local newrecurse=ldstr(recurred)()recursions[#recursions+1]=newrecurse end)end end
local function recurse1(recurse)while true do w()s(function()recurse()end)end end
recursions[1]=recurse1 recurse1(recurser())
