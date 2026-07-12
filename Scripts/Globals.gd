extends Node3D

signal update_reflections()
signal toggle_free_fly(value)

const BASE_VIEWPORT_SIZE := Vector2i(1280, 720)
const MAX_TESTED_VIEWPORT_SIZE := Vector2i(3840, 2400)
const DEFAULT_3D_SCALE := 1.0
const MIN_3D_SCALE := 0.25
const START_FULLSCREEN := true

func _ready():
	configure_display_scaling()
	if START_FULLSCREEN:
		call_deferred("enter_fullscreen")

func configure_display_scaling():
	var root := get_tree().root
	root.set_content_scale_size(BASE_VIEWPORT_SIZE)
	root.set_content_scale_mode(Window.CONTENT_SCALE_MODE_VIEWPORT)
	root.set_content_scale_aspect(Window.CONTENT_SCALE_ASPECT_EXPAND)
	root.set_content_scale_stretch(Window.CONTENT_SCALE_STRETCH_FRACTIONAL)
	root.scaling_3d_scale = DEFAULT_3D_SCALE

func set_3d_render_scale(scale: float):
	var root := get_tree().root
	root.set_content_scale_aspect(Window.CONTENT_SCALE_ASPECT_EXPAND)
	root.scaling_3d_scale = clampf(scale, MIN_3D_SCALE, DEFAULT_3D_SCALE)

func enter_fullscreen():
	if DisplayServer.get_name() == "headless":
		return
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
