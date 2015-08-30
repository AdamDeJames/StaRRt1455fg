job_config = {}
job_config.Name = "Citizen"
job_config.ID = 1
job_config.Salary = 50
job_config.MaxPlayers = game.MaxPlayers()
job_config.Weapons = {}
job_config.Color = Color(0, 255, 0, 255)
job_config.Model = "models/player/group01/male_09.mdl"
GM:LoadJob(job_config)