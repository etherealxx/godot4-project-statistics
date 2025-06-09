@tool
extends EditorPlugin

const StatisticsPreview: PackedScene = preload("./nodes/StatisticsPreview.tscn")

const IGNORE_PROPERTY: String = "statistics/ignore"
const FORCE_INCLUDE_PROPERTY: String = "statistics/force_include"

var DEFAULT_IGNORE: PackedStringArray = PackedStringArray([
	"res://.import/*",
	"res://.github/*",
	"res://addons/*",
	"*.import"
])

var preview: Control

func _enter_tree() -> void:
	preview = StatisticsPreview.instantiate()
	#preview.editor_interface = get_editor_interface()
	#add_control_to_bottom_panel(preview, "Statistics")
	EditorInterface.get_editor_main_screen().add_child(preview)
	_setup()
	_make_visible(false)

func _exit_tree() -> void:
	#remove_control_from_bottom_panel(preview)
	#preview.editor_interface = null
	if preview:
		preview.queue_free()

func _setup() -> void:
	if not ProjectSettings.has_setting(IGNORE_PROPERTY):
		ProjectSettings.set_setting(IGNORE_PROPERTY, DEFAULT_IGNORE)
		ProjectSettings.add_property_info({
			name = IGNORE_PROPERTY,
			type = TYPE_PACKED_STRING_ARRAY
		})
		ProjectSettings.set_initial_value(IGNORE_PROPERTY, DEFAULT_IGNORE)
	
	if not ProjectSettings.has_setting(FORCE_INCLUDE_PROPERTY):
		ProjectSettings.set_setting(FORCE_INCLUDE_PROPERTY, PackedStringArray())
		ProjectSettings.add_property_info({
			name = FORCE_INCLUDE_PROPERTY,
			type = TYPE_PACKED_STRING_ARRAY
		})

func _has_main_screen():
	return true

func _make_visible(visible):
	if preview:
		preview.visible = visible

func _get_plugin_name():
	return "Stats"
	
func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("ProjectList", "EditorIcons")
