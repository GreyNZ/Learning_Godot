extends Area2D



func _on_SpikeTop_body_entered(body):
	if body.has_method("hurt"):
		print("oh no spikes!!!")
		#body.hurt()
		get_tree().call_group("Gamestate", "hurt")
	else: 
		print("failed collision error")
		pass
