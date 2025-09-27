extends CanvasLayer

@export var story_text := "Long ago, a hero rose to climb the towers..."
@export var fade_duration := 2.0

@onready var color_rect := $ColorRect
@onready var story_label := $StoryLabel

func _ready():
	story_label.text = story_text
	story_label.visible = false
	color_rect.modulate.a = 1.0  # start fully black
	start_intro()

func start_intro():
	story_label.visible = true
	color_rect.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 0.0, fade_duration)
	tween.tween_callback(Callable(self, "_on_intro_finished"))

func _on_intro_finished():
	var player = get_node("/root/Game/Player")
	player.visible = true
	color_rect.queue_free()
