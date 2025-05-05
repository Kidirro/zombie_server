Config = {}

-- The walking styles that undead peds will use.
Config.walkingStyles = {
	{"default", "very_drunk"},
	{"murfree", "very_drunk"},
	{"default", "dehydrated_unarmed"},
}

--Радиус обнаружения игрока
Config.detectionRadius = 15.0

--Радиус преследования игрока
Config.stalkingRadius = 30.0

-- Спрайт для отрисовки зоны пиздеца
Config.zoneBlipSprite = 693035517

Config.playerListCheckTime = 10000

--Зоны пиздеца
Config.zones = {
	world = {
		name = "Worldwide",		
		coords = vector3(0, -500, 51.75),
		radius = 5000.0
	},
	annesburg = {
		name = "Annesburg",
		coords = vector3(2905.50, 1356.83, 51.75),
		radius = 400.0
	},
	armadillo = {
		name = "Armadillo",
		coords = vector3(-3678.58, -2613.38, -14.11),
		radius = 150.0
	},
	benedictpoint = {
		name = "Benedict Point",
		coords = vector3(-5224.15, -3472.15, -20.55),
		radius = 150.0
	},
	blackwater = {
		name = "Blackwater",
		coords = vector3(-924.87, -1313.61, 46.26),
		radius = 300.0
	},
	emeraldranch = {
		name = "Emerald Ranch",
		coords = vector3(1421.56, 323.30, 88.39),
		radius = 300.0
	},
	flatironlake = {
		name = "Flatiron Lake Islands",
		coords = vector3(429.59, -1480.59, 40.24),
		radius = 450.0
	},
	fortmercer = {
		name = "Fort Mercer",
		coords = vector3(-4210.57, -3446.08, 37.08),
		radius = 150.0
	},
	grizzlieseast = {
		name = "East Grizzlies",
		coords = vector3(1934.70, 1950.61, 266.12),
		radius = 400.0
	},
	heartlandoilfields = {
		name = "Heartland Oil Fields",
		coords = vector3(521.93, 621.11, 109.92),
		radius = 150.0
	},
	lagras = {
		name = "Lagras",
		coords = vector3(2034.59, -633.62, 42.94),
		radius = 300.0
	},
	macfarlanesranch = {
		name = "Macfarlane's Ranch",
		coords = vector3(-2377.92, -2406.36, 61.76),
		radius = 150.0
	},
	rhodes = {
		name = "Rhodes",
		coords = vector3(1311.61, -1339.71, 77.21),
		radius = 500.0
	},
	saintdenis = {
		name = "Saint Denis",
		coords = vector3(2615.96, -1262.17, 52.56),
		radius = 600.0
	},
	sisika = {
		name = "Sisika Pennitentiary",
		coords = vector3(3272.51, -624.70, 42.66),
		radius = 300.0
	},
	strawberry = {
		name = "Strawberry",
		coords = vector3(-1791.29, -403.40, 154.49),
		radius = 250.0
	},
	thieveslanding = {
		name = "Thieves Landing",
		coords = vector3(-1411.47, -2259.47, 42.35),
		radius = 200.0
	},
	tumbleweed = {
		name = "Tumbleweed",
		coords = vector3(-5519.54, -2950.01, -1.68),
		radius = 150.0
	},
	valentine = {
		name = "Valentine",
		coords = vector3(-282.55, 720.44, 114.89),
		radius = 400.0
	},
	vanhorn = {
		name = "Van Horn",
		coords = vector3(2930.26, 523.47, 45.31),
		radius = 200.0
	}
}