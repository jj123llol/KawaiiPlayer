-- hi guys

if not openfiledialog or not voicechat then
    error("Use Kawaii./nDiscord.gg/kawaiilua")
end

if not voicechat.hasvoicechat() then
    error("No voicechat :rofl:")
end

local KawaiiPlayer = {
    ["Playing"] = false,
    ["Saves"] = {}
}

local function KawaiiPlayer:AddSong()
    local file = openfiledialog({
        title = "Kawaii MusicPlayer",
        extensionFilter = {
            ".mp3",
            ".wav",
            ".ogg",
            ".m4a"
        }
    })
    if not file then return end
    
    KawaiiPlayer.saves[file:GetName()] = file
end

local function KawaiiPlayer:Play(file)
    if not file then return end
    file = type(file) == "string" and KawaiiPlayer.saves[file] or file
    if workspace:FindFirstChild("KawaiiPlayer") then
        workspace.KawaiiPlayer:Destroy()
    end
    
    voicechat.setmicmuted(true)
    
    local fakeAudio = Instsnce.new("Sound")
    fakeAudio.Name = "KawaiiPlayer"
    fakeAudio.SoundId = getcustomasset(file)
    fakeAudio.Parent = workspace
    
    voicechat.play(file)
    fakeAudio:Play()
    KawaiiPlayer.Playing = true
end

local function KawaiiPlayer:Pause()
    if not KawaiiPlayer.Playing then return end
    
    local audio = workspace:FindFirstChild("KawaiiPlayer")
    if not audio then return end
    
    audio:Pause()
    voicechat.pause()
    KawaiiPlayer.Playing = false
end

local function KawaiiPlayer:Resume()
    if KawaiiPlayer.Playing then return end
    
    local audio = workspace:FindFirstChild("KawaiiPlayer")
    if not audio then return end
    
    audio:Resume()
    voicechat.unpause()
    KawaiiPlayer.Playing = true
end

local function KawaiiPlayer:Stop()
    local audio = workspace:FindFirstChild("KawaiiPlayer")
    if not audio then return end
    
    audio:Destroy()
    voicechat.stop()
    KawaiiPlayer.Playing = false
end
