local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function react_functional_component(args, state)
	local component_name = args[1][1]
	return "const "
		.. component_name
		.. " = () => {\n\treturn (\n\t\t<div>\n\t\t\t{/* Your code here */}\n\t\t</div>\n\t);\n};\n\nexport default "
		.. component_name
		.. ";"
end

return {
	s("rfc", {
		t({ "", "" }),
		i(1, "ComponentName"),
		t({ "", "" }),
		f(react_functional_component, { 1 }),
	}),
}
