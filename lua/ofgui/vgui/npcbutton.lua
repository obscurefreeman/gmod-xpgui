local PANEL = {}

function PANEL:Init()
    -- 继承基础按钮的属性
    self:SetFont("ofgui_medium")
    self:SetText("")
    self:SetTooltipPanelOverride("OFTooltip")
    self:SetDoubleClickingEnabled(false)
    self:SetExpensiveShadow(1, ColorAlpha(color_black, 140))

    -- 创建模型图标
    self.ModelIcon = vgui.Create("ModelImage", self)
    
    -- 设置默认颜色
    self.ColorA = OFGUI.ButtonColor.a
    self.Color = Color(OFGUI.ButtonColor.r, OFGUI.ButtonColor.g, OFGUI.ButtonColor.b, OFGUI.ButtonColor.a)
    
    -- 默认文本
    self.Title = ""
    self.Description = ""
    
    -- 默认大小
    self:SetSize(300, 64)
end

function PANEL:SetModel(mdl)
    self.ModelIcon:SetModel(mdl)
end

function PANEL:SetTitle(text)
    self.Title = text
end

function PANEL:SetDescription(text)
    self.Description = text
end

function PANEL:PerformLayout(w, h)
    -- 设置模型图标的位置和大小
    self.ModelIcon:SetPos(0, 0)
    self.ModelIcon:SetSize(h, h)
end

function PANEL:Paint(w, h)
    -- 背景动画效果
    if self:IsHovered() then
        self.Color.a = Lerp(7.5 * FrameTime(), self.Color.a, self.ColorA + 15)
    else
        self.Color.a = Lerp(7.5 * FrameTime(), self.Color.a, self.ColorA)
    end

    if self:IsDown() then
        self.Color.a = Lerp(7.5 * FrameTime(), self.Color.a, self.ColorA + 25)
    end

    -- 绘制背景
    draw.RoundedBox(6, 0, 0, w, h, self.Color)
    
    -- 绘制标题和描述
    local titleX = h + 10  -- 文字从图标右侧开始
    local titleY = 10
    
    -- 绘制标题
    draw.SimpleText(self.Title, "ofgui_medium", titleX, titleY, OFGUI.ButtonTextColor)
    
    -- 绘制描述（使用较小的字体）
    draw.SimpleText(self.Description, "ofgui_tiny", titleX, titleY + 25, OFGUI.ButtonTextColor)
end

-- 继承原有按钮的声音效果
function PANEL:OnDepressed()
    OFGUI.PlaySound(OFGUI.ButtonClickSound)
end

function PANEL:OnCursorEntered()
    if self:GetDisabled() then return end
    OFGUI.PlaySound(OFGUI.ButtonHoverSound)
end

function PANEL:SetAccentColor(clr)
    self.ColorA = 90
    self.Color = clr
end

derma.DefineControl("OFNPCButton", "A button with model icon and description", PANEL, "DButton") 