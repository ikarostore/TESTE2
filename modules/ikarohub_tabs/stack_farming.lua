local Module = {Name = "Stack farming"}

function Module.Init(context)
	local initializer = context.Initializers and context.Initializers[Module.Name]
	if initializer then return initializer(context) end
	return context.States and context.States[Module.Name]
end

return Module
