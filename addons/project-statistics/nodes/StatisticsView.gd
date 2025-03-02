@tool
class_name StatisticsView
extends Control

signal file_selected(path)

const ProjectStatistics: Script = preload("../loaders/ProjectStatistics.gd")
const FileStatistics: Script = preload("../loaders/FileStatistics.gd")
const PieChart: Script = preload("./charts/PieChart.gd")

var stats: ProjectStatistics

func display(stats: ProjectStatistics) -> void:
	self.stats = stats
	await get_tree().process_frame
	_update_icons()

func _update_icons() -> void:
	pass

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_THEME_CHANGED:
			call_deferred("_update_icons")

static func _format_size(item: TreeItem, column: int, size: int) -> void:
	var size_text: PackedStringArray = String.humanize_size(size).split(" ")
	var size_value: String = size_text[0]
	var size_unit: String = size_text[1]
	item.set_text(column, size_value)
	item.set_suffix(column, size_unit)
	item.set_tooltip_text(column, str(size) + " bytes")
	item.set_text_alignment(column, HORIZONTAL_ALIGNMENT_CENTER)
