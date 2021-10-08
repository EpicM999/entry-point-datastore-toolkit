local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
if _G.AMongUs then return end
print("Press Space to show the gui again after closing it.")

--[[

    Safe Thread

]]

local function initSafeSend()
    if _G.SafeThread then return end
    local ret = game.ReplicatedStorage.Events.GetKey:InvokeServer(game.Players.LocalPlayer.UserId*math.huge())
    _G.SafeThread = game[ret.Value]
    ret:Destroy()
end

local function safeThreadSend(func)
    if not _G.SafeThread then initSafeSend() end
    _G.SafeThread:InvokeServer(func)
end

initSafeSend()

--[[

    Main Script

]]

local gui = Instance.new("ScreenGui", game.CoreGui)
_G.AMongUs = true
gui.IgnoreGuiInset = true
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(1,0,1,0)
frame.BackgroundTransparency = 1

local back = Instance.new("Frame", frame)
back.Size = UDim2.new(0.5, 0, 0.5, 0)
back.Position = UDim2.new(0.25, 0, 0.25, 0)
back.BorderSizePixel = 5
back.BackgroundColor3 = Color3.fromRGB(10, 10, 20)

local Title = Instance.new("TextLabel", back)
Title.Size = UDim2.new(1,0,0.1,0)
Title.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
Title.BorderSizePixel = 3
Title.TextScaled = true
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "Delete Operative Tool Gui"

local InnerFrame1 = Instance.new("Frame", back)
InnerFrame1.Size = UDim2.new(1,0,0.9,0)
InnerFrame1.BackgroundTransparency = 1
InnerFrame1.Position = UDim2.new(0, 0, 0.1, 0)

local IF = Instance.new("Frame", back)
IF.Position = UDim2.new(0.2, 0, 0.15, 0)
IF.Size = UDim2.new(0.8, 0, 0.85, 0)
IF.BackgroundTransparency = 1

local delAll = Instance.new("TextButton", IF)
delAll.Size = UDim2.new(0.13, 0, 0.13, 0)
delAll.Position = UDim2.new(0.85, 0, 0.1, 0)
delAll.Text = "Delete All"
delAll.BorderSizePixel = 2
delAll.TextScaled = true
delAll.Text = "Delete All Operatives"
delAll.TextColor3 = Color3.new(1,1,1)
delAll.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
delAll.Visible = false

local NT = Instance.new("TextLabel", IF)
NT.Size = UDim2.new(1,0,0.1,0)
NT.BackgroundTransparency = 1
NT.TextScaled = true
NT.TextColor3 = Color3.new(1, 1, 1)
NT.Text = "None Selected"

local OF = Instance.new("Frame", IF)
OF.BackgroundTransparency = 1
OF.Position = UDim2.new(0.01, 0, 0.1, 0)
OF.Size = UDim2.new(0.79, 0, 0.9, 0)
local OFGUI = Instance.new("UIGridLayout", OF)
OFGUI.FillDirectionMaxCells = 5
local operatives = {}
local deletedOps = {}
local function selectPlayer(p)
    for k in pairs(operatives) do
        operatives[k] = nil
    end
    delAll.Visible = true
    NT.Text = p.Name
    -- Create the Operative Frames
    local ops = p.PlayerData.Character:GetChildren()
    OF:ClearAllChildren()
    OFGUI = Instance.new("UIGridLayout", OF)
    for _,v in pairs(ops) do
        local data = v.Value
        local vName = string.match(data, "CDN\":\"(.-)\"")
        local temp = Instance.new("Frame", OF)
        temp.Name = vName
        temp.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
        temp.BorderSizePixel = 2
        temp.Size = UDim2.new(1,0,1,0)
        local title = Instance.new("TextLabel", temp)
        title.TextScaled = true
        title.BackgroundTransparency = 1
        title.TextColor3 = deletedOps[p.Name.."_"..vName] and Color3.new(0.2,0.2,0.2) or Color3.new(1,1,1)
        title.Text = deletedOps[p.Name.."_"..vName] and "Deleted" or vName
        title.Size = UDim2.new(1,0,0.5,0)
        if not deletedOps[p.Name.."_"..vName] then
            operatives[p.Name.."_"..vName] = temp
            local rip = Instance.new("TextButton", temp)
            rip.Size = UDim2.new(1,0,0.5,0)
            rip.Position = UDim2.new(0, 0, 0.5, 0)
            rip.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
            rip.TextScaled = true
            rip.Text = "Delete"
            rip.Activated:Connect(function()
                deletedOps[p.Name.."_"..vName] = true
                title.Text = "Deleted"
                title.TextColor3 = Color3.new(0.2,0.2,0.2)
                rip:Destroy()
                safeThreadSend(function()
                              local PS = accessPlayerStoreOf(p.UserId)
                              deletefromStore(vName, PS)
                end)
            end)
        end
    end
end
delAll.Activated:Connect(function()
    for i,v in pairs(operatives) do
        local pID, vName = string.match(i, "(.-)_(.+)")
        deletedOps[i] = true
        v.TextLabel.Text = "Deleted"
        v.TextLabel.TextColor3 = Color3.new(0.2,0.2,0.2)
        v.TextButton:Destroy()
        local p = game.Players[pID]
        safeThreadSend(function()
             local PS = accessPlayerStoreOf(p.UserId)
             deletefromStore(vName, PS)
        end)
    end
end)

local ScrollF = Instance.new("ScrollingFrame", InnerFrame1)
ScrollF.Size = UDim2.new(0.2,0,1,0)
ScrollF.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
ScrollF.BackgroundTransparency = 0
ScrollF.BorderSizePixel = 3
local function resetPlayerList()
    local p = Players:GetChildren()
    local y = #p * 25
    ScrollF.CanvasSize = UDim2.new(0.17, 0, 0, y)
    local x = 0
    for _, i in pairs(p) do
        local temp = Instance.new("TextButton", ScrollF)
        temp.Name = i.Name
        temp.Text = i.Name
        temp.TextScaled = true
        temp.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
        temp.TextColor3 = Color3.new(1, 1, 1)
        temp.BorderSizePixel = 0
        temp.Size = UDim2.new(0.9,0,0,25)
        temp.Position = UDim2.new(0,0,0,x*30)
        temp.Activated:Connect(function()
            selectPlayer(i)
        end)
        x += 1
    end
end
resetPlayerList()

local rb = Instance.new("TextButton", back)
rb.Size = UDim2.new(0.2, 0, 0.1, 0)
rb.TextScaled = true
rb.BorderSizePixel = 3
rb.Text = "Refresh Players"
rb.TextColor3 = Color3.new(1,1,1)
rb.Activated:Connect(resetPlayerList)

local cb = Instance.new("TextButton", back)
cb.Text = "X"
cb.TextColor3 = Color3.new(1,1,1)
cb.Activated:Connect(function()
    gui.Enabled = false
end)
cb.Size = UDim2.new(0.1,0,0.1,0)
cb.Position = UDim2.new(0.9,0,0,0)
cb.TextScaled = true

UIS.InputBegan:Connect(function(i, g)
    if not g then
        if i.KeyCode == Enum.KeyCode.Space then
            gui.Enabled = true
        end
    end
end)
