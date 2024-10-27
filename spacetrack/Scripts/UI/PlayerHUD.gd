extends CanvasLayer

@onready var killsLabel : Label = get_node("./UI/PlayerInfo/Kills/Value")
@onready var speedLabel : Label = get_node("./UI/PlayerInfo/Speed/Value")

@onready var healthBar : ProgressBar = get_node("./UI/Health/HealthBar")

func _ready() -> void:
	SignalBus.UpdateKills.connect(OnUpdateKills)
	SignalBus.UpdateHealth.connect(OnUpdateHealth)
	
	SignalBus.UpdateKills.emit()

func _physics_process(delta: float) -> void:
	OnUpdateSpeed()

func OnUpdateKills() -> void:
	killsLabel.text = str(PlayerInfo.playerKills)

func OnUpdateSpeed() -> void:
	speedLabel.text = str(int(PlayerInfo.playerSpeed))

func OnUpdateHealth() -> void:
	healthBar.value = PlayerInfo.playerHealth
