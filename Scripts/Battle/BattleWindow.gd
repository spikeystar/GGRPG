extends PanelContainer

signal index_reset()

func index_reset() ->void:
	emit_signal("index_reset")
