function Entity:symlink()
	if not MANAGER.show_symlink then
		return ""
	end

	local to = self._file.link_to
	return ""
	-- return to and ui.Span(string.format(" -> %s", to)):italic() or ""
end

-- function Status:mode()
-- 	local mode = tostring(self._tab.mode):upper()
--
-- 	local style = self:style()
-- 	return ui.Line {
-- 		ui.Span(THEME.status.separator_open):fg(style.main.bg),
-- 		ui.Span(" " .. mode .. " "):style(style.main),
-- 		ui.Span(THEME.status.separator_close):fg(style.main.bg):bg(style.alt.bg),
-- 	}
-- end

function Status:name()
	local h = self._current.hovered
	if not h then
		return ""
	end

	local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end
	return ui.Line(" " .. h.name .. linked)
end
