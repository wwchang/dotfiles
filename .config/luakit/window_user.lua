-- [ progress indicator ]
-- progressbar
-- some people prefer a more visual representation of the page loading status to 
-- simple numbers, i.e. some kind of bar instead of just xx%.
-- use this function to override the default 'update_progress' in widnow.lua.

-- This gives you a progress indicator which looks like this (63% ██████----), 
-- thus every 10% loaded, the progressbar gains one piece.
-- window.methods.update_progress = function (w, view, p)
--     if not view then view = w:get_current() end
--     if not p then p = view:get_prop("progress") end
--     local loaded = w.sbar.l.loaded
--     if not view:loading() or p == 1 then
--         loaded:hide()
--     else
--         loaded:show()
--         local pbar = {"-","-","-","-","-","-","-","-","-","-"}
--         for i=1, math.floor((p*10)) do pbar[i] = "█" end
--         local text = string.format("(%d%% %s)", p * 100, table.concat(pbar, ""))
--         if loaded.text ~= text then loaded.text = text end
--     end
-- end

-- progress indicator:
window.methods.update_progress = function (w, view, p)
    if not view then view = w:get_current() end
    if not p then p = view:get_prop("progress") end
    local loaded = w.sbar.l.loaded
    if not view:loading() or p == 1 then
        loaded:hide()
    else
        loaded:show()
        local pbar2 = {"▁","▂","▃","▄","▅","▆","▇","█"}
        local pchar = pbar2[(math.floor(p*100)%#pbar2)+1]
        local text = string.format("(%d%% %s)", p * 100, pchar)
        if loaded.text ~= text then loaded.text = text end
    end
end
