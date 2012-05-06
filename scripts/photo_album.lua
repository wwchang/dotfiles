--[[
Photo Album by londonali1010 (2009)
 
This script draws a photo album of the files in a specified directory.  Files will be displayed in order; there is currently no option to randomise.
 
To call this script in Conky (assuming that you have saved it as ~/scripts/photo_album.lua), use the following before TEXT:
    lua_load ~/scripts/photo_album.lua
    lua_draw_hook_pre photo_album
 
Changelog:
+ v1.0 -- Original release (03.11.2009)
]]
 
require 'cairo'
require 'imlib2'
 
-- OPTIONS
-- "album_dir" is the directory containing the images for your photo album; please note that the path must be absolute (e.g. no "~")
album_dir = "/home/whore/Pictures/"
-- "xc" and "yc" are the coordinates of the centre of the photo album, relative to the top left corner of the Conky window, in pixels
xc, yc = 150, 120
-- "w_max" and "h_max" are the maximum dimensions, in pixels, that you want the widget to be.  The script will ensure that the photo album fits inside the box bounded by w_max and h_max
w_max, h_max = 300, 240
-- "t" is the thickness of the frame, in pixels
t = 10
-- "update_interval" is the number of Conky updates between refreshes
update_interval = 1
 
function get_file_to_use()
    num_files = tonumber(conky_parse("${exec ls -A " .. album_dir .. " | wc -l}"))
    if num_files == nil then num_files = 0 end
    if num_files == 0 then return "none" end
 
    updates = tonumber(conky_parse("${updates}"))
    whole = math.ceil(updates/update_interval)
 
    if whole < = num_files
    then
        num_file_to_show = whole
    else
        whole = whole % num_files
        num_file_to_show = whole
    end
 
    return conky_parse("${exec ls " .. album_dir .. " | sed -n " .. num_file_to_show .. "p}")
end
 
function init_drawing_surface()
    imlib_set_cache_size(4096 * 1024)
    imlib_context_set_dither(1)
end
 
function draw_frame()
	local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual,  conky_window.width, conky_window.height)
 
    cr = cairo_create(cs)
 
    cairo_rectangle(cr, xc - width/2 - t, yc - height/2 - t, width + 2*t, height + 2*t)
    cairo_set_source_rgba(cr, 1, 1, 1, 0.8)
    cairo_fill(cr)   
 
    cairo_destroy(cr)
end
 
function draw_image()
    init_drawing_surface()
 
    image = imlib_load_image(album_dir .. filename)
    if image == nil then return end
    imlib_context_set_image(image)
 
	w_img, h_img = imlib_image_get_width(), imlib_image_get_height()
	if w_img >= h_img
	then
	    width = w_max - 2*t
	    height = width * (h_img/w_img)
	else
	    height = h_max - 2*t
	    width = height * (w_img/h_img)
	end
 
	draw_frame()
 
	buffer = imlib_create_image(width, height)
	imlib_context_set_image(buffer)
 
	imlib_blend_image_onto_image(image, 0, 0, 0, w_img, h_img, 0, 0, width, height)
	imlib_context_set_image(image)
	imlib_free_image()
 
	imlib_context_set_image(buffer)
	imlib_render_image_on_drawable(xc - width/2, yc - height/2)
	imlib_free_image()
end
 
 
function conky_photo_album()
    if conky_window == nil then return end
    filename = get_file_to_use()
    if filename == "none"
    then
        print(album_dir .. ": No files found")
    else
        draw_image()
    end
end
