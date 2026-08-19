local Adapter = {}

local function fire(control, value)
	control.Value = value
	if control.Callback then pcall(control.Callback, value) end
	for _, callback in ipairs(control.Changed) do pcall(callback, value) end
end

local function control(default, callback)
	local object = {Value = default, Callback = callback, Changed = {}}
	function object:OnChanged(callbackChanged)
		table.insert(self.Changed, callbackChanged)
	end
	function object:SetValue(value)
		fire(self, value)
	end
	return object
end

local function wrapTab(native, options)
	local tab = {}

	function tab:AddSection(title)
		native:Seperator(title)
	end

	function tab:AddParagraph(data)
		local title = tostring(data.Title or "")
		local content = tostring(data.Content or data.Description or "")
		local label = native:Label(title .. (content ~= "" and " : " .. content or ""))
		local paragraph = {Title = title, Content = content}
		function paragraph:SetDesc(value)
			self.Content = tostring(value or "")
			label:Set(self.Title .. (self.Content ~= "" and " : " .. self.Content or ""))
		end
		return paragraph
	end

	function tab:AddButton(data)
		native:Button(data.Title or "Button", function()
			if data.Callback then pcall(data.Callback) end
		end)
	end

	function tab:AddToggle(id, data)
		local object = control(data.Default == true, data.Callback)
		options[id] = object
		native:Toggle(data.Title or id, object.Value, data.Description, function(value)
			fire(object, value)
		end)
		return object
	end

	function tab:AddDropdown(id, data)
		local values = data.Values or {}
		local object = control(data.Default, data.Callback)
		options[id] = object
		local nativeDropdown = native:Dropdown(data.Title or id, values, data.Default, function(value)
			fire(object, value)
		end)
		function object:SetValues(newValues)
			if nativeDropdown and nativeDropdown.Clear and nativeDropdown.Add then
				nativeDropdown:Clear()
				for _, value in ipairs(newValues or {}) do nativeDropdown:Add(value) end
			end
		end
		return object
	end

	function tab:AddSlider(id, data)
		local object = control(data.Default or data.Min or 0, data.Callback)
		options[id] = object
		native:Slider(data.Title or id, data.Min or 0, data.Max or 100, object.Value, function(value)
			fire(object, value)
		end)
		return object
	end

	function tab:AddInput(id, data)
		local object = control(data.Default or "", data.Callback)
		options[id] = object
		native:Textbox(data.Title or id, data.Finished ~= false, function(value)
			fire(object, value)
		end)
		return object
	end

	return tab
end

function Adapter.Create(banana, config)
	local nativeWindow = banana:Window({
		Title = config.Title or "IKAROHUB",
		SubTitle = config.SubTitle or "by ikaro",
		Size = config.Size or UDim2.new(0, 620, 0, 420),
		TabWidth = config.TabWidth or 180
	})
	local options = {}
	local fluent = {Options = options}
	local window = {}

	function window:AddTab(data)
		return wrapTab(nativeWindow:Tab(data.Title or "Tab", data.Icon or ""), options)
	end
	function window:SelectTab() end
	function fluent:Notify(data)
		local message = tostring(data.Title or "IKAROHUB")
		if data.Content then message = message .. "\n" .. tostring(data.Content) end
		pcall(function() banana:Notify(message, data.Duration or 4) end)
	end

	return fluent, window
end

return Adapter
