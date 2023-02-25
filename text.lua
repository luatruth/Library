local a = game:GetService("Workspace")
local b = game:GetService("UserInputService")
local c = game:GetService("RunService")
local d = game:GetService("HttpService")
local e = game:GetService("Players")
local f = game:GetService("Stats")
local g = {
    drawings = {},
    hidden = {},
    connections = {},
    pointers = {},
    began = {},
    ended = {},
    changed = {},
    folders = {
        main = "splix",
        assets = "splix/assets",
        configs = "splix/configs"
    },
    shared = {
        initialized = false,
        fps = 0,
        ping = 0
    }
}
if not isfolder(g.folders.main) then
    makefolder(g.folders.main)
end
if not isfolder(g.folders.configs) then
    makefolder(g.folders.configs)
end
local h = {}
local i = {}
local j = {}
local k = {
    accent = Color3.fromRGB(50, 100, 255),
    light_contrast = Color3.fromRGB(30, 30, 30),
    dark_contrast = Color3.fromRGB(20, 20, 20),
    outline = Color3.fromRGB(0, 0, 0),
    inline = Color3.fromRGB(50, 50, 50),
    textcolor = Color3.fromRGB(255, 255, 255),
    textborder = Color3.fromRGB(0, 0, 0),
    cursoroutline = Color3.fromRGB(10, 10, 10),
    font = 2,
    textsize = 13
}
do
    function h:Size(l, m, n, o, p)
        if p then
            local q = l * p.Size.x + m;
            local r = n * p.Size.y + o;
            return Vector2.new(q, r)
        else
            local s, t = a.CurrentCamera.ViewportSize.x, a.CurrentCamera.ViewportSize.y;
            local q = l * s + m;
            local r = n * t + o;
            return Vector2.new(q, r)
        end
    end
    function h:Position(l, m, n, o, p)
        if p then
            local q = p.Position.x + l * p.Size.x + m;
            local r = p.Position.y + n * p.Size.y + o;
            return Vector2.new(q, r)
        else
            local s, t = a.CurrentCamera.ViewportSize.x, a.CurrentCamera.ViewportSize.y;
            local q = l * s + m;
            local r = n * t + o;
            return Vector2.new(q, r)
        end
    end
    function h:Create(u, v, w, x)
        local u = u or "Frame"
        local v = v or {Vector2.new(0, 0)}
        local w = w or {}
        local y = false;
        local p = nil;
        if u == "Frame" or u == "frame" then
            local z = Drawing.new("Square")
            z.Visible = true;
            z.Filled = true;
            z.Thickness = 0;
            z.Color = Color3.fromRGB(255, 255, 255)
            z.Size = Vector2.new(100, 100)
            z.Position = Vector2.new(0, 0)
            z.ZIndex = 50;
            z.Transparency = g.shared.initialized and 1 or 0;
            p = z
        elseif u == "TextLabel" or u == "textlabel" then
            local A = Drawing.new("Text")
            A.Font = 3;
            A.Visible = true;
            A.Outline = true;
            A.Center = false;
            A.Color = Color3.fromRGB(255, 255, 255)
            A.ZIndex = 50;
            A.Transparency = g.shared.initialized and 1 or 0;
            p = A
        elseif u == "Triangle" or u == "triangle" then
            local z = Drawing.new("Triangle")
            z.Visible = true;
            z.Filled = true;
            z.Thickness = 0;
            z.Color = Color3.fromRGB(255, 255, 255)
            z.ZIndex = 50;
            z.Transparency = g.shared.initialized and 1 or 0;
            p = z
        elseif u == "Image" or u == "image" then
            local B = Drawing.new("Image")
            B.Size = Vector2.new(12, 19)
            B.Position = Vector2.new(0, 0)
            B.Visible = true;
            B.ZIndex = 50;
            B.Transparency = g.shared.initialized and 1 or 0;
            p = B
        elseif u == "Circle" or u == "circle" then
            local C = Drawing.new("Circle")
            C.Visible = false;
            C.Color = Color3.fromRGB(255, 0, 0)
            C.Thickness = 1;
            C.NumSides = 30;
            C.Filled = true;
            C.Transparency = 1;
            C.ZIndex = 50;
            C.Radius = 50;
            C.Transparency = g.shared.initialized and 1 or 0;
            p = C
        elseif u == "Quad" or u == "quad" then
            local D = Drawing.new("Quad")
            D.Visible = false;
            D.Color = Color3.fromRGB(255, 255, 255)
            D.Thickness = 1.5;
            D.Transparency = 1;
            D.ZIndex = 50;
            D.Filled = false;
            D.Transparency = g.shared.initialized and 1 or 0;
            p = D
        elseif u == "Line" or u == "line" then
            local E = Drawing.new("Line")
            E.Visible = false;
            E.Color = Color3.fromRGB(255, 255, 255)
            E.Thickness = 1.5;
            E.Transparency = 1;
            E.Thickness = 1.5;
            E.ZIndex = 50;
            E.Transparency = g.shared.initialized and 1 or 0;
            p = E
        end
        if p then
            for F, G in pairs(w) do
                if F == "Hidden" or F == "hidden" then
                    y = true
                else
                    if g.shared.initialized then
                        p[F] = G
                    else
                        if F ~= "Transparency" then
                            p[F] = G
                        end
                    end
                end
            end
            if not y then
                g.drawings[#g.drawings + 1] = {p, v, w["Transparency"] or 1}
            else
                g.hidden[#g.hidden + 1] = {p}
            end
            if x then
                x[#x + 1] = p
            end
            return p
        end
    end
    function h:UpdateOffset(p, v)
        for F, G in pairs(g.drawings) do
            if G[1] == p then
                G[2] = v
            end
        end
    end
    function h:UpdateTransparency(p, H)
        for F, G in pairs(g.drawings) do
            if G[1] == p then
                G[3] = H
            end
        end
    end
    function h:Remove(p, I)
        local J = 0;
        for F, G in pairs(I and g.hidden or g.drawings) do
            if G[1] == p then
                J = F;
                if I then
                    G[1] = nil
                else
                    G[2] = nil;
                    G[1] = nil
                end
            end
        end
        table.remove(I and g.hidden or g.drawings, J)
        p:Remove()
    end
    function h:GetSubPrefix(K)
        local K = tostring(K):gsub(" ", "")
        local L = ""
        if #K == 2 then
            local M = string.sub(K, #K, #K + 1)
            L = M == "1" and "st" or M == "2" and "nd" or M == "3" and "rd" or "th"
        end
        return L
    end
    function h:Connection(N, O)
        local P = N:Connect(O)
        g.connections[#g.connections + 1] = P;
        return P
    end
    function h:Disconnect(P)
        for F, G in pairs(g.connections) do
            if G == P then
                g.connections[F] = nil;
                G:Disconnect()
            end
        end
    end
    function h:MouseLocation()
        return b:GetMouseLocation()
    end
    function h:MouseOverDrawing(Q, R)
        local R = R or {}
        local Q = {(Q[1] or 0) + (R[1] or 0), (Q[2] or 0) + (R[2] or 0), (Q[3] or 0) + (R[3] or 0),
                   (Q[4] or 0) + (R[4] or 0)}
        local S = h:MouseLocation()
        return S.x >= Q[1] and S.x <= Q[1] + Q[3] - Q[1] and (S.y >= Q[2] and S.y <= Q[2] + Q[4] - Q[2])
    end
    function h:GetTextBounds(A, T, U)
        local V = Vector2.new(0, 0)
        local W = h:Create("TextLabel", {Vector2.new(0, 0)}, {
            Text = A,
            Size = T,
            Font = U,
            Hidden = true
        })
        V = W.TextBounds;
        h:Remove(W, true)
        return V
    end
    function h:GetScreenSize()
        return a.CurrentCamera.ViewportSize
    end
    function h:LoadImage(p, X, Y)
        local Z;
        if isfile(g.folders.assets .. "/" .. X .. ".png") then
            Z = readfile(g.folders.assets .. "/" .. X .. ".png")
        else
            if Y then
                Z = game:HttpGet(Y)
                writefile(g.folders.assets .. "/" .. X .. ".png", Z)
            else
                return
            end
        end
        if Z and p then
            p.Data = Z
        end
    end
    function h:Lerp(p, _, a0)
        local a1 = 0;
        local a2 = {}
        local P;
        for F, G in pairs(_) do
            a2[F] = p[F]
        end
        local function a3()
            for F, G in pairs(_) do
                p[F] = (G - a2[F]) * a1 / a0 + a2[F]
            end
        end
        P = c.RenderStepped:Connect(function(a4)
            if a1 < a0 then
                a1 = a1 + a4;
                a3()
            else
                P:Disconnect()
            end
        end)
    end
    function h:Combine(a5, a6)
        local a7 = {}
        for F, G in pairs(a5) do
            a7[F] = G
        end
        local a8 = #a7;
        for a9, q in pairs(a6) do
            a7[a9 + a8] = q
        end
        return a7
    end
end
do
    g.__index = g;
    i.__index = i;
    j.__index = j;
    function g:New(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "UI Title"
        local ac = aa.size or aa.Size or Vector2.new(504, 604)
        local ad = aa.accent or aa.Accent or aa.color or aa.Color or k.accent;
        k.accent = ad;
        local ae = {
            pages = {},
            isVisible = false,
            uibind = getgenv().VisionSettings.uiKeybind,
            currentPage = nil,
            fading = false,
            dragging = false,
            drag = Vector2.new(0, 0),
            currentContent = {
                frame = nil,
                dropdown = nil,
                multibox = nil,
                colorpicker = nil,
                keybind = nil
            }
        }
        local af = h:Create("Frame", {Vector2.new(0, 0)}, {
            Size = h:Size(0, ac.X, 0, ac.Y),
            Position = h:Position(0.5, -(ac.X / 2), 0.5, -(ac.Y / 2)),
            Color = k.outline
        })
        ae["main_frame"] = af;
        local ag = h:Create("Frame", {Vector2.new(1, 1), af}, {
            Size = h:Size(1, -2, 1, -2, af),
            Position = h:Position(0, 1, 0, 1, af),
            Color = k.accent
        })
        local ah = h:Create("Frame", {Vector2.new(1, 1), ag}, {
            Size = h:Size(1, -2, 1, -2, ag),
            Position = h:Position(0, 1, 0, 1, ag),
            Color = k.light_contrast
        })
        local ai = h:Create("Image", {Vector2.new(4, 0), ah}, {
            Size = Vector2.new(20, 20),
            Data = game:HttpGet("https://i.ibb.co/dcFvJVx/Vision-2-PFP-2-copie.png"),
            Position = h:Position(0, 0, 0, 0, ah)
        })
        local aj = h:Create("TextLabel", {Vector2.new(155, 4), ah}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 155, 0, 4, ah)
        })
        local ak = h:Create("Frame", {Vector2.new(4, 18), ah}, {
            Size = h:Size(1, -8, 1, -22, ah),
            Position = h:Position(0, 4, 0, 18, ah),
            Color = k.inline
        })
        local al = h:Create("Frame", {Vector2.new(1, 1), ak}, {
            Size = h:Size(1, -2, 1, -2, ak),
            Position = h:Position(0, 1, 0, 1, ak),
            Color = k.outline
        })
        local am = h:Create("Frame", {Vector2.new(1, 1), al}, {
            Size = h:Size(1, -2, 1, -2, al),
            Position = h:Position(0, 1, 0, 1, al),
            Color = k.dark_contrast
        })
        ae["back_frame"] = am;
        local an = h:Create("Frame", {Vector2.new(4, 24), am}, {
            Size = h:Size(1, -8, 1, -28, am),
            Position = h:Position(0, 4, 0, 24, am),
            Color = k.outline
        })
        local ao = h:Create("Frame", {Vector2.new(1, 1), an}, {
            Size = h:Size(1, -2, 1, -2, an),
            Position = h:Position(0, 1, 0, 1, an),
            Color = k.inline
        })
        local ap = h:Create("Frame", {Vector2.new(1, 1), ao}, {
            Size = h:Size(1, -2, 1, -2, ao),
            Position = h:Position(0, 1, 0, 1, ao),
            Color = k.light_contrast
        })
        ae["tab_frame"] = ap;
        function ae:GetConfig()
            local aq = {}
            for F, G in pairs(g.pointers) do
                if typeof(G:Get()) == "table" and G:Get().Transparency then
                    local ar, as, at = G:Get().Color:ToHSV()
                    aq[F] = {
                        Color = {ar, as, at},
                        Transparency = G:Get().Transparency
                    }
                else
                    aq[F] = G:Get()
                end
            end
            return game:GetService("HttpService"):JSONEncode(aq)
        end
        function ae:LoadConfig(aq)
            local aq = d:JSONDecode(aq)
            for F, G in pairs(aq) do
                if g.pointers[F] then
                    g.pointers[F]:Set(G)
                end
            end
        end
        function ae:Move(au)
            for F, G in pairs(g.drawings) do
                if G[2][2] then
                    G[1].Position = h:Position(0, G[2][1].X, 0, G[2][1].Y, G[2][2])
                else
                    G[1].Position = h:Position(0, au.X, 0, au.Y)
                end
            end
        end
        function ae:CloseContent()
            if ae.currentContent.dropdown and ae.currentContent.dropdown.open then
                local av = ae.currentContent.dropdown;
                av.open = not av.open;
                h:LoadImage(av.dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                for F, G in pairs(av.holder.drawings) do
                    h:Remove(G)
                end
                av.holder.drawings = {}
                av.holder.buttons = {}
                av.holder.inline = nil;
                ae.currentContent.frame = nil;
                ae.currentContent.dropdown = nil
            elseif ae.currentContent.multibox and ae.currentContent.multibox.open then
                local aw = ae.currentContent.multibox;
                aw.open = not aw.open;
                h:LoadImage(aw.multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                for F, G in pairs(aw.holder.drawings) do
                    h:Remove(G)
                end
                aw.holder.drawings = {}
                aw.holder.buttons = {}
                aw.holder.inline = nil;
                ae.currentContent.frame = nil;
                ae.currentContent.multibox = nil
            elseif ae.currentContent.colorpicker and ae.currentContent.colorpicker.open then
                local ax = ae.currentContent.colorpicker;
                ax.open = not ax.open;
                for F, G in pairs(ax.holder.drawings) do
                    h:Remove(G)
                end
                ax.holder.drawings = {}
                ae.currentContent.frame = nil;
                ae.currentContent.colorpicker = nil
            elseif ae.currentContent.keybind and ae.currentContent.keybind.open then
                local ay = ae.currentContent.keybind.modemenu;
                ae.currentContent.keybind.open = not ae.currentContent.keybind.open;
                for F, G in pairs(ay.drawings) do
                    h:Remove(G)
                end
                ay.drawings = {}
                ay.buttons = {}
                ay.frame = nil;
                ae.currentContent.frame = nil;
                ae.currentContent.keybind = nil
            end
        end
        function ae:IsOverContent()
            local az = false;
            if ae.currentContent.frame and
                h:MouseOverDrawing({ae.currentContent.frame.Position.X, ae.currentContent.frame.Position.Y,
                                    ae.currentContent.frame.Position.X + ae.currentContent.frame.Size.X,
                                    ae.currentContent.frame.Position.Y + ae.currentContent.frame.Size.Y}) then
                az = true
            end
            return az
        end
        function ae:Unload()
            for F, G in pairs(g.connections) do
                G:Disconnect()
                G = nil
            end
            for F, G in next, g.hidden do
                coroutine.wrap(function()
                    if G[1] and G[1].Remove and G[1].__OBJECT_EXISTS then
                        local p = G[1]
                        G[1] = nil;
                        G = nil;
                        p:Remove()
                    end
                end)()
            end
            for F, G in pairs(g.drawings) do
                coroutine.wrap(function()
                    if G[1].__OBJECT_EXISTS then
                        local p = G[1]
                        G[2] = nil;
                        G[1] = nil;
                        G = nil;
                        p:Remove()
                    end
                end)()
            end
            for F, G in pairs(g.began) do
                G = nil
            end
            for F, G in pairs(g.ended) do
                G = nil
            end
            for F, G in pairs(g.changed) do
                G = nil
            end
            g.drawings = nil;
            g.hidden = nil;
            g.connections = nil;
            g.began = nil;
            g.ended = nil;
            g.changed = nil;
            b.MouseIconEnabled = true
        end
        function ae:Watermark(aa)
            ae.watermark = {
                visible = false
            }
            local aa = aa or {}
            local aA = aa.name or aa.Name or aa.title or aa.Title or
                           string.format("$$ Splix || uid : %u || ping : %u || fps : %u", 1, 100, 200)
            local aB = h:GetTextBounds(aA, k.textsize, k.font)
            local aC = h:Create("Frame", {Vector2.new(100, 38 / 2 - 10)}, {
                Size = h:Size(0, aB.X + 20, 0, 21),
                Position = h:Position(0, 100, 0, 38 / 2 - 10),
                Hidden = true,
                ZIndex = 60,
                Color = k.outline,
                Visible = ae.watermark.visible
            })
            ae.watermark.outline = aC;
            local aD = h:Create("Frame", {Vector2.new(1, 1), aC}, {
                Size = h:Size(1, -2, 1, -2, aC),
                Position = h:Position(0, 1, 0, 1, aC),
                Hidden = true,
                ZIndex = 60,
                Color = k.inline,
                Visible = ae.watermark.visible
            })
            local aE = h:Create("Frame", {Vector2.new(1, 1), aD}, {
                Size = h:Size(1, -2, 1, -2, aD),
                Position = h:Position(0, 1, 0, 1, aD),
                Hidden = true,
                ZIndex = 60,
                Color = k.light_contrast,
                Visible = ae.watermark.visible
            })
            local aF = h:Create("Frame", {Vector2.new(0, 0), aE}, {
                Size = h:Size(1, 0, 0, 1, aE),
                Position = h:Position(0, 0, 0, 0, aE),
                Hidden = true,
                ZIndex = 60,
                Color = k.accent,
                Visible = ae.watermark.visible
            })
            local aG = h:Create("TextLabel", {Vector2.new(2 + 6, 4), aC}, {
                Text = string.format("splix - fps : %u - uid : %u", 35, 2),
                Size = k.textsize,
                Font = k.font,
                Color = k.textcolor,
                OutlineColor = k.textborder,
                Hidden = true,
                ZIndex = 60,
                Position = h:Position(0, 2 + 6, 0, 4, aC),
                Visible = ae.watermark.visible
            })
            function ae.watermark:UpdateSize()
                aC.Size = h:Size(0, aG.TextBounds.X + 4 + 6 * 2, 0, 21)
                aD.Size = h:Size(1, -2, 1, -2, aC)
                aE.Size = h:Size(1, -2, 1, -2, aD)
                aF.Size = h:Size(1, 0, 0, 1, aE)
            end
            function ae.watermark:Visibility()
                aC.Visible = ae.watermark.visible;
                aD.Visible = ae.watermark.visible;
                aE.Visible = ae.watermark.visible;
                aF.Visible = ae.watermark.visible;
                aG.Visible = ae.watermark.visible
            end
            function ae.watermark:Update(aH, aI)
                if aH == "Visible" then
                    ae.watermark.visible = aI;
                    ae.watermark:Visibility()
                end
            end
            h:Connection(c.RenderStepped, function(aJ)
                g.shared.fps = math.round(1 / aJ)
                g.shared.ping = tonumber(
                    string.split(f.Network.ServerStatsItem["Data Ping"]:GetValueString(), " ")[1] .. "")
            end)
            aG.Text = string.format("$$ Splix || uid : %u || ping : %i || fps : %u", 1, tostring(g.shared.ping),
                g.shared.fps)
            ae.watermark:UpdateSize()
            spawn(function()
                while wait(0.1) do
                    aG.Text = string.format("$$ Splix || uid : %u || ping : %i || fps : %u", 1, tostring(g.shared.ping),
                        g.shared.fps)
                    ae.watermark:UpdateSize()
                end
            end)
            return ae.watermark
        end
        function ae:KeybindsList(aa)
            ae.keybindslist = {
                visible = false,
                keybinds = {}
            }
            local aa = aa or {}
            local aK = h:Create("Frame", {Vector2.new(10, h:GetScreenSize().Y / 2 - 200)}, {
                Size = h:Size(0, 150, 0, 22),
                Position = h:Position(0, 10, 0.4, 0),
                Hidden = true,
                ZIndex = 55,
                Color = k.outline,
                Visible = ae.keybindslist.visible
            })
            ae.keybindslist.outline = aK;
            local aL = h:Create("Frame", {Vector2.new(1, 1), aK}, {
                Size = h:Size(1, -2, 1, -2, aK),
                Position = h:Position(0, 1, 0, 1, aK),
                Hidden = true,
                ZIndex = 55,
                Color = k.inline,
                Visible = ae.keybindslist.visible
            })
            local aM = h:Create("Frame", {Vector2.new(1, 1), aL}, {
                Size = h:Size(1, -2, 1, -2, aL),
                Position = h:Position(0, 1, 0, 1, aL),
                Hidden = true,
                ZIndex = 55,
                Color = k.light_contrast,
                Visible = ae.keybindslist.visible
            })
            local aN = h:Create("Frame", {Vector2.new(0, 0), aM}, {
                Size = h:Size(1, 0, 0, 1, aM),
                Position = h:Position(0, 0, 0, 0, aM),
                Hidden = true,
                ZIndex = 55,
                Color = k.accent,
                Visible = ae.keybindslist.visible
            })
            local aO = h:Create("TextLabel", {Vector2.new(aK.Size.X / 2, 4), aK}, {
                Text = "- Keybinds -",
                Size = k.textsize,
                Font = k.font,
                Color = k.textcolor,
                OutlineColor = k.textborder,
                Center = true,
                Hidden = true,
                ZIndex = 55,
                Position = h:Position(0.5, 0, 0, 5, aK),
                Visible = ae.keybindslist.visible
            })
            function ae.keybindslist:Resort()
                local aP = 0;
                for F, G in pairs(ae.keybindslist.keybinds) do
                    G:Move(0 + aP * 17)
                    aP = aP + 1
                end
            end
            function ae.keybindslist:Add(aQ, aR)
                if aQ and aR and not ae.keybindslist.keybinds[aQ] then
                    local aS = {}
                    local aT = h:Create("Frame", {Vector2.new(0, aK.Size.Y - 1), aK}, {
                        Size = h:Size(1, 0, 0, 18, aK),
                        Position = h:Position(0, 0, 1, -1, aK),
                        Hidden = true,
                        ZIndex = 55,
                        Color = k.outline,
                        Visible = ae.keybindslist.visible
                    })
                    local aU = h:Create("Frame", {Vector2.new(1, 1), aT}, {
                        Size = h:Size(1, -2, 1, -2, aT),
                        Position = h:Position(0, 1, 0, 1, aT),
                        Hidden = true,
                        ZIndex = 55,
                        Color = k.inline,
                        Visible = ae.keybindslist.visible
                    })
                    local aV = h:Create("Frame", {Vector2.new(1, 1), aU}, {
                        Size = h:Size(1, -2, 1, -2, aU),
                        Position = h:Position(0, 1, 0, 1, aU),
                        Hidden = true,
                        ZIndex = 55,
                        Color = k.dark_contrast,
                        Visible = ae.keybindslist.visible
                    })
                    local aW = h:Create("TextLabel", {Vector2.new(4, 3), aT}, {
                        Text = aQ,
                        Size = k.textsize,
                        Font = k.font,
                        Color = k.textcolor,
                        OutlineColor = k.textborder,
                        Center = false,
                        Hidden = true,
                        ZIndex = 55,
                        Position = h:Position(0, 4, 0, 3, aT),
                        Visible = ae.keybindslist.visible
                    })
                    local aX = h:Create("TextLabel", {Vector2.new(
                        aT.Size.X - 4 - h:GetTextBounds(aQ, k.textsize, k.font).X, 3), aT}, {
                        Text = "[" .. aR .. "]",
                        Size = k.textsize,
                        Font = k.font,
                        Color = k.textcolor,
                        OutlineColor = k.textborder,
                        Hidden = true,
                        ZIndex = 55,
                        Position = h:Position(1, -4 - h:GetTextBounds(aQ, k.textsize, k.font).X, 0, 3, aT),
                        Visible = ae.keybindslist.visible
                    })
                    function aS:Move(aY)
                        aT.Position = h:Position(0, 0, 1, -1 + aY, aK)
                        aU.Position = h:Position(0, 1, 0, 1, aT)
                        aV.Position = h:Position(0, 1, 0, 1, aU)
                        aW.Position = h:Position(0, 4, 0, 3, aT)
                        aX.Position = h:Position(1, -4 - aX.TextBounds.X, 0, 3, aT)
                    end
                    function aS:Remove()
                        h:Remove(aT, true)
                        h:Remove(aU, true)
                        h:Remove(aV, true)
                        h:Remove(aW, true)
                        h:Remove(aX, true)
                        ae.keybindslist.keybinds[aQ] = nil;
                        aS = nil
                    end
                    function aS:Visibility()
                        aT.Visible = ae.keybindslist.visible;
                        aU.Visible = ae.keybindslist.visible;
                        aV.Visible = ae.keybindslist.visible;
                        aW.Visible = ae.keybindslist.visible;
                        aX.Visible = ae.keybindslist.visible
                    end
                    ae.keybindslist.keybinds[aQ] = aS;
                    ae.keybindslist:Resort()
                end
            end
            function ae.keybindslist:Remove(aQ)
                if aQ and ae.keybindslist.keybinds[aQ] then
                    ae.keybindslist.keybinds[aQ]:Remove()
                    ae.keybindslist.keybinds[aQ] = nil;
                    ae.keybindslist:Resort()
                end
            end
            function ae.keybindslist:Visibility()
                aK.Visible = ae.keybindslist.visible;
                aL.Visible = ae.keybindslist.visible;
                aM.Visible = ae.keybindslist.visible;
                aN.Visible = ae.keybindslist.visible;
                aO.Visible = ae.keybindslist.visible;
                for F, G in pairs(ae.keybindslist.keybinds) do
                    G:Visibility()
                end
            end
            function ae.keybindslist:Update(aH, aI)
                if aH == "Visible" then
                    ae.keybindslist.visible = aI;
                    ae.keybindslist:Visibility()
                end
            end
            h:Connection(a.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), function()
                aK.Position = h:Position(0, 10, 0.4, 0)
                aL.Position = h:Position(0, 1, 0, 1, aK)
                aM.Position = h:Position(0, 1, 0, 1, aL)
                aN.Position = h:Position(0, 0, 0, 0, aM)
                aO.Position = h:Position(0.5, 0, 0, 5, aK)
                ae.keybindslist:Resort()
            end)
        end
        function ae:Cursor(aa)
            ae.cursor = {}
            local aZ = h:Create("Triangle", nil, {
                Color = k.cursoroutline,
                Thickness = 2.5,
                Filled = false,
                ZIndex = 65,
                Hidden = true
            })
            ae.cursor["cursor"] = aZ;
            local a_ = h:Create("Triangle", nil, {
                Color = k.accent,
                Filled = true,
                Thickness = 0,
                ZIndex = 65,
                Hidden = true
            })
            ae.cursor["cursor_inline"] = a_;
            h:Connection(c.RenderStepped, function()
                local S = h:MouseLocation()
                aZ.PointA = Vector2.new(S.X, S.Y)
                aZ.PointB = Vector2.new(S.X + 16, S.Y + 6)
                aZ.PointC = Vector2.new(S.X + 6, S.Y + 16)
                a_.PointA = Vector2.new(S.X, S.Y)
                a_.PointB = Vector2.new(S.X + 16, S.Y + 6)
                a_.PointC = Vector2.new(S.X + 6, S.Y + 16)
            end)
            b.MouseIconEnabled = false;
            return ae.cursor
        end
        function ae:Fade()
            ae.fading = true;
            ae.isVisible = not ae.isVisible;
            spawn(function()
                for F, G in pairs(g.drawings) do
                    h:Lerp(G[1], {
                        Transparency = ae.isVisible and G[3] or 0
                    }, 0.25)
                end
            end)
            ae.cursor["cursor"].Transparency = ae.isVisible and 1 or 0;
            ae.cursor["cursor_inline"].Transparency = ae.isVisible and 1 or 0;
            b.MouseIconEnabled = not ae.isVisible;
            ae.fading = false
        end
        function ae:Initialize()
            ae.pages[1]:Show()
            for F, G in pairs(ae.pages) do
                G:Update()
            end
            g.shared.initialized = true;
            ae:Watermark()
            ae:KeybindsList()
            ae:Cursor()
            ae:Fade()
        end
        g.began[#g.began + 1] = function(b0)
            if b0.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and ae.isVisible and
                h:MouseOverDrawing({af.Position.X, af.Position.Y, af.Position.X + af.Size.X, af.Position.Y + 20}) then
                local S = h:MouseLocation()
                ae.dragging = true;
                ae.drag = Vector2.new(S.X - af.Position.X, S.Y - af.Position.Y)
            end
        end;
        g.ended[#g.ended + 1] = function(b0)
            if b0.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and ae.dragging then
                ae.dragging = false;
                ae.drag = Vector2.new(0, 0)
            end
        end;
        g.changed[#g.changed + 1] = function(b0)
            if ae.dragging and ae.isVisible then
                local S = h:MouseLocation()
                if h:GetScreenSize().Y - af.Size.Y - 5 > 5 then
                    local b1 = Vector2.new(math.clamp(S.X - ae.drag.X, 5, h:GetScreenSize().X - af.Size.X - 5),
                        math.clamp(S.Y - ae.drag.Y, 5, h:GetScreenSize().Y - af.Size.Y - 5))
                    ae:Move(b1)
                else
                    local b1 = Vector2.new(S.X - ae.drag.X, S.Y - ae.drag.Y)
                    ae:Move(b1)
                end
            end
        end;
        g.began[#g.began + 1] = function(b0)
            if b0.KeyCode == ae.uibind then
                ae:Fade()
            end
        end;
        h:Connection(b.InputBegan, function(b0)
            for b2, b3 in pairs(g.began) do
                if not ae.dragging then
                    local b4, b5 = pcall(function()
                        b3(b0)
                    end)
                else
                    break
                end
            end
        end)
        h:Connection(b.InputEnded, function(b0)
            for b2, b3 in pairs(g.ended) do
                local b4, b5 = pcall(function()
                    b3(b0)
                end)
            end
        end)
        h:Connection(b.InputChanged, function()
            for b2, b3 in pairs(g.changed) do
                local b4, b5 = pcall(function()
                    b3()
                end)
            end
        end)
        h:Connection(a.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), function()
            ae:Move(Vector2.new(h:GetScreenSize().X / 2 - ac.X / 2, h:GetScreenSize().Y / 2 - ac.Y / 2))
        end)
        return setmetatable(ae, g)
    end
    function g:Page(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Page"
        local ae = self;
        local b6 = {
            open = false,
            sections = {},
            sectionOffset = {
                left = 0,
                right = 0
            },
            window = ae
        }
        local b7 = 4;
        for F, G in pairs(ae.pages) do
            b7 = b7 + G.page_button.Size.X + 2
        end
        local V = h:GetTextBounds(ab, k.textsize, k.font)
        local b8 = h:Create("Frame", {Vector2.new(b7, 4), ae.back_frame}, {
            Size = h:Size(0, V.X + 20, 0, 21),
            Position = h:Position(0, b7, 0, 4, ae.back_frame),
            Color = k.outline
        })
        b6["page_button"] = b8;
        local b9 = h:Create("Frame", {Vector2.new(1, 1), b8}, {
            Size = h:Size(1, -2, 1, -1, b8),
            Position = h:Position(0, 1, 0, 1, b8),
            Color = k.inline
        })
        b6["page_button_inline"] = b9;
        local ba = h:Create("Frame", {Vector2.new(1, 1), b9}, {
            Size = h:Size(1, -2, 1, -1, b9),
            Position = h:Position(0, 1, 0, 1, b9),
            Color = k.dark_contrast
        })
        b6["page_button_color"] = ba;
        local bb = h:Create("TextLabel", {Vector2.new(h:Position(0.5, 0, 0, 2, ba).X - ba.Position.X, 2), ba}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            Center = true,
            OutlineColor = k.textborder,
            Position = h:Position(0.5, 0, 0, 2, ba)
        })
        ae.pages[#ae.pages + 1] = b6;
        function b6:Update()
            b6.sectionOffset["left"] = 0;
            b6.sectionOffset["right"] = 0;
            for F, G in pairs(b6.sections) do
                h:UpdateOffset(G.section_inline, {Vector2.new(G.side == "right" and ae.tab_frame.Size.X / 2 + 2 or 5,
                    5 + b6["sectionOffset"][G.side]), ae.tab_frame})
                b6.sectionOffset[G.side] = b6.sectionOffset[G.side] + G.section_inline.Size.Y + 5
            end
            ae:Move(ae.main_frame.Position)
        end
        function b6:Show()
            if ae.currentPage then
                ae.currentPage.page_button_color.Size = h:Size(1, -2, 1, -1, ae.currentPage.page_button_inline)
                ae.currentPage.page_button_color.Color = k.dark_contrast;
                ae.currentPage.open = false;
                for F, G in pairs(ae.currentPage.sections) do
                    for a9, q in pairs(G.visibleContent) do
                        q.Visible = false
                    end
                end
                ae:CloseContent()
            end
            ae.currentPage = b6;
            ba.Size = h:Size(1, -2, 1, 0, b9)
            ba.Color = k.light_contrast;
            b6.open = true;
            for F, G in pairs(b6.sections) do
                for a9, q in pairs(G.visibleContent) do
                    q.Visible = true
                end
            end
        end
        g.began[#g.began + 1] = function(b0)
            if b0.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and
                h:MouseOverDrawing({b8.Position.X, b8.Position.Y, b8.Position.X + b8.Size.X, b8.Position.Y + b8.Size.Y}) and
                ae.currentPage ~= b6 then
                b6:Show()
            end
        end;
        return setmetatable(b6, i)
    end
    function i:Section(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Section"
        local bc = aa.side or aa.Side or "left"
        bc = bc:lower()
        local ae = self.window;
        local b6 = self;
        local bd = {
            window = ae,
            page = b6,
            visibleContent = {},
            currentAxis = 20,
            side = bc
        }
        local be = h:Create("Frame", {Vector2.new(bc == "right" and ae.tab_frame.Size.X / 2 + 2 or 5,
            5 + b6["sectionOffset"][bc]), ae.tab_frame}, {
            Size = h:Size(0.5, -7, 0, 22, ae.tab_frame),
            Position = h:Position(bc == "right" and 0.5 or 0, bc == "right" and 2 or 5, 0, 5 + b6.sectionOffset[bc],
                ae.tab_frame),
            Color = k.inline,
            Visible = b6.open
        }, bd.visibleContent)
        bd["section_inline"] = be;
        local bf = h:Create("Frame", {Vector2.new(1, 1), be}, {
            Size = h:Size(1, -2, 1, -2, be),
            Position = h:Position(0, 1, 0, 1, be),
            Color = k.outline,
            Visible = b6.open
        }, bd.visibleContent)
        bd["section_outline"] = bf;
        local bg = h:Create("Frame", {Vector2.new(1, 1), bf}, {
            Size = h:Size(1, -2, 1, -2, bf),
            Position = h:Position(0, 1, 0, 1, bf),
            Color = k.dark_contrast,
            Visible = b6.open
        }, bd.visibleContent)
        bd["section_frame"] = bg;
        local bh = h:Create("Frame", {Vector2.new(0, 0), bg}, {
            Size = h:Size(1, 0, 0, 2, bg),
            Position = h:Position(0, 0, 0, 0, bg),
            Color = k.accent,
            Visible = b6.open
        }, bd.visibleContent)
        bd["section_accent"] = bh;
        local bi = h:Create("TextLabel", {Vector2.new(3, 3), bg}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 3, 0, 3, bg),
            Visible = b6.open
        }, bd.visibleContent)
        bd["section_title"] = bi;
        function bd:Update()
            be.Size = h:Size(0.5, -7, 0, bd.currentAxis + 4, ae.tab_frame)
            bf.Size = h:Size(1, -2, 1, -2, be)
            bg.Size = h:Size(1, -2, 1, -2, bf)
        end
        b6.sectionOffset[bc] = b6.sectionOffset[bc] + 100 + 5;
        b6.sections[#b6.sections + 1] = bd;
        return setmetatable(bd, j)
    end
    function i:MultiSection(aa)
        local aa = aa or {}
        local bj = aa.sections or aa.Sections or {}
        local bc = aa.side or aa.Side or "left"
        local ac = aa.size or aa.Size or 150;
        bc = bc:lower()
        local ae = self.window;
        local b6 = self;
        local bk = {
            window = ae,
            page = b6,
            sections = {},
            backup = {},
            visibleContent = {},
            currentSection = nil,
            xAxis = 0,
            side = bc
        }
        local bl = h:Create("Frame", {Vector2.new(bc == "right" and ae.tab_frame.Size.X / 2 + 2 or 5,
            5 + b6["sectionOffset"][bc]), ae.tab_frame}, {
            Size = h:Size(0.5, -7, 0, ac, ae.tab_frame),
            Position = h:Position(bc == "right" and 0.5 or 0, bc == "right" and 2 or 5, 0, 5 + b6.sectionOffset[bc],
                ae.tab_frame),
            Color = k.inline,
            Visible = b6.open
        }, bk.visibleContent)
        bk["section_inline"] = bl;
        local bm = h:Create("Frame", {Vector2.new(1, 1), bl}, {
            Size = h:Size(1, -2, 1, -2, bl),
            Position = h:Position(0, 1, 0, 1, bl),
            Color = k.outline,
            Visible = b6.open
        }, bk.visibleContent)
        bk["section_outline"] = bm;
        local bn = h:Create("Frame", {Vector2.new(1, 1), bm}, {
            Size = h:Size(1, -2, 1, -2, bm),
            Position = h:Position(0, 1, 0, 1, bm),
            Color = k.dark_contrast,
            Visible = b6.open
        }, bk.visibleContent)
        bk["section_frame"] = bn;
        local bo = h:Create("Frame", {Vector2.new(0, 2), bn}, {
            Size = h:Size(1, 0, 0, 17, bn),
            Position = h:Position(0, 0, 0, 2, bn),
            Color = k.light_contrast,
            Visible = b6.open
        }, bk.visibleContent)
        local bp = h:Create("Frame", {Vector2.new(0, bo.Size.Y - 1), bo}, {
            Size = h:Size(1, 0, 0, 1, bo),
            Position = h:Position(0, 0, 1, -1, bo),
            Color = k.outline,
            Visible = b6.open
        }, bk.visibleContent)
        local bq = h:Create("Frame", {Vector2.new(0, 0), bn}, {
            Size = h:Size(1, 0, 0, 2, bn),
            Position = h:Position(0, 0, 0, 0, bn),
            Color = k.accent,
            Visible = b6.open
        }, bk.visibleContent)
        bk["section_accent"] = bq;
        for F, G in pairs(bj) do
            local br = {
                window = ae,
                page = b6,
                currentAxis = 24,
                sections = {},
                visibleContent = {},
                section_inline = bl,
                section_outline = bm,
                section_frame = bn,
                section_accent = bq
            }
            local bs = h:GetTextBounds(G, k.textsize, k.font)
            local bt = h:Create("Frame", {Vector2.new(bk.xAxis, 0), bo}, {
                Size = h:Size(0, bs.X + 14, 1, -1, bo),
                Position = h:Position(0, bk.xAxis, 0, 0, bo),
                Color = F == 1 and k.dark_contrast or k.light_contrast,
                Visible = b6.open
            }, bk.visibleContent)
            br["msection_frame"] = bt;
            local bu = h:Create("Frame", {Vector2.new(bt.Size.X, 0), bt}, {
                Size = h:Size(0, 1, 1, 0, bt),
                Position = h:Position(1, 0, 0, 0, bt),
                Color = k.outline,
                Visible = b6.open
            }, bk.visibleContent)
            local bv = h:Create("TextLabel", {Vector2.new(bt.Size.X * 0.5, 1), bt}, {
                Text = G,
                Size = k.textsize,
                Font = k.font,
                Color = k.textcolor,
                OutlineColor = k.textborder,
                Center = true,
                Position = h:Position(0.5, 0, 0, 1, bt),
                Visible = b6.open
            }, bk.visibleContent)
            local bw = h:Create("Frame", {Vector2.new(0, bt.Size.Y), bt}, {
                Size = h:Size(1, 0, 0, 1, bt),
                Position = h:Position(0, 0, 1, 0, bt),
                Color = F == 1 and k.dark_contrast or k.outline,
                Visible = b6.open
            }, bk.visibleContent)
            br["msection_bottomline"] = bw;
            function br:Update()
                if bk.currentSection == br then
                    bk.visibleContent = h:Combine(bk.backup, bk.currentSection.visibleContent)
                else
                    for a9, q in pairs(br.visibleContent) do
                        q.Visible = false
                    end
                end
            end
            g.began[#g.began + 1] = function(b0)
                if b0.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and b6.open and
                    h:MouseOverDrawing(
                        {bt.Position.X, bt.Position.Y, bt.Position.X + bt.Size.X, bt.Position.Y + bt.Size.Y}) and
                    bk.currentSection ~= br and not ae:IsOverContent() then
                    bk.currentSection.msection_frame.Color = k.light_contrast;
                    bk.currentSection.msection_bottomline.Color = k.outline;
                    for F, G in pairs(bk.currentSection.visibleContent) do
                        G.Visible = false
                    end
                    bk.currentSection = br;
                    bt.Color = k.dark_contrast;
                    bw.Color = k.dark_contrast;
                    for F, G in pairs(bk.currentSection.visibleContent) do
                        G.Visible = true
                    end
                    bk.visibleContent = h:Combine(bk.backup, bk.currentSection.visibleContent)
                end
            end;
            if F == 1 then
                bk.currentSection = br
            end
            bk.sections[#bk.sections + 1] = setmetatable(br, j)
            bk.xAxis = bk.xAxis + bs.X + 15
        end
        for a9, q in pairs(bk.visibleContent) do
            bk.backup[a9] = q
        end
        b6.sectionOffset[bc] = b6.sectionOffset[bc] + 100 + 5;
        b6.sections[#b6.sections + 1] = bk;
        return table.unpack(bk.sections)
    end
    function j:Label(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Label"
        local bx = aa.middle or aa.Middle or false;
        local by = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local ae = self.window;
        local b6 = self.page;
        local bd = self;
        local bz = {
            axis = bd.currentAxis
        }
        local bA = h:Create("TextLabel",
            {Vector2.new(bx and bd.section_frame.Size.X / 2 or 4, bz.axis), bd.section_frame}, {
                Text = ab,
                Size = k.textsize,
                Font = k.font,
                Color = k.textcolor,
                OutlineColor = k.textborder,
                Center = bx,
                Position = h:Position(bx and 0.5 or 0, bx and 0 or 4, 0, 0, bd.section_frame),
                Visible = b6.open
            }, bd.visibleContent)
        if by and tostring(by) ~= "" and tostring(by) ~= " " and not g.pointers[tostring(by)] then
            g.pointers[tostring(by)] = bz
        end
        bd.currentAxis = bd.currentAxis + bA.TextBounds.Y + 4;
        bd:Update()
        function bz:Set(bB)
            if bB or not bB then
                bz.current = bB;
                aa.name = bB
            end
        end
        return bz
    end
    function j:Toggle(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Toggle"
        local bC = aa.def or aa.Def or aa.default or aa.Default or false;
        local by = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local bD = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        local ae = self.window;
        local b6 = self.page;
        local bd = self;
        local bE = {
            axis = bd.currentAxis,
            current = bC,
            addedAxis = 0,
            colorpickers = 0,
            keybind = nil
        }
        local bF = h:Create("Frame", {Vector2.new(4, bE.axis), bd.section_frame}, {
            Size = h:Size(0, 15, 0, 15),
            Position = h:Position(0, 4, 0, bE.axis, bd.section_frame),
            Color = k.outline,
            Visible = b6.open
        }, bd.visibleContent)
        local bG = h:Create("Frame", {Vector2.new(1, 1), bF}, {
            Size = h:Size(1, -2, 1, -2, bF),
            Position = h:Position(0, 1, 0, 1, bF),
            Color = k.inline,
            Visible = b6.open
        }, bd.visibleContent)
        local bH = h:Create("Frame", {Vector2.new(1, 1), bG}, {
            Size = h:Size(1, -2, 1, -2, bG),
            Position = h:Position(0, 1, 0, 1, bG),
            Color = bE.current == true and k.accent or k.light_contrast,
            Visible = b6.open
        }, bd.visibleContent)
        local bI = h:Create("Image", {Vector2.new(0, 0), bH}, {
            Size = h:Size(1, 0, 1, 0, bH),
            Position = h:Position(0, 0, 0, 0, bH),
            Transparency = 0.5,
            Visible = b6.open
        }, bd.visibleContent)
        local bJ = h:Create("TextLabel", {Vector2.new(23,
            bE.axis + 15 / 2 - h:GetTextBounds(ab, k.textsize, k.font).Y / 2), bd.section_frame}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 23, 0, bE.axis + 15 / 2 - h:GetTextBounds(ab, k.textsize, k.font).Y / 2,
                bd.section_frame),
            Visible = b6.open
        }, bd.visibleContent)
        h:LoadImage(bI, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function bE:Get()
            return bE.current
        end
        function bE:Set(bB)
            if bB or not bB then
                bE.current = bB;
                bH.Color = bE.current == true and k.accent or k.light_contrast;
                bD(bE.current)
            end
        end
        g.began[#g.began + 1] = function(b0)
            if b0.UserInputType == Enum.UserInputType.MouseButton1 and bF.Visible and ae.isVisible and b6.open and
                h:MouseOverDrawing({bd.section_frame.Position.X, bd.section_frame.Position.Y + bE.axis,
                                    bd.section_frame.Position.X + bd.section_frame.Size.X - bE.addedAxis,
                                    bd.section_frame.Position.Y + bE.axis + 15}) and not ae:IsOverContent() then
                bE.current = not bE.current;
                bH.Color = bE.current == true and k.accent or k.light_contrast;
                bD(bE.current)
                if bE.keybind and bE.keybind.active then
                    bE.keybind.active = false;
                    ae.keybindslist:Remove(bE.keybind.keybindname)
                end
            end
        end;
        if by and tostring(by) ~= "" and tostring(by) ~= " " and not g.pointers[tostring(by)] then
            g.pointers[tostring(by)] = bE
        end
        bd.currentAxis = bd.currentAxis + 15 + 4;
        bd:Update()
        function bE:Colorpicker(aa)
            local aa = aa or {}
            local bK = aa.info or aa.Info or ab;
            local bC = aa.def or aa.Def or aa.default or aa.Default or Color3.fromRGB(255, 0, 0)
            local bL = aa.transparency or aa.Transparency or aa.transp or aa.Transp or aa.alpha or aa.Alpha or nil;
            local by = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
            local bD = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
            end;
            local bM, bN, bO = bC:ToHSV()
            local ax = {
                bE,
                axis = bE.axis,
                index = bE.colorpickers,
                current = {bM, bN, bO, bL or 0},
                holding = {
                    picker = false,
                    huepicker = false,
                    transparency = false
                },
                holder = {
                    inline = nil,
                    picker = nil,
                    picker_cursor = nil,
                    huepicker = nil,
                    huepicker_cursor = {},
                    transparency = nil,
                    transparencybg = nil,
                    transparency_cursor = {},
                    drawings = {}
                }
            }
            local bP = h:Create("Frame", {Vector2.new(
                bd.section_frame.Size.X - (bE.colorpickers == 0 and 30 + 4 or 64 + 4), ax.axis), bd.section_frame}, {
                Size = h:Size(0, 30, 0, 15),
                Position = h:Position(1, -(bE.colorpickers == 0 and 30 + 4 or 64 + 4), 0, ax.axis, bd.section_frame),
                Color = k.outline,
                Visible = b6.open
            }, bd.visibleContent)
            local bQ = h:Create("Frame", {Vector2.new(1, 1), bP}, {
                Size = h:Size(1, -2, 1, -2, bP),
                Position = h:Position(0, 1, 0, 1, bP),
                Color = k.inline,
                Visible = b6.open
            }, bd.visibleContent)
            local bR;
            if bL then
                bR = h:Create("Image", {Vector2.new(1, 1), bQ}, {
                    Size = h:Size(1, -2, 1, -2, bQ),
                    Position = h:Position(0, 1, 0, 1, bQ),
                    Visible = b6.open
                }, bd.visibleContent)
            end
            local bS = h:Create("Frame", {Vector2.new(1, 1), bQ}, {
                Size = h:Size(1, -2, 1, -2, bQ),
                Position = h:Position(0, 1, 0, 1, bQ),
                Color = bC,
                Transparency = bL and 1 - bL or 1,
                Visible = b6.open
            }, bd.visibleContent)
            local bT = h:Create("Image", {Vector2.new(0, 0), bS}, {
                Size = h:Size(1, 0, 1, 0, bS),
                Position = h:Position(0, 0, 0, 0, bS),
                Transparency = 0.5,
                Visible = b6.open
            }, bd.visibleContent)
            if bL then
                h:LoadImage(bR, "cptransp", "https://i.imgur.com/IIPee2A.png")
            end
            h:LoadImage(bT, "gradient", "https://i.imgur.com/5hmlrjX.png")
            function ax:Set(bU, bV)
                if typeof(bU) == "table" then
                    if bU.Color and bU.Transparency then
                        local bW, b5, G = table.unpack(bU.Color)
                        ax.current = {bW, b5, G, bU.Transparency}
                        bS.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                        bS.Transparency = 1 - ax.current[4]
                        bD(Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3]), ax.current[4])
                    else
                        ax.current = bU;
                        bS.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                        bS.Transparency = 1 - ax.current[4]
                        bD(Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3]), ax.current[4])
                    end
                elseif typeof(bU) == "color3" then
                    local bW, b5, G = bU:ToHSV()
                    ax.current = {bW, b5, G, bV or 0}
                    bS.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                    bS.Transparency = 1 - ax.current[4]
                    bD(Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3]), ax.current[4])
                end
            end
            function ax:Refresh()
                local S = h:MouseLocation()
                if ax.open and ax.holder.picker and ax.holding.picker then
                    ax.current[2] = math.clamp(S.X - ax.holder.picker.Position.X, 0, ax.holder.picker.Size.X) /
                                        ax.holder.picker.Size.X;
                    ax.current[3] = 1 - math.clamp(S.Y - ax.holder.picker.Position.Y, 0, ax.holder.picker.Size.Y) /
                                        ax.holder.picker.Size.Y;
                    ax.holder.picker_cursor.Position = h:Position(ax.current[2], -3, 1 - ax.current[3], -3,
                        ax.holder.picker)
                    h:UpdateOffset(ax.holder.picker_cursor,
                        {Vector2.new(ax.holder.picker.Size.X * ax.current[2] - 3,
                            ax.holder.picker.Size.Y * (1 - ax.current[3]) - 3), ax.holder.picker})
                    if ax.holder.transparencybg then
                        ax.holder.transparencybg.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                    end
                elseif ax.open and ax.holder.huepicker and ax.holding.huepicker then
                    ax.current[1] = math.clamp(S.Y - ax.holder.huepicker.Position.Y, 0, ax.holder.huepicker.Size.Y) /
                                        ax.holder.huepicker.Size.Y;
                    ax.holder.huepicker_cursor[1].Position = h:Position(0, -3, ax.current[1], -3, ax.holder.huepicker)
                    ax.holder.huepicker_cursor[2].Position = h:Position(0, 1, 0, 1, ax.holder.huepicker_cursor[1])
                    ax.holder.huepicker_cursor[3].Position = h:Position(0, 1, 0, 1, ax.holder.huepicker_cursor[2])
                    ax.holder.huepicker_cursor[3].Color = Color3.fromHSV(ax.current[1], 1, 1)
                    h:UpdateOffset(ax.holder.huepicker_cursor[1], {Vector2.new(-3, ax.holder.huepicker.Size.Y *
                        ax.current[1] - 3), ax.holder.huepicker})
                    ax.holder.background.Color = Color3.fromHSV(ax.current[1], 1, 1)
                    if ax.holder.transparency_cursor and ax.holder.transparency_cursor[3] then
                        ax.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - ax.current[4])
                    end
                    if ax.holder.transparencybg then
                        ax.holder.transparencybg.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                    end
                elseif ax.open and ax.holder.transparency and ax.holding.transparency then
                    ax.current[4] = 1 -
                                        math.clamp(S.X - ax.holder.transparency.Position.X, 0,
                            ax.holder.transparency.Size.X) / ax.holder.transparency.Size.X;
                    ax.holder.transparency_cursor[1].Position =
                        h:Position(1 - ax.current[4], -3, 0, -3, ax.holder.transparency)
                    ax.holder.transparency_cursor[2].Position = h:Position(0, 1, 0, 1, ax.holder.transparency_cursor[1])
                    ax.holder.transparency_cursor[3].Position = h:Position(0, 1, 0, 1, ax.holder.transparency_cursor[2])
                    ax.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - ax.current[4])
                    bS.Transparency = 1 - ax.current[4]
                    h:UpdateTransparency(bS, 1 - ax.current[4])
                    h:UpdateOffset(ax.holder.transparency_cursor[1], {Vector2.new(
                        ax.holder.transparency.Size.X * (1 - ax.current[4]) - 3, -3), ax.holder.transparency})
                    ax.holder.background.Color = Color3.fromHSV(ax.current[1], 1, 1)
                end
                ax:Set(ax.current)
            end
            function ax:Get()
                return {
                    Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3]),
                    Transparency = ax.current[4]
                }
            end
            g.began[#g.began + 1] = function(b0)
                if b0.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and bP.Visible then
                    if ax.open and ax.holder.inline and
                        h:MouseOverDrawing({ax.holder.inline.Position.X, ax.holder.inline.Position.Y,
                                            ax.holder.inline.Position.X + ax.holder.inline.Size.X,
                                            ax.holder.inline.Position.Y + ax.holder.inline.Size.Y}) then
                        if ax.holder.picker and
                            h:MouseOverDrawing({ax.holder.picker.Position.X - 2, ax.holder.picker.Position.Y - 2,
                                                ax.holder.picker.Position.X - 2 + ax.holder.picker.Size.X + 4,
                                                ax.holder.picker.Position.Y - 2 + ax.holder.picker.Size.Y + 4}) then
                            ax.holding.picker = true;
                            ax:Refresh()
                        elseif ax.holder.huepicker and
                            h:MouseOverDrawing({ax.holder.huepicker.Position.X - 2, ax.holder.huepicker.Position.Y - 2,
                                                ax.holder.huepicker.Position.X - 2 + ax.holder.huepicker.Size.X + 4,
                                                ax.holder.huepicker.Position.Y - 2 + ax.holder.huepicker.Size.Y + 4}) then
                            ax.holding.huepicker = true;
                            ax:Refresh()
                        elseif ax.holder.transparency and
                            h:MouseOverDrawing(
                                {ax.holder.transparency.Position.X - 2, ax.holder.transparency.Position.Y - 2,
                                 ax.holder.transparency.Position.X - 2 + ax.holder.transparency.Size.X + 4,
                                 ax.holder.transparency.Position.Y - 2 + ax.holder.transparency.Size.Y + 4}) then
                            ax.holding.transparency = true;
                            ax:Refresh()
                        end
                    elseif h:MouseOverDrawing({bd.section_frame.Position.X + bd.section_frame.Size.X -
                        (ax.index == 0 and 30 + 4 + 2 or 64 + 4 + 2), bd.section_frame.Position.Y + ax.axis,
                                               bd.section_frame.Position.X + bd.section_frame.Size.X -
                        (ax.index == 1 and 36 or 0), bd.section_frame.Position.Y + ax.axis + 15}) and
                        not ae:IsOverContent() then
                        if not ax.open then
                            ae:CloseContent()
                            ax.open = not ax.open;
                            local bX = h:Create("Frame", {Vector2.new(4, ax.axis + 19), bd.section_frame}, {
                                Size = h:Size(1, -8, 0, bL and 219 or 200, bd.section_frame),
                                Position = h:Position(0, 4, 0, ax.axis + 19, bd.section_frame),
                                Color = k.outline
                            }, ax.holder.drawings)
                            ax.holder.inline = bX;
                            local bY = h:Create("Frame", {Vector2.new(1, 1), bX}, {
                                Size = h:Size(1, -2, 1, -2, bX),
                                Position = h:Position(0, 1, 0, 1, bX),
                                Color = k.inline
                            }, ax.holder.drawings)
                            local bZ = h:Create("Frame", {Vector2.new(1, 1), bY}, {
                                Size = h:Size(1, -2, 1, -2, bY),
                                Position = h:Position(0, 1, 0, 1, bY),
                                Color = k.dark_contrast
                            }, ax.holder.drawings)
                            local b_ = h:Create("Frame", {Vector2.new(0, 0), bZ}, {
                                Size = h:Size(1, 0, 0, 2, bZ),
                                Position = h:Position(0, 0, 0, 0, bZ),
                                Color = k.accent
                            }, ax.holder.drawings)
                            local c0 = h:Create("TextLabel", {Vector2.new(4, 2), bZ}, {
                                Text = bK,
                                Size = k.textsize,
                                Font = k.font,
                                Color = k.textcolor,
                                OutlineColor = k.textborder,
                                Position = h:Position(0, 4, 0, 2, bZ)
                            }, ax.holder.drawings)
                            local c1 = h:Create("Frame", {Vector2.new(4, 17), bZ}, {
                                Size = h:Size(1, -27, 1, bL and -40 or -21, bZ),
                                Position = h:Position(0, 4, 0, 17, bZ),
                                Color = k.outline
                            }, ax.holder.drawings)
                            local c2 = h:Create("Frame", {Vector2.new(1, 1), c1}, {
                                Size = h:Size(1, -2, 1, -2, c1),
                                Position = h:Position(0, 1, 0, 1, c1),
                                Color = k.inline
                            }, ax.holder.drawings)
                            local c3 = h:Create("Frame", {Vector2.new(1, 1), c2}, {
                                Size = h:Size(1, -2, 1, -2, c2),
                                Position = h:Position(0, 1, 0, 1, c2),
                                Color = Color3.fromHSV(ax.current[1], 1, 1)
                            }, ax.holder.drawings)
                            ax.holder.background = c3;
                            local c4 = h:Create("Image", {Vector2.new(0, 0), c3}, {
                                Size = h:Size(1, 0, 1, 0, c3),
                                Position = h:Position(0, 0, 0, 0, c3)
                            }, ax.holder.drawings)
                            ax.holder.picker = c4;
                            local c5 = h:Create("Image", {Vector2.new(c4.Size.X * ax.current[2] - 3,
                                c4.Size.Y * (1 - ax.current[3]) - 3), c4}, {
                                Size = h:Size(0, 6, 0, 6, c4),
                                Position = h:Position(ax.current[2], -3, 1 - ax.current[3], -3, c4)
                            }, ax.holder.drawings)
                            ax.holder.picker_cursor = c5;
                            local c6 = h:Create("Frame", {Vector2.new(bZ.Size.X - 19, 17), bZ}, {
                                Size = h:Size(0, 15, 1, bL and -40 or -21, bZ),
                                Position = h:Position(1, -19, 0, 17, bZ),
                                Color = k.outline
                            }, ax.holder.drawings)
                            local c7 = h:Create("Frame", {Vector2.new(1, 1), c6}, {
                                Size = h:Size(1, -2, 1, -2, c6),
                                Position = h:Position(0, 1, 0, 1, c6),
                                Color = k.inline
                            }, ax.holder.drawings)
                            local c8 = h:Create("Image", {Vector2.new(1, 1), c7}, {
                                Size = h:Size(1, -2, 1, -2, c7),
                                Position = h:Position(0, 1, 0, 1, c7)
                            }, ax.holder.drawings)
                            ax.holder.huepicker = c8;
                            local c9 = h:Create("Frame", {Vector2.new(-3, c8.Size.Y * ax.current[1] - 3), c8}, {
                                Size = h:Size(1, 6, 0, 6, c8),
                                Position = h:Position(0, -3, ax.current[1], -3, c8),
                                Color = k.outline
                            }, ax.holder.drawings)
                            ax.holder.huepicker_cursor[1] = c9;
                            local ca = h:Create("Frame", {Vector2.new(1, 1), c9}, {
                                Size = h:Size(1, -2, 1, -2, c9),
                                Position = h:Position(0, 1, 0, 1, c9),
                                Color = k.textcolor
                            }, ax.holder.drawings)
                            ax.holder.huepicker_cursor[2] = ca;
                            local cb = h:Create("Frame", {Vector2.new(1, 1), ca}, {
                                Size = h:Size(1, -2, 1, -2, ca),
                                Position = h:Position(0, 1, 0, 1, ca),
                                Color = Color3.fromHSV(ax.current[1], 1, 1)
                            }, ax.holder.drawings)
                            ax.holder.huepicker_cursor[3] = cb;
                            if bL then
                                local cc = h:Create("Frame", {Vector2.new(4, bZ.Size.X - 19), bZ}, {
                                    Size = h:Size(1, -27, 0, 15, bZ),
                                    Position = h:Position(0, 4, 1, -19, bZ),
                                    Color = k.outline
                                }, ax.holder.drawings)
                                local cd = h:Create("Frame", {Vector2.new(1, 1), cc}, {
                                    Size = h:Size(1, -2, 1, -2, cc),
                                    Position = h:Position(0, 1, 0, 1, cc),
                                    Color = k.inline
                                }, ax.holder.drawings)
                                local ce = h:Create("Frame", {Vector2.new(1, 1), cd}, {
                                    Size = h:Size(1, -2, 1, -2, cd),
                                    Position = h:Position(0, 1, 0, 1, cd),
                                    Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                                }, ax.holder.drawings)
                                ax.holder.transparencybg = ce;
                                local cf = h:Create("Image", {Vector2.new(1, 1), cd}, {
                                    Size = h:Size(1, -2, 1, -2, cd),
                                    Position = h:Position(0, 1, 0, 1, cd)
                                }, ax.holder.drawings)
                                ax.holder.transparency = cf;
                                local cg = h:Create("Frame", {Vector2.new(cf.Size.X * (1 - ax.current[4]) - 3, -3), cf},
                                    {
                                        Size = h:Size(0, 6, 1, 6, cf),
                                        Position = h:Position(1 - ax.current[4], -3, 0, -3, cf),
                                        Color = k.outline
                                    }, ax.holder.drawings)
                                ax.holder.transparency_cursor[1] = cg;
                                local ch = h:Create("Frame", {Vector2.new(1, 1), cg}, {
                                    Size = h:Size(1, -2, 1, -2, cg),
                                    Position = h:Position(0, 1, 0, 1, cg),
                                    Color = k.textcolor
                                }, ax.holder.drawings)
                                ax.holder.transparency_cursor[2] = ch;
                                local ci = h:Create("Frame", {Vector2.new(1, 1), ch}, {
                                    Size = h:Size(1, -2, 1, -2, ch),
                                    Position = h:Position(0, 1, 0, 1, ch),
                                    Color = Color3.fromHSV(0, 0, 1 - ax.current[4])
                                }, ax.holder.drawings)
                                ax.holder.transparency_cursor[3] = ci;
                                h:LoadImage(cf, "transp", "https://i.imgur.com/ncssKbH.png")
                            end
                            h:LoadImage(c4, "valsat", "https://i.imgur.com/wpDRqVH.png")
                            h:LoadImage(c5, "valsat_cursor",
                                "https://raw.githubusercontent.com/mvonwalk/splix-assets/main/Images-cursor.png")
                            h:LoadImage(c8, "hue", "https://i.imgur.com/iEOsHFv.png")
                            ae.currentContent.frame = bY;
                            ae.currentContent.colorpicker = ax
                        else
                            ax.open = not ax.open;
                            for F, G in pairs(ax.holder.drawings) do
                                h:Remove(G)
                            end
                            ax.holder.drawings = {}
                            ax.holder.inline = nil;
                            ae.currentContent.frame = nil;
                            ae.currentContent.colorpicker = nil
                        end
                    else
                        if ax.open then
                            ax.open = not ax.open;
                            for F, G in pairs(ax.holder.drawings) do
                                h:Remove(G)
                            end
                            ax.holder.drawings = {}
                            ax.holder.inline = nil;
                            ae.currentContent.frame = nil;
                            ae.currentContent.colorpicker = nil
                        end
                    end
                elseif b0.UserInputType == Enum.UserInputType.MouseButton1 and ax.open then
                    ax.open = not ax.open;
                    for F, G in pairs(ax.holder.drawings) do
                        h:Remove(G)
                    end
                    ax.holder.drawings = {}
                    ax.holder.inline = nil;
                    ae.currentContent.frame = nil;
                    ae.currentContent.colorpicker = nil
                end
            end;
            g.ended[#g.ended + 1] = function(b0)
                if b0.UserInputType == Enum.UserInputType.MouseButton1 then
                    if ax.holding.picker then
                        ax.holding.picker = not ax.holding.picker
                    end
                    if ax.holding.huepicker then
                        ax.holding.huepicker = not ax.holding.huepicker
                    end
                    if ax.holding.transparency then
                        ax.holding.transparency = not ax.holding.transparency
                    end
                end
            end;
            g.changed[#g.changed + 1] = function()
                if ax.open and ax.holding.picker or ax.holding.huepicker or ax.holding.transparency then
                    if ae.isVisible then
                        ax:Refresh()
                    else
                        if ax.holding.picker then
                            ax.holding.picker = not ax.holding.picker
                        end
                        if ax.holding.huepicker then
                            ax.holding.huepicker = not ax.holding.huepicker
                        end
                        if ax.holding.transparency then
                            ax.holding.transparency = not ax.holding.transparency
                        end
                    end
                end
            end;
            if by and tostring(by) ~= "" and tostring(by) ~= " " and not g.pointers[tostring(by)] then
                g.pointers[tostring(by)] = ax
            end
            bE.addedAxis = bE.addedAxis + 30 + 4 + 2;
            bE.colorpickers = bE.colorpickers + 1;
            bd:Update()
            return ax, bE
        end
        function bE:Keybind(aa)
            local aa = aa or {}
            local bC = aa.def or aa.Def or aa.default or aa.Default or nil;
            local by = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
            local cj = aa.mode or aa.Mode or "Always"
            local aQ = aa.keybindname or aa.keybindName or aa.KeybindName or aa.Keybindname or nil;
            local bD = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
            end;
            bE.addedaxis = bE.addedAxis + 40 + 4 + 2;
            local keybind = {
                keybindname = aQ or ab,
                axis = bE.axis,
                current = {},
                selecting = false,
                mode = cj,
                open = false,
                modemenu = {
                    buttons = {},
                    drawings = {}
                },
                active = false
            }
            bE.keybind = keybind;
            local ck = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L",
                        "Z", "X", "C", "V", "B", "N", "M", "One", "Two", "Three", "Four", "Five", "Six", "Seveen",
                        "Eight", "Nine", "0", "Insert", "Tab", "Home", "End", "LeftAlt", "LeftControl", "LeftShift",
                        "RightAlt", "RightControl", "RightShift", "CapsLock"}
            local cl = {"MouseButton1", "MouseButton2", "MouseButton3"}
            local cm = {
                ["MouseButton1"] = "MB1",
                ["MouseButton2"] = "MB2",
                ["MouseButton3"] = "MB3",
                ["Insert"] = "Ins",
                ["LeftAlt"] = "LAlt",
                ["LeftControl"] = "LC",
                ["LeftShift"] = "LS",
                ["RightAlt"] = "RAlt",
                ["RightControl"] = "RC",
                ["RightShift"] = "RS",
                ["CapsLock"] = "Caps"
            }
            local aT = h:Create("Frame",
                {Vector2.new(bd.section_frame.Size.X - (40 + 4), keybind.axis), bd.section_frame}, {
                    Size = h:Size(0, 40, 0, 17),
                    Position = h:Position(1, -(40 + 4), 0, keybind.axis, bd.section_frame),
                    Color = k.outline,
                    Visible = b6.open
                }, bd.visibleContent)
            local aU = h:Create("Frame", {Vector2.new(1, 1), aT}, {
                Size = h:Size(1, -2, 1, -2, aT),
                Position = h:Position(0, 1, 0, 1, aT),
                Color = k.inline,
                Visible = b6.open
            }, bd.visibleContent)
            local aV = h:Create("Frame", {Vector2.new(1, 1), aU}, {
                Size = h:Size(1, -2, 1, -2, aU),
                Position = h:Position(0, 1, 0, 1, aU),
                Color = k.light_contrast,
                Visible = b6.open
            }, bd.visibleContent)
            local cn = h:Create("Image", {Vector2.new(0, 0), aV}, {
                Size = h:Size(1, 0, 1, 0, aV),
                Position = h:Position(0, 0, 0, 0, aV),
                Transparency = 0.5,
                Visible = b6.open
            }, bd.visibleContent)
            local aX = h:Create("TextLabel", {Vector2.new(aT.Size.X / 2, 1), aT}, {
                Text = "...",
                Size = k.textsize,
                Font = k.font,
                Color = k.textcolor,
                OutlineColor = k.textborder,
                Center = true,
                Position = h:Position(0.5, 0, 1, 0, aT),
                Visible = b6.open
            }, bd.visibleContent)
            h:LoadImage(cn, "gradient", "https://i.imgur.com/5hmlrjX.png")
            function keybind:Shorten(string)
                for F, G in pairs(cm) do
                    string = string.gsub(string, F, G)
                end
                return string
            end
            function keybind:Change(co)
                co = co or "..."
                local cp = {}
                if co.EnumType then
                    if co.EnumType == Enum.KeyCode or co.EnumType == Enum.UserInputType then
                        if table.find(ck, co.Name) or table.find(cl, co.Name) then
                            cp = {co.EnumType == Enum.KeyCode and "KeyCode" or "UserInputType", co.Name}
                            keybind.current = cp;
                            aX.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."
                            return true
                        end
                    end
                end
                return false
            end
            function keybind:Get()
                return keybind.current
            end
            function keybind:Set(cq)
                keybind.current = cq;
                aX.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."
            end
            function keybind:Active()
                return keybind.active
            end
            function keybind:Reset()
                for F, G in pairs(keybind.modemenu.buttons) do
                    G.Color = G.Text == keybind.mode and k.accent or k.textcolor
                end
                keybind.active = keybind.mode == "Always" and true or false;
                if keybind.current[1] and keybind.current[2] then
                    bD(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                end
            end
            keybind:Change(bC)
            g.began[#g.began + 1] = function(b0)
                if keybind.current[1] and keybind.current[2] then
                    if b0.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or b0.UserInputType ==
                        Enum[keybind.current[1]][keybind.current[2]] then
                        if keybind.mode == "Hold" then
                            local cr = keybind.active;
                            keybind.active = bE:Get()
                            if keybind.active then
                                ae.keybindslist:Add(aQ or ab, aX.Text)
                            else
                                ae.keybindslist:Remove(aQ or ab)
                            end
                            if keybind.active ~= cr then
                                bD(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                            end
                        elseif keybind.mode == "Toggle" then
                            local cr = keybind.active;
                            keybind.active = not keybind.active == true and bE:Get() or false;
                            if keybind.active then
                                ae.keybindslist:Add(aQ or ab, aX.Text)
                            else
                                ae.keybindslist:Remove(aQ or ab)
                            end
                            if keybind.active ~= cr then
                                bD(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                            end
                        end
                    end
                end
                if keybind.selecting and ae.isVisible then
                    local cs = keybind:Change(b0.KeyCode.Name ~= "Unknown" and b0.KeyCode or b0.UserInputType)
                    if cs then
                        keybind.selecting = false;
                        keybind.active = keybind.mode == "Always" and true or false;
                        aV.Color = k.light_contrast;
                        ae.keybindslist:Remove(aQ or ab)
                        bD(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    end
                end
                if not ae.isVisible and keybind.selecting then
                    keybind.selecting = false;
                    aV.Color = k.light_contrast
                end
                if b0.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and aT.Visible then
                    if h:MouseOverDrawing({bd.section_frame.Position.X + bd.section_frame.Size.X - (40 + 4 + 2),
                                           bd.section_frame.Position.Y + keybind.axis,
                                           bd.section_frame.Position.X + bd.section_frame.Size.X,
                                           bd.section_frame.Position.Y + keybind.axis + 17}) and not ae:IsOverContent() and
                        not keybind.selecting then
                        keybind.selecting = true;
                        aV.Color = k.dark_contrast
                    end
                    if keybind.open and keybind.modemenu.frame then
                        if h:MouseOverDrawing({keybind.modemenu.frame.Position.X, keybind.modemenu.frame.Position.Y,
                                               keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X,
                                               keybind.modemenu.frame.Position.Y + keybind.modemenu.frame.Size.Y}) then
                            local ct = false;
                            for F, G in pairs(keybind.modemenu.buttons) do
                                if h:MouseOverDrawing({keybind.modemenu.frame.Position.X,
                                                       keybind.modemenu.frame.Position.Y + 15 * (F - 1),
                                                       keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X,
                                                       keybind.modemenu.frame.Position.Y + 15 * (F - 1) + 15}) then
                                    keybind.mode = G.Text;
                                    ct = true
                                end
                            end
                            if ct then
                                keybind:Reset()
                            end
                        else
                            keybind.open = not keybind.open;
                            for F, G in pairs(keybind.modemenu.drawings) do
                                h:Remove(G)
                            end
                            keybind.modemenu.drawings = {}
                            keybind.modemenu.buttons = {}
                            keybind.modemenu.frame = nil;
                            ae.currentContent.frame = nil;
                            ae.currentContent.keybind = nil
                        end
                    end
                end
                if b0.UserInputType == Enum.UserInputType.MouseButton2 and ae.isVisible and aT.Visible then
                    if h:MouseOverDrawing({bd.section_frame.Position.X + bd.section_frame.Size.X - (40 + 4 + 2),
                                           bd.section_frame.Position.Y + keybind.axis,
                                           bd.section_frame.Position.X + bd.section_frame.Size.X,
                                           bd.section_frame.Position.Y + keybind.axis + 17}) and not ae:IsOverContent() and
                        not keybind.selecting then
                        ae:CloseContent()
                        keybind.open = not keybind.open;
                        local ay = h:Create("Frame", {Vector2.new(aT.Size.X + 2, 0), aT}, {
                            Size = h:Size(0, 64, 0, 49),
                            Position = h:Position(1, 2, 0, 0, aT),
                            Color = k.outline,
                            Visible = b6.open
                        }, keybind.modemenu.drawings)
                        keybind.modemenu.frame = ay;
                        local cu = h:Create("Frame", {Vector2.new(1, 1), ay}, {
                            Size = h:Size(1, -2, 1, -2, ay),
                            Position = h:Position(0, 1, 0, 1, ay),
                            Color = k.inline,
                            Visible = b6.open
                        }, keybind.modemenu.drawings)
                        local cv = h:Create("Frame", {Vector2.new(1, 1), cu}, {
                            Size = h:Size(1, -2, 1, -2, cu),
                            Position = h:Position(0, 1, 0, 1, cu),
                            Color = k.light_contrast,
                            Visible = b6.open
                        }, keybind.modemenu.drawings)
                        local cn = h:Create("Image", {Vector2.new(0, 0), cv}, {
                            Size = h:Size(1, 0, 1, 0, cv),
                            Position = h:Position(0, 0, 0, 0, cv),
                            Transparency = 0.5,
                            Visible = b6.open
                        }, keybind.modemenu.drawings)
                        h:LoadImage(cn, "gradient", "https://i.imgur.com/5hmlrjX.png")
                        for F, G in pairs({"Always", "Toggle", "Hold"}) do
                            local cw = h:Create("TextLabel", {Vector2.new(cv.Size.X / 2, 15 * (F - 1)), cv}, {
                                Text = G,
                                Size = k.textsize,
                                Font = k.font,
                                Color = G == keybind.mode and k.accent or k.textcolor,
                                Center = true,
                                OutlineColor = k.textborder,
                                Position = h:Position(0.5, 0, 0, 15 * (F - 1), cv),
                                Visible = b6.open
                            }, keybind.modemenu.drawings)
                            keybind.modemenu.buttons[#keybind.modemenu.buttons + 1] = cw
                        end
                        ae.currentContent.frame = ay;
                        ae.currentContent.keybind = keybind
                    end
                end
            end;
            g.ended[#g.ended + 1] = function(b0)
                if keybind.active and keybind.mode == "Hold" then
                    if keybind.current[1] and keybind.current[2] then
                        if b0.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or b0.UserInputType ==
                            Enum[keybind.current[1]][keybind.current[2]] then
                            keybind.active = false;
                            ae.keybindslist:Remove(aQ or ab)
                            bD(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                        end
                    end
                end
            end;
            if by and tostring(by) ~= "" and tostring(by) ~= " " and not g.pointers[tostring(by)] then
                g.pointers[tostring(by)] = keybind
            end
            bE.addedAxis = 40 + 4 + 2;
            bd:Update()
            return keybind
        end
        return bE
    end
    function j:Slider(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Slider"
        local bC = aa.def or aa.Def or aa.default or aa.Default or 10;
        local cx = aa.min or aa.Min or aa.minimum or aa.Minimum or 0;
        local cy = aa.max or aa.Max or aa.maximum or aa.Maximum or 100;
        local cz = aa.suffix or aa.Suffix or aa.ending or aa.Ending or aa.prefix or aa.Prefix or aa.measurement or
                       aa.Measurement or ""
        local cA = aa.decimals or aa.Decimals or 1;
        cA = 1 / cA;
        local by = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local bD = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        bC = math.clamp(bC, cx, cy)
        local ae = self.window;
        local b6 = self.page;
        local bd = self;
        local cB = {
            min = cx,
            max = cy,
            sub = cz,
            decimals = cA,
            axis = bd.currentAxis,
            current = bC,
            holding = false
        }
        local cC = h:Create("TextLabel", {Vector2.new(4, cB.axis), bd.section_frame}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 4, 0, cB.axis, bd.section_frame),
            Visible = b6.open
        }, bd.visibleContent)
        local cD = h:Create("Frame", {Vector2.new(4, cB.axis + 15), bd.section_frame}, {
            Size = h:Size(1, -8, 0, 12, bd.section_frame),
            Position = h:Position(0, 4, 0, cB.axis + 15, bd.section_frame),
            Color = k.outline,
            Visible = b6.open
        }, bd.visibleContent)
        local cE = h:Create("Frame", {Vector2.new(1, 1), cD}, {
            Size = h:Size(1, -2, 1, -2, cD),
            Position = h:Position(0, 1, 0, 1, cD),
            Color = k.inline,
            Visible = b6.open
        }, bd.visibleContent)
        local cF = h:Create("Frame", {Vector2.new(1, 1), cE}, {
            Size = h:Size(1, -2, 1, -2, cE),
            Position = h:Position(0, 1, 0, 1, cE),
            Color = k.light_contrast,
            Visible = b6.open
        }, bd.visibleContent)
        local cG = h:Create("Frame", {Vector2.new(1, 1), cE}, {
            Size = h:Size(0, cF.Size.X / (cB.max - cB.min) * (cB.current - cB.min), 1, -2, cE),
            Position = h:Position(0, 1, 0, 1, cE),
            Color = k.accent,
            Visible = b6.open
        }, bd.visibleContent)
        local cH = h:Create("Image", {Vector2.new(0, 0), cF}, {
            Size = h:Size(1, 0, 1, 0, cF),
            Position = h:Position(0, 0, 0, 0, cF),
            Transparency = 0.5,
            Visible = b6.open
        }, bd.visibleContent)
        local bs = h:GetTextBounds(ab, k.textsize, k.font)
        local cI = h:Create("TextLabel", {Vector2.new(cD.Size.X / 2, cD.Size.Y / 2 - bs.Y / 2), cD}, {
            Text = cB.current .. cB.sub .. "/" .. cB.max .. cB.sub,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            Center = true,
            OutlineColor = k.textborder,
            Position = h:Position(0.5, 0, 0, cD.Size.Y / 2 - bs.Y / 2, cD),
            Visible = b6.open
        }, bd.visibleContent)
        h:LoadImage(cH, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function cB:Set(cJ)
            cB.current = math.clamp(math.round(cJ * cB.decimals) / cB.decimals, cB.min, cB.max)
            local cK = 1 - (cB.max - cB.current) / (cB.max - cB.min)
            cI.Text = cB.current .. cB.sub .. "/" .. cB.max .. cB.sub;
            cG.Size = h:Size(0, cK * cF.Size.X, 1, -2, cE)
            bD(cB.current)
        end
        function cB:Refresh()
            local S = h:MouseLocation()
            local cK = math.clamp(S.X - cG.Position.X, 0, cF.Size.X) / cF.Size.X;
            local cJ = math.floor((cB.min + (cB.max - cB.min) * cK) * cB.decimals) / cB.decimals;
            cJ = math.clamp(cJ, cB.min, cB.max)
            cB:Set(cJ)
        end
        function cB:Get()
            return cB.current
        end
        cB:Set(cB.current)
        g.began[#g.began + 1] = function(b0)
            if b0.UserInputType == Enum.UserInputType.MouseButton1 and cD.Visible and ae.isVisible and b6.open and
                h:MouseOverDrawing({bd.section_frame.Position.X, bd.section_frame.Position.Y + cB.axis,
                                    bd.section_frame.Position.X + bd.section_frame.Size.X,
                                    bd.section_frame.Position.Y + cB.axis + 27}) and not ae:IsOverContent() then
                cB.holding = true;
                cB:Refresh()
            end
        end;
        g.ended[#g.ended + 1] = function(b0)
            if b0.UserInputType == Enum.UserInputType.MouseButton1 and cB.holding and ae.isVisible then
                cB.holding = false
            end
        end;
        g.changed[#g.changed + 1] = function(b0)
            if cB.holding and ae.isVisible then
                cB:Refresh()
            end
        end;
        if by and tostring(by) ~= "" and tostring(by) ~= " " and not g.pointers[tostring(by)] then
            g.pointers[tostring(by)] = cB
        end
        bd.currentAxis = bd.currentAxis + 27 + 4;
        bd:Update()
        return cB
    end
    function j:Button(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Button"
        local by = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local bD = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        local ae = self.window;
        local b6 = self.page;
        local bd = self;
        local cL = {
            axis = bd.currentAxis
        }
        local cM = h:Create("Frame", {Vector2.new(4, cL.axis), bd.section_frame}, {
            Size = h:Size(1, -8, 0, 20, bd.section_frame),
            Position = h:Position(0, 4, 0, cL.axis, bd.section_frame),
            Color = k.outline,
            Visible = b6.open
        }, bd.visibleContent)
        local cN = h:Create("Frame", {Vector2.new(1, 1), cM}, {
            Size = h:Size(1, -2, 1, -2, cM),
            Position = h:Position(0, 1, 0, 1, cM),
            Color = k.inline,
            Visible = b6.open
        }, bd.visibleContent)
        local cO = h:Create("Frame", {Vector2.new(1, 1), cN}, {
            Size = h:Size(1, -2, 1, -2, cN),
            Position = h:Position(0, 1, 0, 1, cN),
            Color = k.light_contrast,
            Visible = b6.open
        }, bd.visibleContent)
        local cP = h:Create("Image", {Vector2.new(0, 0), cO}, {
            Size = h:Size(1, 0, 1, 0, cO),
            Position = h:Position(0, 0, 0, 0, cO),
            Transparency = 0.5,
            Visible = b6.open
        }, bd.visibleContent)
        local cw = h:Create("TextLabel", {Vector2.new(cO.Size.X / 2, 1), cO}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Center = true,
            Position = h:Position(0.5, 0, 0, 1, cO),
            Visible = b6.open
        }, bd.visibleContent)
        h:LoadImage(cP, "gradient", "https://i.imgur.com/5hmlrjX.png")
        g.began[#g.began + 1] = function(b0)
            if b0.UserInputType == Enum.UserInputType.MouseButton1 and cM.Visible and ae.isVisible and
                h:MouseOverDrawing({bd.section_frame.Position.X, bd.section_frame.Position.Y + cL.axis,
                                    bd.section_frame.Position.X + bd.section_frame.Size.X,
                                    bd.section_frame.Position.Y + cL.axis + 20}) and not ae:IsOverContent() then
                bD()
            end
        end;
        if by and tostring(by) ~= "" and tostring(by) ~= " " and not g.pointers[tostring(by)] then
            g.pointers[tostring(by)] = cL
        end
        bd.currentAxis = bd.currentAxis + 20 + 4;
        bd:Update()
        return cL
    end
    function j:ButtonHolder(aa)
        local aa = aa or {}
        local cQ = aa.buttons or aa.Buttons or {}
        local ae = self.window;
        local b6 = self.page;
        local bd = self;
        local cR = {
            buttons = {}
        }
        for F = 1, 2 do
            local cL = {
                axis = bd.currentAxis
            }
            local cM = h:Create("Frame", {Vector2.new(F == 2 and bd.section_frame.Size.X / 2 + 2 or 4, cL.axis),
                                          bd.section_frame}, {
                Size = h:Size(0.5, -6, 0, 20, bd.section_frame),
                Position = h:Position(0, F == 2 and 2 or 4, 0, cL.axis, bd.section_frame),
                Color = k.outline,
                Visible = b6.open
            }, bd.visibleContent)
            local cN = h:Create("Frame", {Vector2.new(1, 1), cM}, {
                Size = h:Size(1, -2, 1, -2, cM),
                Position = h:Position(0, 1, 0, 1, cM),
                Color = k.inline,
                Visible = b6.open
            }, bd.visibleContent)
            local cO = h:Create("Frame", {Vector2.new(1, 1), cN}, {
                Size = h:Size(1, -2, 1, -2, cN),
                Position = h:Position(0, 1, 0, 1, cN),
                Color = k.light_contrast,
                Visible = b6.open
            }, bd.visibleContent)
            local cP = h:Create("Image", {Vector2.new(0, 0), cO}, {
                Size = h:Size(1, 0, 1, 0, cO),
                Position = h:Position(0, 0, 0, 0, cO),
                Transparency = 0.5,
                Visible = b6.open
            }, bd.visibleContent)
            local cw = h:Create("TextLabel", {Vector2.new(cO.Size.X / 2, 1), cO}, {
                Text = cQ[F][1],
                Size = k.textsize,
                Font = k.font,
                Color = k.textcolor,
                OutlineColor = k.textborder,
                Center = true,
                Position = h:Position(0.5, 0, 0, 1, cO),
                Visible = b6.open
            }, bd.visibleContent)
            h:LoadImage(cP, "gradient", "https://i.imgur.com/5hmlrjX.png")
            g.began[#g.began + 1] = function(b0)
                if b0.UserInputType == Enum.UserInputType.MouseButton1 and cM.Visible and ae.isVisible and
                    h:MouseOverDrawing({bd.section_frame.Position.X + (F == 2 and bd.section_frame.Size.X / 2 or 0),
                                        bd.section_frame.Position.Y + cL.axis,
                                        bd.section_frame.Position.X + bd.section_frame.Size.X -
                        (F == 1 and bd.section_frame.Size.X / 2 or 0), bd.section_frame.Position.Y + cL.axis + 20}) and
                    not ae:IsOverContent() then
                    cQ[F][2]()
                end
            end
        end
        bd.currentAxis = bd.currentAxis + 20 + 4;
        bd:Update()
    end
    function j:Dropdown(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Dropdown"
        local cS = aa.options or aa.Options or {"1", "2", "3"}
        local bC = aa.def or aa.Def or aa.default or aa.Default or cS[1]
        local by = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local bD = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        local ae = self.window;
        local b6 = self.page;
        local bd = self;
        local av = {
            open = false,
            current = tostring(bC),
            holder = {
                buttons = {},
                drawings = {}
            },
            axis = bd.currentAxis
        }
        local cT = h:Create("Frame", {Vector2.new(4, av.axis + 15), bd.section_frame}, {
            Size = h:Size(1, -8, 0, 20, bd.section_frame),
            Position = h:Position(0, 4, 0, av.axis + 15, bd.section_frame),
            Color = k.outline,
            Visible = b6.open
        }, bd.visibleContent)
        local cU = h:Create("Frame", {Vector2.new(1, 1), cT}, {
            Size = h:Size(1, -2, 1, -2, cT),
            Position = h:Position(0, 1, 0, 1, cT),
            Color = k.inline,
            Visible = b6.open
        }, bd.visibleContent)
        local cV = h:Create("Frame", {Vector2.new(1, 1), cU}, {
            Size = h:Size(1, -2, 1, -2, cU),
            Position = h:Position(0, 1, 0, 1, cU),
            Color = k.light_contrast,
            Visible = b6.open
        }, bd.visibleContent)
        local cW = h:Create("TextLabel", {Vector2.new(4, av.axis), bd.section_frame}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 4, 0, av.axis, bd.section_frame),
            Visible = b6.open
        }, bd.visibleContent)
        local cX = h:Create("Image", {Vector2.new(0, 0), cV}, {
            Size = h:Size(1, 0, 1, 0, cV),
            Position = h:Position(0, 0, 0, 0, cV),
            Transparency = 0.5,
            Visible = b6.open
        }, bd.visibleContent)
        local cY = h:Create("TextLabel", {Vector2.new(3, cV.Size.Y / 2 - 7), cV}, {
            Text = av.current,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 3, 0, cV.Size.Y / 2 - 7, cV),
            Visible = b6.open
        }, bd.visibleContent)
        local cZ = h:Create("Image", {Vector2.new(cV.Size.X - 15, cV.Size.Y / 2 - 3), cV}, {
            Size = h:Size(0, 9, 0, 6, cV),
            Position = h:Position(1, -15, 0.5, -3, cV),
            Visible = b6.open
        }, bd.visibleContent)
        av["dropdown_image"] = cZ;
        h:LoadImage(cZ, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
        h:LoadImage(cX, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function av:Update()
            if av.open and av.holder.inline then
                for F, G in pairs(av.holder.buttons) do
                    G[1].Color = G[1].Text == tostring(av.current) and k.accent or k.textcolor;
                    G[1].Position = h:Position(0, G[1].Text == tostring(av.current) and 8 or 6, 0, 2, G[2])
                    h:UpdateOffset(G[1], {Vector2.new(G[1].Text == tostring(av.current) and 8 or 6, 2), G[2]})
                end
            end
        end
        function av:Set(cJ)
            if typeof(cJ) == "string" and table.find(cS, cJ) then
                av.current = cJ;
                cY.Text = cJ
            end
        end
        function av:Get()
            return av.current
        end
        g.began[#g.began + 1] = function(b0)
            if b0.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and cT.Visible then
                if av.open and av.holder.inline and
                    h:MouseOverDrawing({av.holder.inline.Position.X, av.holder.inline.Position.Y,
                                        av.holder.inline.Position.X + av.holder.inline.Size.X,
                                        av.holder.inline.Position.Y + av.holder.inline.Size.Y}) then
                    for F, G in pairs(av.holder.buttons) do
                        if h:MouseOverDrawing({G[2].Position.X, G[2].Position.Y, G[2].Position.X + G[2].Size.X,
                                               G[2].Position.Y + G[2].Size.Y}) and G[1].Text ~= av.current then
                            av.current = G[1].Text;
                            cY.Text = av.current;
                            av:Update()
                        end
                    end
                elseif h:MouseOverDrawing({bd.section_frame.Position.X, bd.section_frame.Position.Y + av.axis,
                                           bd.section_frame.Position.X + bd.section_frame.Size.X,
                                           bd.section_frame.Position.Y + av.axis + 15 + 20}) and not ae:IsOverContent() then
                    if not av.open then
                        ae:CloseContent()
                        av.open = not av.open;
                        h:LoadImage(cZ, "arrow_up", "https://i.imgur.com/SL9cbQp.png")
                        local c_ = h:Create("Frame", {Vector2.new(0, 19), cT}, {
                            Size = h:Size(1, 0, 0, 3 + #cS * 19, cT),
                            Position = h:Position(0, 0, 0, 19, cT),
                            Color = k.outline,
                            Visible = b6.open
                        }, av.holder.drawings)
                        av.holder.outline = c_;
                        local d0 = h:Create("Frame", {Vector2.new(1, 1), c_}, {
                            Size = h:Size(1, -2, 1, -2, c_),
                            Position = h:Position(0, 1, 0, 1, c_),
                            Color = k.inline,
                            Visible = b6.open
                        }, av.holder.drawings)
                        av.holder.inline = d0;
                        for F, G in pairs(cS) do
                            local d1 = h:Create("Frame", {Vector2.new(1, 1 + 19 * (F - 1)), d0}, {
                                Size = h:Size(1, -2, 0, 18, d0),
                                Position = h:Position(0, 1, 0, 1 + 19 * (F - 1), d0),
                                Color = k.light_contrast,
                                Visible = b6.open
                            }, av.holder.drawings)
                            local cY = h:Create("TextLabel", {Vector2.new(G == tostring(av.current) and 8 or 6, 2), d1},
                                {
                                    Text = G,
                                    Size = k.textsize,
                                    Font = k.font,
                                    Color = G == tostring(av.current) and k.accent or k.textcolor,
                                    OutlineColor = k.textborder,
                                    Position = h:Position(0, G == tostring(av.current) and 8 or 6, 0, 2, d1),
                                    Visible = b6.open
                                }, av.holder.drawings)
                            av.holder.buttons[#av.holder.buttons + 1] = {cY, d1}
                        end
                        ae.currentContent.frame = d0;
                        ae.currentContent.dropdown = av
                    else
                        av.open = not av.open;
                        h:LoadImage(cZ, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        for F, G in pairs(av.holder.drawings) do
                            h:Remove(G)
                        end
                        av.holder.drawings = {}
                        av.holder.buttons = {}
                        av.holder.inline = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.dropdown = nil
                    end
                else
                    if av.open then
                        av.open = not av.open;
                        h:LoadImage(cZ, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        for F, G in pairs(av.holder.drawings) do
                            h:Remove(G)
                        end
                        av.holder.drawings = {}
                        av.holder.buttons = {}
                        av.holder.inline = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.dropdown = nil
                    end
                end
            elseif b0.UserInputType == Enum.UserInputType.MouseButton1 and av.open then
                av.open = not av.open;
                h:LoadImage(cZ, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                for F, G in pairs(av.holder.drawings) do
                    h:Remove(G)
                end
                av.holder.drawings = {}
                av.holder.buttons = {}
                av.holder.inline = nil;
                ae.currentContent.frame = nil;
                ae.currentContent.dropdown = nil
            end
        end;
        if by and tostring(by) ~= "" and tostring(by) ~= " " and not g.pointers[tostring(by)] then
            g.pointers[tostring(by)] = av
        end
        bd.currentAxis = bd.currentAxis + 35 + 4;
        bd:Update()
        return av
    end
    function j:Multibox(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Multibox"
        local cS = aa.options or aa.Options or {"1", "2", "3"}
        local bC = aa.def or aa.Def or aa.default or aa.Default or {cS[1]}
        local by = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local bD = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        local cx = aa.min or aa.Min or aa.minimum or aa.Minimum or 0;
        local ae = self.window;
        local b6 = self.page;
        local bd = self;
        local aw = {
            open = false,
            current = bC,
            holder = {
                buttons = {},
                drawings = {}
            },
            axis = bd.currentAxis
        }
        local d2 = h:Create("Frame", {Vector2.new(4, aw.axis + 15), bd.section_frame}, {
            Size = h:Size(1, -8, 0, 20, bd.section_frame),
            Position = h:Position(0, 4, 0, aw.axis + 15, bd.section_frame),
            Color = k.outline,
            Visible = b6.open
        }, bd.visibleContent)
        local d3 = h:Create("Frame", {Vector2.new(1, 1), d2}, {
            Size = h:Size(1, -2, 1, -2, d2),
            Position = h:Position(0, 1, 0, 1, d2),
            Color = k.inline,
            Visible = b6.open
        }, bd.visibleContent)
        local d4 = h:Create("Frame", {Vector2.new(1, 1), d3}, {
            Size = h:Size(1, -2, 1, -2, d3),
            Position = h:Position(0, 1, 0, 1, d3),
            Color = k.light_contrast,
            Visible = b6.open
        }, bd.visibleContent)
        local d5 = h:Create("TextLabel", {Vector2.new(4, aw.axis), bd.section_frame}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 4, 0, aw.axis, bd.section_frame),
            Visible = b6.open
        }, bd.visibleContent)
        local d6 = h:Create("Image", {Vector2.new(0, 0), d4}, {
            Size = h:Size(1, 0, 1, 0, d4),
            Position = h:Position(0, 0, 0, 0, d4),
            Transparency = 0.5,
            Visible = b6.open
        }, bd.visibleContent)
        local d7 = h:Create("TextLabel", {Vector2.new(3, d4.Size.Y / 2 - 7), d4}, {
            Text = "",
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 3, 0, d4.Size.Y / 2 - 7, d4),
            Visible = b6.open
        }, bd.visibleContent)
        local d8 = h:Create("Image", {Vector2.new(d4.Size.X - 15, d4.Size.Y / 2 - 3), d4}, {
            Size = h:Size(0, 9, 0, 6, d4),
            Position = h:Position(1, -15, 0.5, -3, d4),
            Visible = b6.open
        }, bd.visibleContent)
        aw["multibox_image"] = d8;
        h:LoadImage(d8, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
        h:LoadImage(d6, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function aw:Update()
            if aw.open and aw.holder.inline then
                for F, G in pairs(aw.holder.buttons) do
                    G[1].Color = table.find(aw.current, G[1].Text) and k.accent or k.textcolor;
                    G[1].Position = h:Position(0, table.find(aw.current, G[1].Text) and 8 or 6, 0, 2, G[2])
                    h:UpdateOffset(G[1], {Vector2.new(table.find(aw.current, G[1].Text) and 8 or 6, 2), G[2]})
                end
            end
        end
        function aw:Serialize(cq)
            local K = ""
            for F, G in pairs(cq) do
                K = K .. G .. ", "
            end
            return string.sub(K, 0, #K - 2)
        end
        function aw:Resort(cq, d9)
            local da = {}
            for F, G in pairs(d9) do
                if table.find(cq, G) then
                    da[#da + 1] = G
                end
            end
            return da
        end
        function aw:Set(cq)
            if typeof(cq) == "table" then
                aw.current = cq;
                d7.Text = aw:Serialize(aw:Resort(aw.current, cS))
            end
        end
        function aw:Get()
            return aw.current
        end
        d7.Text = aw:Serialize(aw:Resort(aw.current, cS))
        g.began[#g.began + 1] = function(b0)
            if b0.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and d2.Visible then
                if aw.open and aw.holder.inline and
                    h:MouseOverDrawing({aw.holder.inline.Position.X, aw.holder.inline.Position.Y,
                                        aw.holder.inline.Position.X + aw.holder.inline.Size.X,
                                        aw.holder.inline.Position.Y + aw.holder.inline.Size.Y}) then
                    for F, G in pairs(aw.holder.buttons) do
                        if h:MouseOverDrawing({G[2].Position.X, G[2].Position.Y, G[2].Position.X + G[2].Size.X,
                                               G[2].Position.Y + G[2].Size.Y}) and G[1].Text ~= aw.current then
                            if not table.find(aw.current, G[1].Text) then
                                aw.current[#aw.current + 1] = G[1].Text;
                                d7.Text = aw:Serialize(aw:Resort(aw.current, cS))
                                aw:Update()
                            else
                                if #aw.current > cx then
                                    table.remove(aw.current, table.find(aw.current, G[1].Text))
                                    d7.Text = aw:Serialize(aw:Resort(aw.current, cS))
                                    aw:Update()
                                end
                            end
                        end
                    end
                elseif h:MouseOverDrawing({bd.section_frame.Position.X, bd.section_frame.Position.Y + aw.axis,
                                           bd.section_frame.Position.X + bd.section_frame.Size.X,
                                           bd.section_frame.Position.Y + aw.axis + 15 + 20}) and not ae:IsOverContent() then
                    if not aw.open then
                        ae:CloseContent()
                        aw.open = not aw.open;
                        h:LoadImage(d8, "arrow_up", "https://i.imgur.com/SL9cbQp.png")
                        local db = h:Create("Frame", {Vector2.new(0, 19), d2}, {
                            Size = h:Size(1, 0, 0, 3 + #cS * 19, d2),
                            Position = h:Position(0, 0, 0, 19, d2),
                            Color = k.outline,
                            Visible = b6.open
                        }, aw.holder.drawings)
                        aw.holder.outline = db;
                        local dc = h:Create("Frame", {Vector2.new(1, 1), db}, {
                            Size = h:Size(1, -2, 1, -2, db),
                            Position = h:Position(0, 1, 0, 1, db),
                            Color = k.inline,
                            Visible = b6.open
                        }, aw.holder.drawings)
                        aw.holder.inline = dc;
                        for F, G in pairs(cS) do
                            local dd = h:Create("Frame", {Vector2.new(1, 1 + 19 * (F - 1)), dc}, {
                                Size = h:Size(1, -2, 0, 18, dc),
                                Position = h:Position(0, 1, 0, 1 + 19 * (F - 1), dc),
                                Color = k.light_contrast,
                                Visible = b6.open
                            }, aw.holder.drawings)
                            local d7 = h:Create("TextLabel", {Vector2.new(table.find(aw.current, G) and 8 or 6, 2), dd},
                                {
                                    Text = G,
                                    Size = k.textsize,
                                    Font = k.font,
                                    Color = table.find(aw.current, G) and k.accent or k.textcolor,
                                    OutlineColor = k.textborder,
                                    Position = h:Position(0, table.find(aw.current, G) and 8 or 6, 0, 2, dd),
                                    Visible = b6.open
                                }, aw.holder.drawings)
                            aw.holder.buttons[#aw.holder.buttons + 1] = {d7, dd}
                        end
                        ae.currentContent.frame = dc;
                        ae.currentContent.multibox = aw
                    else
                        aw.open = not aw.open;
                        h:LoadImage(d8, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        for F, G in pairs(aw.holder.drawings) do
                            h:Remove(G)
                        end
                        aw.holder.drawings = {}
                        aw.holder.buttons = {}
                        aw.holder.inline = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.multibox = nil
                    end
                else
                    if aw.open then
                        aw.open = not aw.open;
                        h:LoadImage(d8, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        for F, G in pairs(aw.holder.drawings) do
                            h:Remove(G)
                        end
                        aw.holder.drawings = {}
                        aw.holder.buttons = {}
                        aw.holder.inline = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.multibox = nil
                    end
                end
            elseif b0.UserInputType == Enum.UserInputType.MouseButton1 and aw.open then
                aw.open = not aw.open;
                h:LoadImage(d8, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                for F, G in pairs(aw.holder.drawings) do
                    h:Remove(G)
                end
                aw.holder.drawings = {}
                aw.holder.buttons = {}
                aw.holder.inline = nil;
                ae.currentContent.frame = nil;
                ae.currentContent.multibox = nil
            end
        end;
        if by and tostring(by) ~= "" and tostring(by) ~= " " and not g.pointers[tostring(by)] then
            g.pointers[tostring(by)] = aw
        end
        bd.currentAxis = bd.currentAxis + 35 + 4;
        bd:Update()
        return aw
    end
    function j:Keybind(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Keybind"
        local bC = aa.def or aa.Def or aa.default or aa.Default or nil;
        local by = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local cj = aa.mode or aa.Mode or "Always"
        local aQ = aa.keybindname or aa.keybindName or aa.Keybindname or aa.KeybindName or nil;
        local bD = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        local ae = self.window;
        local b6 = self.page;
        local bd = self;
        local keybind = {
            keybindname = aQ or ab,
            axis = bd.currentAxis,
            current = {},
            selecting = false,
            mode = cj,
            open = false,
            modemenu = {
                buttons = {},
                drawings = {}
            },
            active = false
        }
        local ck = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z",
                    "X", "C", "V", "B", "N", "M", "One", "Two", "Three", "Four", "Five", "Six", "Seveen", "Eight",
                    "Nine", "0", "Insert", "Tab", "Home", "End", "LeftAlt", "LeftControl", "LeftShift", "RightAlt",
                    "RightControl", "RightShift", "CapsLock"}
        local cl = {"MouseButton1", "MouseButton2", "MouseButton3"}
        local cm = {
            ["MouseButton1"] = "MB1",
            ["MouseButton2"] = "MB2",
            ["MouseButton3"] = "MB3",
            ["Insert"] = "Ins",
            ["LeftAlt"] = "LAlt",
            ["LeftControl"] = "LC",
            ["LeftShift"] = "LS",
            ["RightAlt"] = "RAlt",
            ["RightControl"] = "RC",
            ["RightShift"] = "RS",
            ["CapsLock"] = "Caps"
        }
        local aT = h:Create("Frame", {Vector2.new(bd.section_frame.Size.X - (40 + 4), keybind.axis), bd.section_frame},
            {
                Size = h:Size(0, 40, 0, 17),
                Position = h:Position(1, -(40 + 4), 0, keybind.axis, bd.section_frame),
                Color = k.outline,
                Visible = b6.open
            }, bd.visibleContent)
        local aU = h:Create("Frame", {Vector2.new(1, 1), aT}, {
            Size = h:Size(1, -2, 1, -2, aT),
            Position = h:Position(0, 1, 0, 1, aT),
            Color = k.inline,
            Visible = b6.open
        }, bd.visibleContent)
        local aV = h:Create("Frame", {Vector2.new(1, 1), aU}, {
            Size = h:Size(1, -2, 1, -2, aU),
            Position = h:Position(0, 1, 0, 1, aU),
            Color = k.light_contrast,
            Visible = b6.open
        }, bd.visibleContent)
        local aW = h:Create("TextLabel", {Vector2.new(4, keybind.axis + 17 / 2 -
            h:GetTextBounds(ab, k.textsize, k.font).Y / 2), bd.section_frame}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 4, 0, keybind.axis + 17 / 2 - h:GetTextBounds(ab, k.textsize, k.font).Y / 2,
                bd.section_frame),
            Visible = b6.open
        }, bd.visibleContent)
        local cn = h:Create("Image", {Vector2.new(0, 0), aV}, {
            Size = h:Size(1, 0, 1, 0, aV),
            Position = h:Position(0, 0, 0, 0, aV),
            Transparency = 0.5,
            Visible = b6.open
        }, bd.visibleContent)
        local aX = h:Create("TextLabel", {Vector2.new(aT.Size.X / 2, 1), aT}, {
            Text = "...",
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Center = true,
            Position = h:Position(0.5, 0, 1, 0, aT),
            Visible = b6.open
        }, bd.visibleContent)
        h:LoadImage(cn, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function keybind:Shorten(string)
            for F, G in pairs(cm) do
                string = string.gsub(string, F, G)
            end
            return string
        end
        function keybind:Change(co)
            co = co or "..."
            local cp = {}
            if co.EnumType then
                if co.EnumType == Enum.KeyCode or co.EnumType == Enum.UserInputType then
                    if table.find(ck, co.Name) or table.find(cl, co.Name) then
                        cp = {co.EnumType == Enum.KeyCode and "KeyCode" or "UserInputType", co.Name}
                        keybind.current = cp;
                        aX.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."
                        return true
                    end
                end
            end
            return false
        end
        function keybind:Get()
            return keybind.current
        end
        function keybind:Active()
            return keybind.active
        end
        function keybind:Reset()
            for F, G in pairs(keybind.modemenu.buttons) do
                G.Color = G.Text == keybind.mode and k.accent or k.textcolor
            end
            keybind.active = keybind.mode == "Always" and true or false;
            if keybind.current[1] and keybind.current[2] then
                bD(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
            end
        end
        keybind:Change(bC)
        g.began[#g.began + 1] = function(b0)
            if keybind.current[1] and keybind.current[2] then
                if b0.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or b0.UserInputType ==
                    Enum[keybind.current[1]][keybind.current[2]] then
                    if keybind.mode == "Hold" then
                        keybind.active = true;
                        if keybind.active then
                            ae.keybindslist:Add(aQ or ab, aX.Text)
                        else
                            ae.keybindslist:Remove(aQ or ab)
                        end
                        bD(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    elseif keybind.mode == "Toggle" then
                        keybind.active = not keybind.active;
                        if keybind.active then
                            ae.keybindslist:Add(aQ or ab, aX.Text)
                        else
                            ae.keybindslist:Remove(aQ or ab)
                        end
                        bD(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    end
                end
            end
            if keybind.selecting and ae.isVisible then
                local cs = keybind:Change(b0.KeyCode.Name ~= "Unknown" and b0.KeyCode or b0.UserInputType)
                if cs then
                    keybind.selecting = false;
                    keybind.active = keybind.mode == "Always" and true or false;
                    aV.Color = k.light_contrast;
                    ae.keybindslist:Remove(aQ or ab)
                    bD(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                end
            end
            if not ae.isVisible and keybind.selecting then
                keybind.selecting = false;
                aV.Color = k.light_contrast
            end
            if b0.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and aT.Visible then
                if h:MouseOverDrawing({bd.section_frame.Position.X, bd.section_frame.Position.Y + keybind.axis,
                                       bd.section_frame.Position.X + bd.section_frame.Size.X,
                                       bd.section_frame.Position.Y + keybind.axis + 17}) and not ae:IsOverContent() and
                    not keybind.selecting then
                    keybind.selecting = true;
                    aV.Color = k.dark_contrast
                end
                if keybind.open and keybind.modemenu.frame then
                    if h:MouseOverDrawing({keybind.modemenu.frame.Position.X, keybind.modemenu.frame.Position.Y,
                                           keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X,
                                           keybind.modemenu.frame.Position.Y + keybind.modemenu.frame.Size.Y}) then
                        local ct = false;
                        for F, G in pairs(keybind.modemenu.buttons) do
                            if h:MouseOverDrawing({keybind.modemenu.frame.Position.X,
                                                   keybind.modemenu.frame.Position.Y + 15 * (F - 1),
                                                   keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X,
                                                   keybind.modemenu.frame.Position.Y + 15 * (F - 1) + 15}) then
                                keybind.mode = G.Text;
                                ct = true
                            end
                        end
                        if ct then
                            keybind:Reset()
                        end
                    else
                        keybind.open = not keybind.open;
                        for F, G in pairs(keybind.modemenu.drawings) do
                            h:Remove(G)
                        end
                        keybind.modemenu.drawings = {}
                        keybind.modemenu.buttons = {}
                        keybind.modemenu.frame = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.keybind = nil
                    end
                end
            end
            if b0.UserInputType == Enum.UserInputType.MouseButton2 and ae.isVisible and aT.Visible then
                if h:MouseOverDrawing({bd.section_frame.Position.X, bd.section_frame.Position.Y + keybind.axis,
                                       bd.section_frame.Position.X + bd.section_frame.Size.X,
                                       bd.section_frame.Position.Y + keybind.axis + 17}) and not ae:IsOverContent() and
                    not keybind.selecting then
                    ae:CloseContent()
                    keybind.open = not keybind.open;
                    local ay = h:Create("Frame", {Vector2.new(aT.Size.X + 2, 0), aT}, {
                        Size = h:Size(0, 64, 0, 49),
                        Position = h:Position(1, 2, 0, 0, aT),
                        Color = k.outline,
                        Visible = b6.open
                    }, keybind.modemenu.drawings)
                    keybind.modemenu.frame = ay;
                    local cu = h:Create("Frame", {Vector2.new(1, 1), ay}, {
                        Size = h:Size(1, -2, 1, -2, ay),
                        Position = h:Position(0, 1, 0, 1, ay),
                        Color = k.inline,
                        Visible = b6.open
                    }, keybind.modemenu.drawings)
                    local cv = h:Create("Frame", {Vector2.new(1, 1), cu}, {
                        Size = h:Size(1, -2, 1, -2, cu),
                        Position = h:Position(0, 1, 0, 1, cu),
                        Color = k.light_contrast,
                        Visible = b6.open
                    }, keybind.modemenu.drawings)
                    local cn = h:Create("Image", {Vector2.new(0, 0), cv}, {
                        Size = h:Size(1, 0, 1, 0, cv),
                        Position = h:Position(0, 0, 0, 0, cv),
                        Transparency = 0.5,
                        Visible = b6.open
                    }, keybind.modemenu.drawings)
                    h:LoadImage(cn, "gradient", "https://i.imgur.com/5hmlrjX.png")
                    for F, G in pairs({"Always", "Toggle", "Hold"}) do
                        local cw = h:Create("TextLabel", {Vector2.new(cv.Size.X / 2, 15 * (F - 1)), cv}, {
                            Text = G,
                            Size = k.textsize,
                            Font = k.font,
                            Color = G == keybind.mode and k.accent or k.textcolor,
                            Center = true,
                            OutlineColor = k.textborder,
                            Position = h:Position(0.5, 0, 0, 15 * (F - 1), cv),
                            Visible = b6.open
                        }, keybind.modemenu.drawings)
                        keybind.modemenu.buttons[#keybind.modemenu.buttons + 1] = cw
                    end
                    ae.currentContent.frame = ay;
                    ae.currentContent.keybind = keybind
                end
            end
        end;
        g.ended[#g.ended + 1] = function(b0)
            if keybind.active and keybind.mode == "Hold" then
                if keybind.current[1] and keybind.current[2] then
                    if b0.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or b0.UserInputType ==
                        Enum[keybind.current[1]][keybind.current[2]] then
                        keybind.active = false;
                        ae.keybindslist:Remove(aQ or ab)
                        bD(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    end
                end
            end
        end;
        if by and tostring(by) ~= "" and tostring(by) ~= " " and not g.pointers[tostring(by)] then
            g.pointers[tostring(by)] = keybind
        end
        bd.currentAxis = bd.currentAxis + 17 + 4;
        bd:Update()
        return keybind
    end
    function j:Colorpicker(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Colorpicker"
        local bK = aa.info or aa.Info or ab;
        local bC = aa.def or aa.Def or aa.default or aa.Default or Color3.fromRGB(255, 0, 0)
        local bL = aa.transparency or aa.Transparency or aa.transp or aa.Transp or aa.alpha or aa.Alpha or nil;
        local by = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local bD = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        local ae = self.window;
        local b6 = self.page;
        local bd = self;
        local bM, bN, bO = bC:ToHSV()
        local ax = {
            axis = bd.currentAxis,
            secondColorpicker = false,
            current = {bM, bN, bO, bL or 0},
            holding = {
                picker = false,
                huepicker = false,
                transparency = false
            },
            holder = {
                inline = nil,
                picker = nil,
                picker_cursor = nil,
                huepicker = nil,
                huepicker_cursor = {},
                transparency = nil,
                transparencybg = nil,
                transparency_cursor = {},
                drawings = {}
            }
        }
        local bP = h:Create("Frame", {Vector2.new(bd.section_frame.Size.X - (30 + 4), ax.axis), bd.section_frame}, {
            Size = h:Size(0, 30, 0, 15),
            Position = h:Position(1, -(30 + 4), 0, ax.axis, bd.section_frame),
            Color = k.outline,
            Visible = b6.open
        }, bd.visibleContent)
        local bQ = h:Create("Frame", {Vector2.new(1, 1), bP}, {
            Size = h:Size(1, -2, 1, -2, bP),
            Position = h:Position(0, 1, 0, 1, bP),
            Color = k.inline,
            Visible = b6.open
        }, bd.visibleContent)
        local bR;
        if bL then
            bR = h:Create("Image", {Vector2.new(1, 1), bQ}, {
                Size = h:Size(1, -2, 1, -2, bQ),
                Position = h:Position(0, 1, 0, 1, bQ),
                Visible = b6.open
            }, bd.visibleContent)
        end
        local bS = h:Create("Frame", {Vector2.new(1, 1), bQ}, {
            Size = h:Size(1, -2, 1, -2, bQ),
            Position = h:Position(0, 1, 0, 1, bQ),
            Color = bC,
            Transparency = bL and 1 - bL or 1,
            Visible = b6.open
        }, bd.visibleContent)
        local bT = h:Create("Image", {Vector2.new(0, 0), bS}, {
            Size = h:Size(1, 0, 1, 0, bS),
            Position = h:Position(0, 0, 0, 0, bS),
            Transparency = 0.5,
            Visible = b6.open
        }, bd.visibleContent)
        local c0 = h:Create("TextLabel", {Vector2.new(4,
            ax.axis + 15 / 2 - h:GetTextBounds(ab, k.textsize, k.font).Y / 2), bd.section_frame}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 4, 0, ax.axis + 15 / 2 - h:GetTextBounds(ab, k.textsize, k.font).Y / 2,
                bd.section_frame),
            Visible = b6.open
        }, bd.visibleContent)
        if bL then
            h:LoadImage(bR, "cptransp", "https://i.imgur.com/IIPee2A.png")
        end
        h:LoadImage(bT, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function ax:Set(bU, bV)
            if typeof(bU) == "table" then
                ax.current = bU;
                bS.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                bS.Transparency = 1 - ax.current[4]
                bD(Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3]), ax.current[4])
            elseif typeof(bU) == "color3" then
                local bW, b5, G = bU:ToHSV()
                ax.current = {bW, b5, G, bV or 0}
                bS.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                bS.Transparency = 1 - ax.current[4]
                bD(Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3]), ax.current[4])
            end
        end
        function ax:Refresh()
            local S = h:MouseLocation()
            if ax.open and ax.holder.picker and ax.holding.picker then
                ax.current[2] = math.clamp(S.X - ax.holder.picker.Position.X, 0, ax.holder.picker.Size.X) /
                                    ax.holder.picker.Size.X;
                ax.current[3] = 1 - math.clamp(S.Y - ax.holder.picker.Position.Y, 0, ax.holder.picker.Size.Y) /
                                    ax.holder.picker.Size.Y;
                ax.holder.picker_cursor.Position =
                    h:Position(ax.current[2], -3, 1 - ax.current[3], -3, ax.holder.picker)
                h:UpdateOffset(ax.holder.picker_cursor,
                    {Vector2.new(ax.holder.picker.Size.X * ax.current[2] - 3,
                        ax.holder.picker.Size.Y * (1 - ax.current[3]) - 3), ax.holder.picker})
                if ax.holder.transparencybg then
                    ax.holder.transparencybg.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                end
            elseif ax.open and ax.holder.huepicker and ax.holding.huepicker then
                ax.current[1] = math.clamp(S.Y - ax.holder.huepicker.Position.Y, 0, ax.holder.huepicker.Size.Y) /
                                    ax.holder.huepicker.Size.Y;
                ax.holder.huepicker_cursor[1].Position = h:Position(0, -3, ax.current[1], -3, ax.holder.huepicker)
                ax.holder.huepicker_cursor[2].Position = h:Position(0, 1, 0, 1, ax.holder.huepicker_cursor[1])
                ax.holder.huepicker_cursor[3].Position = h:Position(0, 1, 0, 1, ax.holder.huepicker_cursor[2])
                ax.holder.huepicker_cursor[3].Color = Color3.fromHSV(ax.current[1], 1, 1)
                h:UpdateOffset(ax.holder.huepicker_cursor[1],
                    {Vector2.new(-3, ax.holder.huepicker.Size.Y * ax.current[1] - 3), ax.holder.huepicker})
                ax.holder.background.Color = Color3.fromHSV(ax.current[1], 1, 1)
                if ax.holder.transparency_cursor and ax.holder.transparency_cursor[3] then
                    ax.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - ax.current[4])
                end
                if ax.holder.transparencybg then
                    ax.holder.transparencybg.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                end
            elseif ax.open and ax.holder.transparency and ax.holding.transparency then
                ax.current[4] = 1 -
                                    math.clamp(S.X - ax.holder.transparency.Position.X, 0, ax.holder.transparency.Size.X) /
                                    ax.holder.transparency.Size.X;
                ax.holder.transparency_cursor[1].Position = h:Position(1 - ax.current[4], -3, 0, -3,
                    ax.holder.transparency)
                ax.holder.transparency_cursor[2].Position = h:Position(0, 1, 0, 1, ax.holder.transparency_cursor[1])
                ax.holder.transparency_cursor[3].Position = h:Position(0, 1, 0, 1, ax.holder.transparency_cursor[2])
                ax.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - ax.current[4])
                bS.Transparency = 1 - ax.current[4]
                h:UpdateTransparency(bS, 1 - ax.current[4])
                h:UpdateOffset(ax.holder.transparency_cursor[1], {Vector2.new(
                    ax.holder.transparency.Size.X * (1 - ax.current[4]) - 3, -3), ax.holder.transparency})
                ax.holder.background.Color = Color3.fromHSV(ax.current[1], 1, 1)
            end
            ax:Set(ax.current)
        end
        function ax:Get()
            return Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
        end
        g.began[#g.began + 1] = function(b0)
            if b0.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and bP.Visible then
                if ax.open and ax.holder.inline and
                    h:MouseOverDrawing({ax.holder.inline.Position.X, ax.holder.inline.Position.Y,
                                        ax.holder.inline.Position.X + ax.holder.inline.Size.X,
                                        ax.holder.inline.Position.Y + ax.holder.inline.Size.Y}) then
                    if ax.holder.picker and
                        h:MouseOverDrawing({ax.holder.picker.Position.X - 2, ax.holder.picker.Position.Y - 2,
                                            ax.holder.picker.Position.X - 2 + ax.holder.picker.Size.X + 4,
                                            ax.holder.picker.Position.Y - 2 + ax.holder.picker.Size.Y + 4}) then
                        ax.holding.picker = true;
                        ax:Refresh()
                    elseif ax.holder.huepicker and
                        h:MouseOverDrawing({ax.holder.huepicker.Position.X - 2, ax.holder.huepicker.Position.Y - 2,
                                            ax.holder.huepicker.Position.X - 2 + ax.holder.huepicker.Size.X + 4,
                                            ax.holder.huepicker.Position.Y - 2 + ax.holder.huepicker.Size.Y + 4}) then
                        ax.holding.huepicker = true;
                        ax:Refresh()
                    elseif ax.holder.transparency and
                        h:MouseOverDrawing(
                            {ax.holder.transparency.Position.X - 2, ax.holder.transparency.Position.Y - 2,
                             ax.holder.transparency.Position.X - 2 + ax.holder.transparency.Size.X + 4,
                             ax.holder.transparency.Position.Y - 2 + ax.holder.transparency.Size.Y + 4}) then
                        ax.holding.transparency = true;
                        ax:Refresh()
                    end
                elseif h:MouseOverDrawing({bd.section_frame.Position.X, bd.section_frame.Position.Y + ax.axis,
                                           bd.section_frame.Position.X + bd.section_frame.Size.X -
                    (ax.secondColorpicker and 30 + 4 or 0), bd.section_frame.Position.Y + ax.axis + 15}) and
                    not ae:IsOverContent() then
                    if not ax.open then
                        ae:CloseContent()
                        ax.open = not ax.open;
                        local bX = h:Create("Frame", {Vector2.new(4, ax.axis + 19), bd.section_frame}, {
                            Size = h:Size(1, -8, 0, bL and 219 or 200, bd.section_frame),
                            Position = h:Position(0, 4, 0, ax.axis + 19, bd.section_frame),
                            Color = k.outline
                        }, ax.holder.drawings)
                        ax.holder.inline = bX;
                        local bY = h:Create("Frame", {Vector2.new(1, 1), bX}, {
                            Size = h:Size(1, -2, 1, -2, bX),
                            Position = h:Position(0, 1, 0, 1, bX),
                            Color = k.inline
                        }, ax.holder.drawings)
                        local bZ = h:Create("Frame", {Vector2.new(1, 1), bY}, {
                            Size = h:Size(1, -2, 1, -2, bY),
                            Position = h:Position(0, 1, 0, 1, bY),
                            Color = k.dark_contrast
                        }, ax.holder.drawings)
                        local b_ = h:Create("Frame", {Vector2.new(0, 0), bZ}, {
                            Size = h:Size(1, 0, 0, 2, bZ),
                            Position = h:Position(0, 0, 0, 0, bZ),
                            Color = k.accent
                        }, ax.holder.drawings)
                        local c0 = h:Create("TextLabel", {Vector2.new(4, 2), bZ}, {
                            Text = bK,
                            Size = k.textsize,
                            Font = k.font,
                            Color = k.textcolor,
                            OutlineColor = k.textborder,
                            Position = h:Position(0, 4, 0, 2, bZ)
                        }, ax.holder.drawings)
                        local c1 = h:Create("Frame", {Vector2.new(4, 17), bZ}, {
                            Size = h:Size(1, -27, 1, bL and -40 or -21, bZ),
                            Position = h:Position(0, 4, 0, 17, bZ),
                            Color = k.outline
                        }, ax.holder.drawings)
                        local c2 = h:Create("Frame", {Vector2.new(1, 1), c1}, {
                            Size = h:Size(1, -2, 1, -2, c1),
                            Position = h:Position(0, 1, 0, 1, c1),
                            Color = k.inline
                        }, ax.holder.drawings)
                        local c3 = h:Create("Frame", {Vector2.new(1, 1), c2}, {
                            Size = h:Size(1, -2, 1, -2, c2),
                            Position = h:Position(0, 1, 0, 1, c2),
                            Color = Color3.fromHSV(ax.current[1], 1, 1)
                        }, ax.holder.drawings)
                        ax.holder.background = c3;
                        local c4 = h:Create("Image", {Vector2.new(0, 0), c3}, {
                            Size = h:Size(1, 0, 1, 0, c3),
                            Position = h:Position(0, 0, 0, 0, c3)
                        }, ax.holder.drawings)
                        ax.holder.picker = c4;
                        local c5 = h:Create("Image", {Vector2.new(c4.Size.X * ax.current[2] - 3,
                            c4.Size.Y * (1 - ax.current[3]) - 3), c4}, {
                            Size = h:Size(0, 6, 0, 6, c4),
                            Position = h:Position(ax.current[2], -3, 1 - ax.current[3], -3, c4)
                        }, ax.holder.drawings)
                        ax.holder.picker_cursor = c5;
                        local c6 = h:Create("Frame", {Vector2.new(bZ.Size.X - 19, 17), bZ}, {
                            Size = h:Size(0, 15, 1, bL and -40 or -21, bZ),
                            Position = h:Position(1, -19, 0, 17, bZ),
                            Color = k.outline
                        }, ax.holder.drawings)
                        local c7 = h:Create("Frame", {Vector2.new(1, 1), c6}, {
                            Size = h:Size(1, -2, 1, -2, c6),
                            Position = h:Position(0, 1, 0, 1, c6),
                            Color = k.inline
                        }, ax.holder.drawings)
                        local c8 = h:Create("Image", {Vector2.new(1, 1), c7}, {
                            Size = h:Size(1, -2, 1, -2, c7),
                            Position = h:Position(0, 1, 0, 1, c7)
                        }, ax.holder.drawings)
                        ax.holder.huepicker = c8;
                        local c9 = h:Create("Frame", {Vector2.new(-3, c8.Size.Y * ax.current[1] - 3), c8}, {
                            Size = h:Size(1, 6, 0, 6, c8),
                            Position = h:Position(0, -3, ax.current[1], -3, c8),
                            Color = k.outline
                        }, ax.holder.drawings)
                        ax.holder.huepicker_cursor[1] = c9;
                        local ca = h:Create("Frame", {Vector2.new(1, 1), c9}, {
                            Size = h:Size(1, -2, 1, -2, c9),
                            Position = h:Position(0, 1, 0, 1, c9),
                            Color = k.textcolor
                        }, ax.holder.drawings)
                        ax.holder.huepicker_cursor[2] = ca;
                        local cb = h:Create("Frame", {Vector2.new(1, 1), ca}, {
                            Size = h:Size(1, -2, 1, -2, ca),
                            Position = h:Position(0, 1, 0, 1, ca),
                            Color = Color3.fromHSV(ax.current[1], 1, 1)
                        }, ax.holder.drawings)
                        ax.holder.huepicker_cursor[3] = cb;
                        if bL then
                            local cc = h:Create("Frame", {Vector2.new(4, bZ.Size.X - 19), bZ}, {
                                Size = h:Size(1, -27, 0, 15, bZ),
                                Position = h:Position(0, 4, 1, -19, bZ),
                                Color = k.outline
                            }, ax.holder.drawings)
                            local cd = h:Create("Frame", {Vector2.new(1, 1), cc}, {
                                Size = h:Size(1, -2, 1, -2, cc),
                                Position = h:Position(0, 1, 0, 1, cc),
                                Color = k.inline
                            }, ax.holder.drawings)
                            local ce = h:Create("Frame", {Vector2.new(1, 1), cd}, {
                                Size = h:Size(1, -2, 1, -2, cd),
                                Position = h:Position(0, 1, 0, 1, cd),
                                Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                            }, ax.holder.drawings)
                            ax.holder.transparencybg = ce;
                            local cf = h:Create("Image", {Vector2.new(1, 1), cd}, {
                                Size = h:Size(1, -2, 1, -2, cd),
                                Position = h:Position(0, 1, 0, 1, cd)
                            }, ax.holder.drawings)
                            ax.holder.transparency = cf;
                            local cg = h:Create("Frame", {Vector2.new(cf.Size.X * (1 - ax.current[4]) - 3, -3), cf}, {
                                Size = h:Size(0, 6, 1, 6, cf),
                                Position = h:Position(1 - ax.current[4], -3, 0, -3, cf),
                                Color = k.outline
                            }, ax.holder.drawings)
                            ax.holder.transparency_cursor[1] = cg;
                            local ch = h:Create("Frame", {Vector2.new(1, 1), cg}, {
                                Size = h:Size(1, -2, 1, -2, cg),
                                Position = h:Position(0, 1, 0, 1, cg),
                                Color = k.textcolor
                            }, ax.holder.drawings)
                            ax.holder.transparency_cursor[2] = ch;
                            local ci = h:Create("Frame", {Vector2.new(1, 1), ch}, {
                                Size = h:Size(1, -2, 1, -2, ch),
                                Position = h:Position(0, 1, 0, 1, ch),
                                Color = Color3.fromHSV(0, 0, 1 - ax.current[4])
                            }, ax.holder.drawings)
                            ax.holder.transparency_cursor[3] = ci;
                            h:LoadImage(cf, "transp", "https://i.imgur.com/ncssKbH.png")
                        end
                        h:LoadImage(c4, "valsat", "https://i.imgur.com/wpDRqVH.png")
                        h:LoadImage(c5, "valsat_cursor",
                            "https://raw.githubusercontent.com/mvonwalk/splix-assets/main/Images-cursor.png")
                        h:LoadImage(c8, "hue", "https://i.imgur.com/iEOsHFv.png")
                        ae.currentContent.frame = bY;
                        ae.currentContent.colorpicker = ax
                    else
                        ax.open = not ax.open;
                        for F, G in pairs(ax.holder.drawings) do
                            h:Remove(G)
                        end
                        ax.holder.drawings = {}
                        ax.holder.inline = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.colorpicker = nil
                    end
                else
                    if ax.open then
                        ax.open = not ax.open;
                        for F, G in pairs(ax.holder.drawings) do
                            h:Remove(G)
                        end
                        ax.holder.drawings = {}
                        ax.holder.inline = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.colorpicker = nil
                    end
                end
            elseif b0.UserInputType == Enum.UserInputType.MouseButton1 and ax.open then
                ax.open = not ax.open;
                for F, G in pairs(ax.holder.drawings) do
                    h:Remove(G)
                end
                ax.holder.drawings = {}
                ax.holder.inline = nil;
                ae.currentContent.frame = nil;
                ae.currentContent.colorpicker = nil
            end
        end;
        g.ended[#g.ended + 1] = function(b0)
            if b0.UserInputType == Enum.UserInputType.MouseButton1 then
                if ax.holding.picker then
                    ax.holding.picker = not ax.holding.picker
                end
                if ax.holding.huepicker then
                    ax.holding.huepicker = not ax.holding.huepicker
                end
                if ax.holding.transparency then
                    ax.holding.transparency = not ax.holding.transparency
                end
            end
        end;
        g.changed[#g.changed + 1] = function()
            if ax.open and ax.holding.picker or ax.holding.huepicker or ax.holding.transparency then
                if ae.isVisible then
                    ax:Refresh()
                else
                    if ax.holding.picker then
                        ax.holding.picker = not ax.holding.picker
                    end
                    if ax.holding.huepicker then
                        ax.holding.huepicker = not ax.holding.huepicker
                    end
                    if ax.holding.transparency then
                        ax.holding.transparency = not ax.holding.transparency
                    end
                end
            end
        end;
        if by and tostring(by) ~= "" and tostring(by) ~= " " and not g.pointers[tostring(by)] then
            g.pointers[tostring(by)] = ax
        end
        bd.currentAxis = bd.currentAxis + 15 + 4;
        bd:Update()
        function ax:Colorpicker(aa)
            local aa = aa or {}
            local bK = aa.info or aa.Info or ab;
            local bC = aa.def or aa.Def or aa.default or aa.Default or Color3.fromRGB(255, 0, 0)
            local bL = aa.transparency or aa.Transparency or aa.transp or aa.Transp or aa.alpha or aa.Alpha or nil;
            local by = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
            local bD = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
            end;
            ax.secondColorpicker = true;
            local bM, bN, bO = bC:ToHSV()
            local ax = {
                axis = ax.axis,
                current = {bM, bN, bO, bL or 0},
                holding = {
                    picker = false,
                    huepicker = false,
                    transparency = false
                },
                holder = {
                    inline = nil,
                    picker = nil,
                    picker_cursor = nil,
                    huepicker = nil,
                    huepicker_cursor = {},
                    transparency = nil,
                    transparencybg = nil,
                    transparency_cursor = {},
                    drawings = {}
                }
            }
            bP.Position = h:Position(1, -(60 + 8), 0, ax.axis, bd.section_frame)
            h:UpdateOffset(bP, {Vector2.new(bd.section_frame.Size.X - (60 + 8), ax.axis), bd.section_frame})
            local bP = h:Create("Frame", {Vector2.new(bd.section_frame.Size.X - (30 + 4), ax.axis), bd.section_frame},
                {
                    Size = h:Size(0, 30, 0, 15),
                    Position = h:Position(1, -(30 + 4), 0, ax.axis, bd.section_frame),
                    Color = k.outline,
                    Visible = b6.open
                }, bd.visibleContent)
            local bQ = h:Create("Frame", {Vector2.new(1, 1), bP}, {
                Size = h:Size(1, -2, 1, -2, bP),
                Position = h:Position(0, 1, 0, 1, bP),
                Color = k.inline,
                Visible = b6.open
            }, bd.visibleContent)
            local bR;
            if bL then
                bR = h:Create("Image", {Vector2.new(1, 1), bQ}, {
                    Size = h:Size(1, -2, 1, -2, bQ),
                    Position = h:Position(0, 1, 0, 1, bQ),
                    Visible = b6.open
                }, bd.visibleContent)
            end
            local bS = h:Create("Frame", {Vector2.new(1, 1), bQ}, {
                Size = h:Size(1, -2, 1, -2, bQ),
                Position = h:Position(0, 1, 0, 1, bQ),
                Color = bC,
                Transparency = bL and 1 - bL or 1,
                Visible = b6.open
            }, bd.visibleContent)
            local bT = h:Create("Image", {Vector2.new(0, 0), bS}, {
                Size = h:Size(1, 0, 1, 0, bS),
                Position = h:Position(0, 0, 0, 0, bS),
                Transparency = 0.5,
                Visible = b6.open
            }, bd.visibleContent)
            if bL then
                h:LoadImage(bR, "cptransp", "https://i.imgur.com/IIPee2A.png")
            end
            h:LoadImage(bT, "gradient", "https://i.imgur.com/5hmlrjX.png")
            function ax:Set(bU, bV)
                if typeof(bU) == "table" then
                    ax.current = bU;
                    bS.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                    bS.Transparency = 1 - ax.current[4]
                    bD(Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3]), ax.current[4])
                elseif typeof(bU) == "color3" then
                    local bW, b5, G = bU:ToHSV()
                    ax.current = {bW, b5, G, bV or 0}
                    bS.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                    bS.Transparency = 1 - ax.current[4]
                    bD(Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3]), ax.current[4])
                end
            end
            function ax:Refresh()
                local S = h:MouseLocation()
                if ax.open and ax.holder.picker and ax.holding.picker then
                    ax.current[2] = math.clamp(S.X - ax.holder.picker.Position.X, 0, ax.holder.picker.Size.X) /
                                        ax.holder.picker.Size.X;
                    ax.current[3] = 1 - math.clamp(S.Y - ax.holder.picker.Position.Y, 0, ax.holder.picker.Size.Y) /
                                        ax.holder.picker.Size.Y;
                    ax.holder.picker_cursor.Position = h:Position(ax.current[2], -3, 1 - ax.current[3], -3,
                        ax.holder.picker)
                    h:UpdateOffset(ax.holder.picker_cursor,
                        {Vector2.new(ax.holder.picker.Size.X * ax.current[2] - 3,
                            ax.holder.picker.Size.Y * (1 - ax.current[3]) - 3), ax.holder.picker})
                    if ax.holder.transparencybg then
                        ax.holder.transparencybg.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                    end
                elseif ax.open and ax.holder.huepicker and ax.holding.huepicker then
                    ax.current[1] = math.clamp(S.Y - ax.holder.huepicker.Position.Y, 0, ax.holder.huepicker.Size.Y) /
                                        ax.holder.huepicker.Size.Y;
                    ax.holder.huepicker_cursor[1].Position = h:Position(0, -3, ax.current[1], -3, ax.holder.huepicker)
                    ax.holder.huepicker_cursor[2].Position = h:Position(0, 1, 0, 1, ax.holder.huepicker_cursor[1])
                    ax.holder.huepicker_cursor[3].Position = h:Position(0, 1, 0, 1, ax.holder.huepicker_cursor[2])
                    ax.holder.huepicker_cursor[3].Color = Color3.fromHSV(ax.current[1], 1, 1)
                    h:UpdateOffset(ax.holder.huepicker_cursor[1], {Vector2.new(-3, ax.holder.huepicker.Size.Y *
                        ax.current[1] - 3), ax.holder.huepicker})
                    ax.holder.background.Color = Color3.fromHSV(ax.current[1], 1, 1)
                    if ax.holder.transparency_cursor and ax.holder.transparency_cursor[3] then
                        ax.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - ax.current[4])
                    end
                    if ax.holder.transparencybg then
                        ax.holder.transparencybg.Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                    end
                elseif ax.open and ax.holder.transparency and ax.holding.transparency then
                    ax.current[4] = 1 -
                                        math.clamp(S.X - ax.holder.transparency.Position.X, 0,
                            ax.holder.transparency.Size.X) / ax.holder.transparency.Size.X;
                    ax.holder.transparency_cursor[1].Position =
                        h:Position(1 - ax.current[4], -3, 0, -3, ax.holder.transparency)
                    ax.holder.transparency_cursor[2].Position = h:Position(0, 1, 0, 1, ax.holder.transparency_cursor[1])
                    ax.holder.transparency_cursor[3].Position = h:Position(0, 1, 0, 1, ax.holder.transparency_cursor[2])
                    ax.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - ax.current[4])
                    bS.Transparency = 1 - ax.current[4]
                    h:UpdateTransparency(bS, 1 - ax.current[4])
                    h:UpdateOffset(ax.holder.transparency_cursor[1], {Vector2.new(
                        ax.holder.transparency.Size.X * (1 - ax.current[4]) - 3, -3), ax.holder.transparency})
                    ax.holder.background.Color = Color3.fromHSV(ax.current[1], 1, 1)
                end
                ax:Set(ax.current)
            end
            function ax:Get()
                return Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
            end
            g.began[#g.began + 1] = function(b0)
                if b0.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and bP.Visible then
                    if ax.open and ax.holder.inline and
                        h:MouseOverDrawing({ax.holder.inline.Position.X, ax.holder.inline.Position.Y,
                                            ax.holder.inline.Position.X + ax.holder.inline.Size.X,
                                            ax.holder.inline.Position.Y + ax.holder.inline.Size.Y}) then
                        if ax.holder.picker and
                            h:MouseOverDrawing({ax.holder.picker.Position.X - 2, ax.holder.picker.Position.Y - 2,
                                                ax.holder.picker.Position.X - 2 + ax.holder.picker.Size.X + 4,
                                                ax.holder.picker.Position.Y - 2 + ax.holder.picker.Size.Y + 4}) then
                            ax.holding.picker = true;
                            ax:Refresh()
                        elseif ax.holder.huepicker and
                            h:MouseOverDrawing({ax.holder.huepicker.Position.X - 2, ax.holder.huepicker.Position.Y - 2,
                                                ax.holder.huepicker.Position.X - 2 + ax.holder.huepicker.Size.X + 4,
                                                ax.holder.huepicker.Position.Y - 2 + ax.holder.huepicker.Size.Y + 4}) then
                            ax.holding.huepicker = true;
                            ax:Refresh()
                        elseif ax.holder.transparency and
                            h:MouseOverDrawing(
                                {ax.holder.transparency.Position.X - 2, ax.holder.transparency.Position.Y - 2,
                                 ax.holder.transparency.Position.X - 2 + ax.holder.transparency.Size.X + 4,
                                 ax.holder.transparency.Position.Y - 2 + ax.holder.transparency.Size.Y + 4}) then
                            ax.holding.transparency = true;
                            ax:Refresh()
                        end
                    elseif h:MouseOverDrawing({bd.section_frame.Position.X + bd.section_frame.Size.X - (30 + 4 + 2),
                                               bd.section_frame.Position.Y + ax.axis,
                                               bd.section_frame.Position.X + bd.section_frame.Size.X,
                                               bd.section_frame.Position.Y + ax.axis + 15}) and not ae:IsOverContent() then
                        if not ax.open then
                            ae:CloseContent()
                            ax.open = not ax.open;
                            local bX = h:Create("Frame", {Vector2.new(4, ax.axis + 19), bd.section_frame}, {
                                Size = h:Size(1, -8, 0, bL and 219 or 200, bd.section_frame),
                                Position = h:Position(0, 4, 0, ax.axis + 19, bd.section_frame),
                                Color = k.outline
                            }, ax.holder.drawings)
                            ax.holder.inline = bX;
                            local bY = h:Create("Frame", {Vector2.new(1, 1), bX}, {
                                Size = h:Size(1, -2, 1, -2, bX),
                                Position = h:Position(0, 1, 0, 1, bX),
                                Color = k.inline
                            }, ax.holder.drawings)
                            local bZ = h:Create("Frame", {Vector2.new(1, 1), bY}, {
                                Size = h:Size(1, -2, 1, -2, bY),
                                Position = h:Position(0, 1, 0, 1, bY),
                                Color = k.dark_contrast
                            }, ax.holder.drawings)
                            local b_ = h:Create("Frame", {Vector2.new(0, 0), bZ}, {
                                Size = h:Size(1, 0, 0, 2, bZ),
                                Position = h:Position(0, 0, 0, 0, bZ),
                                Color = k.accent
                            }, ax.holder.drawings)
                            local c0 = h:Create("TextLabel", {Vector2.new(4, 2), bZ}, {
                                Text = bK,
                                Size = k.textsize,
                                Font = k.font,
                                Color = k.textcolor,
                                OutlineColor = k.textborder,
                                Position = h:Position(0, 4, 0, 2, bZ)
                            }, ax.holder.drawings)
                            local c1 = h:Create("Frame", {Vector2.new(4, 17), bZ}, {
                                Size = h:Size(1, -27, 1, bL and -40 or -21, bZ),
                                Position = h:Position(0, 4, 0, 17, bZ),
                                Color = k.outline
                            }, ax.holder.drawings)
                            local c2 = h:Create("Frame", {Vector2.new(1, 1), c1}, {
                                Size = h:Size(1, -2, 1, -2, c1),
                                Position = h:Position(0, 1, 0, 1, c1),
                                Color = k.inline
                            }, ax.holder.drawings)
                            local c3 = h:Create("Frame", {Vector2.new(1, 1), c2}, {
                                Size = h:Size(1, -2, 1, -2, c2),
                                Position = h:Position(0, 1, 0, 1, c2),
                                Color = Color3.fromHSV(ax.current[1], 1, 1)
                            }, ax.holder.drawings)
                            ax.holder.background = c3;
                            local c4 = h:Create("Image", {Vector2.new(0, 0), c3}, {
                                Size = h:Size(1, 0, 1, 0, c3),
                                Position = h:Position(0, 0, 0, 0, c3)
                            }, ax.holder.drawings)
                            ax.holder.picker = c4;
                            local c5 = h:Create("Image", {Vector2.new(c4.Size.X * ax.current[2] - 3,
                                c4.Size.Y * (1 - ax.current[3]) - 3), c4}, {
                                Size = h:Size(0, 6, 0, 6, c4),
                                Position = h:Position(ax.current[2], -3, 1 - ax.current[3], -3, c4)
                            }, ax.holder.drawings)
                            ax.holder.picker_cursor = c5;
                            local c6 = h:Create("Frame", {Vector2.new(bZ.Size.X - 19, 17), bZ}, {
                                Size = h:Size(0, 15, 1, bL and -40 or -21, bZ),
                                Position = h:Position(1, -19, 0, 17, bZ),
                                Color = k.outline
                            }, ax.holder.drawings)
                            local c7 = h:Create("Frame", {Vector2.new(1, 1), c6}, {
                                Size = h:Size(1, -2, 1, -2, c6),
                                Position = h:Position(0, 1, 0, 1, c6),
                                Color = k.inline
                            }, ax.holder.drawings)
                            local c8 = h:Create("Image", {Vector2.new(1, 1), c7}, {
                                Size = h:Size(1, -2, 1, -2, c7),
                                Position = h:Position(0, 1, 0, 1, c7)
                            }, ax.holder.drawings)
                            ax.holder.huepicker = c8;
                            local c9 = h:Create("Frame", {Vector2.new(-3, c8.Size.Y * ax.current[1] - 3), c8}, {
                                Size = h:Size(1, 6, 0, 6, c8),
                                Position = h:Position(0, -3, ax.current[1], -3, c8),
                                Color = k.outline
                            }, ax.holder.drawings)
                            ax.holder.huepicker_cursor[1] = c9;
                            local ca = h:Create("Frame", {Vector2.new(1, 1), c9}, {
                                Size = h:Size(1, -2, 1, -2, c9),
                                Position = h:Position(0, 1, 0, 1, c9),
                                Color = k.textcolor
                            }, ax.holder.drawings)
                            ax.holder.huepicker_cursor[2] = ca;
                            local cb = h:Create("Frame", {Vector2.new(1, 1), ca}, {
                                Size = h:Size(1, -2, 1, -2, ca),
                                Position = h:Position(0, 1, 0, 1, ca),
                                Color = Color3.fromHSV(ax.current[1], 1, 1)
                            }, ax.holder.drawings)
                            ax.holder.huepicker_cursor[3] = cb;
                            if bL then
                                local cc = h:Create("Frame", {Vector2.new(4, bZ.Size.X - 19), bZ}, {
                                    Size = h:Size(1, -27, 0, 15, bZ),
                                    Position = h:Position(0, 4, 1, -19, bZ),
                                    Color = k.outline
                                }, ax.holder.drawings)
                                local cd = h:Create("Frame", {Vector2.new(1, 1), cc}, {
                                    Size = h:Size(1, -2, 1, -2, cc),
                                    Position = h:Position(0, 1, 0, 1, cc),
                                    Color = k.inline
                                }, ax.holder.drawings)
                                local ce = h:Create("Frame", {Vector2.new(1, 1), cd}, {
                                    Size = h:Size(1, -2, 1, -2, cd),
                                    Position = h:Position(0, 1, 0, 1, cd),
                                    Color = Color3.fromHSV(ax.current[1], ax.current[2], ax.current[3])
                                }, ax.holder.drawings)
                                ax.holder.transparencybg = ce;
                                local cf = h:Create("Image", {Vector2.new(1, 1), cd}, {
                                    Size = h:Size(1, -2, 1, -2, cd),
                                    Position = h:Position(0, 1, 0, 1, cd)
                                }, ax.holder.drawings)
                                ax.holder.transparency = cf;
                                local cg = h:Create("Frame", {Vector2.new(cf.Size.X * (1 - ax.current[4]) - 3, -3), cf},
                                    {
                                        Size = h:Size(0, 6, 1, 6, cf),
                                        Position = h:Position(1 - ax.current[4], -3, 0, -3, cf),
                                        Color = k.outline
                                    }, ax.holder.drawings)
                                ax.holder.transparency_cursor[1] = cg;
                                local ch = h:Create("Frame", {Vector2.new(1, 1), cg}, {
                                    Size = h:Size(1, -2, 1, -2, cg),
                                    Position = h:Position(0, 1, 0, 1, cg),
                                    Color = k.textcolor
                                }, ax.holder.drawings)
                                ax.holder.transparency_cursor[2] = ch;
                                local ci = h:Create("Frame", {Vector2.new(1, 1), ch}, {
                                    Size = h:Size(1, -2, 1, -2, ch),
                                    Position = h:Position(0, 1, 0, 1, ch),
                                    Color = Color3.fromHSV(0, 0, 1 - ax.current[4])
                                }, ax.holder.drawings)
                                ax.holder.transparency_cursor[3] = ci;
                                h:LoadImage(cf, "transp", "https://i.imgur.com/ncssKbH.png")
                            end
                            h:LoadImage(c4, "valsat", "https://i.imgur.com/wpDRqVH.png")
                            h:LoadImage(c5, "valsat_cursor",
                                "https://raw.githubusercontent.com/mvonwalk/splix-assets/main/Images-cursor.png")
                            h:LoadImage(c8, "hue", "https://i.imgur.com/iEOsHFv.png")
                            ae.currentContent.frame = bY;
                            ae.currentContent.colorpicker = ax
                        else
                            ax.open = not ax.open;
                            for F, G in pairs(ax.holder.drawings) do
                                h:Remove(G)
                            end
                            ax.holder.drawings = {}
                            ax.holder.inline = nil;
                            ae.currentContent.frame = nil;
                            ae.currentContent.colorpicker = nil
                        end
                    else
                        if ax.open then
                            ax.open = not ax.open;
                            for F, G in pairs(ax.holder.drawings) do
                                h:Remove(G)
                            end
                            ax.holder.drawings = {}
                            ax.holder.inline = nil;
                            ae.currentContent.frame = nil;
                            ae.currentContent.colorpicker = nil
                        end
                    end
                elseif b0.UserInputType == Enum.UserInputType.MouseButton1 and ax.open then
                    ax.open = not ax.open;
                    for F, G in pairs(ax.holder.drawings) do
                        h:Remove(G)
                    end
                    ax.holder.drawings = {}
                    ax.holder.inline = nil;
                    ae.currentContent.frame = nil;
                    ae.currentContent.colorpicker = nil
                end
            end;
            g.ended[#g.ended + 1] = function(b0)
                if b0.UserInputType == Enum.UserInputType.MouseButton1 then
                    if ax.holding.picker then
                        ax.holding.picker = not ax.holding.picker
                    end
                    if ax.holding.huepicker then
                        ax.holding.huepicker = not ax.holding.huepicker
                    end
                    if ax.holding.transparency then
                        ax.holding.transparency = not ax.holding.transparency
                    end
                end
            end;
            g.changed[#g.changed + 1] = function()
                if ax.open and ax.holding.picker or ax.holding.huepicker or ax.holding.transparency then
                    if ae.isVisible then
                        ax:Refresh()
                    else
                        if ax.holding.picker then
                            ax.holding.picker = not ax.holding.picker
                        end
                        if ax.holding.huepicker then
                            ax.holding.huepicker = not ax.holding.huepicker
                        end
                        if ax.holding.transparency then
                            ax.holding.transparency = not ax.holding.transparency
                        end
                    end
                end
            end;
            if by and tostring(by) ~= "" and tostring(by) ~= " " and not g.pointers[tostring(by)] then
                g.pointers[tostring(by)] = keybind
            end
            return ax
        end
        return ax
    end
    function j:ConfigBox(aa)
        local aa = aa or {}
        local ae = self.window;
        local b6 = self.page;
        local bd = self;
        local de = {
            axis = bd.currentAxis,
            current = 1,
            buttons = {}
        }
        local df = h:Create("Frame", {Vector2.new(4, de.axis), bd.section_frame}, {
            Size = h:Size(1, -8, 0, 148, bd.section_frame),
            Position = h:Position(0, 4, 0, de.axis, bd.section_frame),
            Color = k.outline,
            Visible = b6.open
        }, bd.visibleContent)
        local dg = h:Create("Frame", {Vector2.new(1, 1), df}, {
            Size = h:Size(1, -2, 1, -2, df),
            Position = h:Position(0, 1, 0, 1, df),
            Color = k.inline,
            Visible = b6.open
        }, bd.visibleContent)
        local dh = h:Create("Frame", {Vector2.new(1, 1), dg}, {
            Size = h:Size(1, -2, 1, -2, dg),
            Position = h:Position(0, 1, 0, 1, dg),
            Color = k.light_contrast,
            Visible = b6.open
        }, bd.visibleContent)
        local di = h:Create("Image", {Vector2.new(0, 0), dh}, {
            Size = h:Size(1, 0, 1, 0, dh),
            Position = h:Position(0, 0, 0, 0, dh),
            Transparency = 0.5,
            Visible = b6.open
        }, bd.visibleContent)
        for F = 1, 8 do
            local dj = h:Create("TextLabel", {Vector2.new(dh.Size.X / 2, 2 + 18 * (F - 1)), dh}, {
                Text = "Config-Slot: " .. tostring(F),
                Size = k.textsize,
                Font = k.font,
                Color = F == 1 and k.accent or k.textcolor,
                OutlineColor = k.textborder,
                Center = true,
                Position = h:Position(0.5, 0, 0, 2 + 18 * (F - 1), dh),
                Visible = b6.open
            }, bd.visibleContent)
            de.buttons[F] = dj
        end
        h:LoadImage(di, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function de:Refresh()
            for F, G in pairs(de.buttons) do
                G.Color = F == de.current and k.accent or k.textcolor
            end
        end
        function de:Get()
            return de.current
        end
        function de:Set(dk)
            de.current = dk;
            de:Refresh()
        end
        g.began[#g.began + 1] = function(b0)
            if b0.UserInputType == Enum.UserInputType.MouseButton1 and df.Visible and ae.isVisible and
                h:MouseOverDrawing({bd.section_frame.Position.X, bd.section_frame.Position.Y + de.axis,
                                    bd.section_frame.Position.X + bd.section_frame.Size.X,
                                    bd.section_frame.Position.Y + de.axis + 148}) and not ae:IsOverContent() then
                for F = 1, 8 do
                    if h:MouseOverDrawing({bd.section_frame.Position.X,
                                           bd.section_frame.Position.Y + de.axis + 2 + 18 * (F - 1),
                                           bd.section_frame.Position.X + bd.section_frame.Size.X,
                                           bd.section_frame.Position.Y + de.axis + 2 + 18 * (F - 1) + 18}) then
                        de.current = F;
                        de:Refresh()
                    end
                end
            end
        end;
        ae.pointers["configbox"] = de;
        bd.currentAxis = bd.currentAxis + 148 + 4;
        bd:Update()
        return de
    end
end
return g, h, g.pointers, k
