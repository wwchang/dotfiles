--[[ AIR CLOCK WIDGET ]]
--[[ Options (xc, yc, size):
	"xc" and "yc" are the x and y coordinates of the centre of the clock, in pixels, relative to the top left of the Conky window
	"size" is the total size of the widget, in pixels ]]
 
function air_clock(cr, xc, yc, size)
	local offset = 0
 
	shadow_width = size * 0.03
	shadow_xoffset = 0
	shadow_yoffset = size * 0.01
 
	if shadow_xoffset >= shadow_yoffset then
		offset = shadow_xoffset
	else offset = shadow_yoffset
	end
 
	local clock_r = (size - 2 * offset) / (2 * 1.25)
 
	show_seconds=true
 
	-- Grab time
 
	local hours=os.date("%I")
	local mins=os.date("%M")
	local secs=os.date("%S")
 
	secs_arc=(2*math.pi/60)*secs
	mins_arc=(2*math.pi/60)*mins
	hours_arc=(2*math.pi/12)*hours+mins_arc/12
 
	-- Drop shadow
 
	local ds_pat=cairo_pattern_create_radial(xc+shadow_xoffset,yc+shadow_yoffset,clock_r*1.25,xc+shadow_xoffset,yc+shadow_yoffset,clock_r*1.25+shadow_width)
	cairo_pattern_add_color_stop_rgba(ds_pat,0,0,0,0,0.2)
	cairo_pattern_add_color_stop_rgba(ds_pat,1,0,0,0,0)
 
	cairo_move_to(cr,0,0)
	cairo_line_to(cr,conky_window.width,0)
	cairo_line_to(cr,conky_window.width, conky_window.height)
	cairo_line_to(cr,0,conky_window.height)
	cairo_close_path(cr)
	cairo_new_sub_path(cr)
	cairo_arc(cr,xc,yc,clock_r*1.25,0,2*math.pi)
	cairo_set_source(cr,ds_pat)
	cairo_set_fill_rule(cr,CAIRO_FILL_RULE_EVEN_ODD)
	cairo_fill(cr)
 
	-- Glassy border
 
	cairo_arc(cr,xc,yc,clock_r*1.25,0,2*math.pi)
	cairo_set_source_rgba(cr,0.5,0.5,0.5,0.2)
	cairo_set_line_width(cr,1)
	cairo_stroke(cr)
 
	local border_pat=cairo_pattern_create_linear(xc,yc-clock_r*1.25,xc,yc+clock_r*1.25)
 
	cairo_pattern_add_color_stop_rgba(border_pat,0,1,1,1,0.7)
	cairo_pattern_add_color_stop_rgba(border_pat,0.3,1,1,1,0)
	cairo_pattern_add_color_stop_rgba(border_pat,0.5,1,1,1,0)
	cairo_pattern_add_color_stop_rgba(border_pat,0.7,1,1,1,0)
	cairo_pattern_add_color_stop_rgba(border_pat,1,1,1,1,0.7)
	cairo_set_source(cr,border_pat)
	cairo_arc(cr,xc,yc,clock_r*1.125,0,2*math.pi)
	cairo_close_path(cr)
	cairo_set_line_width(cr,clock_r*0.25)
	cairo_stroke(cr)
 
	-- Set clock face
 
	cairo_arc(cr,xc,yc,clock_r,0,2*math.pi)
	cairo_close_path(cr)
 
	local face_pat=cairo_pattern_create_radial(xc,yc-clock_r*0.75,0,xc,yc,clock_r)
 
	cairo_pattern_add_color_stop_rgba(face_pat,0,1,1,1,0.9)
	cairo_pattern_add_color_stop_rgba(face_pat,0.5,1,1,1,0.9)
	cairo_pattern_add_color_stop_rgba(face_pat,1,0.9,0.9,0.9,0.9)
	cairo_set_source(cr,face_pat)
	cairo_fill_preserve(cr)
	cairo_set_source_rgba(cr,0.5,0.5,0.5,0.2)
	cairo_set_line_width(cr, 1)
	cairo_stroke (cr)
 
	-- Draw hour hand
 
	xh=xc+0.7*clock_r*math.sin(hours_arc)
	yh=yc-0.7*clock_r*math.cos(hours_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xh,yh)
 
	cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
	cairo_set_line_width(cr,5)
	cairo_set_source_rgba(cr,0,0,0,0.5)
	cairo_stroke(cr)
 
	-- Draw minute hand
 
	xm=xc+0.9*clock_r*math.sin(mins_arc)
	ym=yc-0.9*clock_r*math.cos(mins_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xm,ym)
 
	cairo_set_line_width(cr,3)
	cairo_stroke(cr)
 
	-- Draw seconds hand
 
	if show_seconds then
		xs=xc+0.9*clock_r*math.sin(secs_arc)
		ys=yc-0.9*clock_r*math.cos(secs_arc)
		cairo_move_to(cr,xc,yc)
		cairo_line_to(cr,xs,ys)
 
		cairo_set_line_width(cr,1)
		cairo_stroke(cr)
	end
end
 
--[[ END AIR CLOCK WIDGET ]]
