static var ResourceLoadingUtilities = preload("./resource_loading_utilities.gd")

const SUPPORTED_FILE_EXTENSIONS: Array[String] = [
	# Scenes & scripts
	"tscn", "scn", "gd", "cs", "visual",
	
	# Textures / Images
	"png", "jpg", "jpeg", "bmp", "tga", "webp", "exr", "svg",
	
	# Audio
	"wav", "ogg", "mp3", "flac",
	
	# Fonts
	"fnt", "ttf", "otf",
	
	# Materials & shaders
	"tres", "res", "shader",
	
	# Meshes / 3D
	"mesh", "obj", "dae", "glb", "gltf", "fbx",
	
	# Animations
	"anim",
	
	# Particles / other resources
	"tres", "res",

	# JSON
	"json", "jsonc"
]


## Gets a dictionary of all the resources in the folder (and subfolders) specified. (filename: resource).
## Type check for AudioStream example: func(resource): return resource is AudioStream
static func get_all_resources_in_folder_recursive(folder_path: String, type_check, set_key_lower_case := false, full_file_path := false, verbose := false) -> Dictionary:
	if verbose:
		print("BetterResourceLoader.get_all_resources_in_folder_recursive searching in \"%s\"" % folder_path)
	var resources: Dictionary = {}

	ResourceLoadingUtilities.iterate_over_all_file_paths_in_dir_and_sub_dirs(folder_path,
	func(path: String):
		if verbose:
			print("  - " + path.trim_prefix("res://"))
		if not SUPPORTED_FILE_EXTENSIONS.has(path.get_extension().to_lower()): return
		if not ResourceLoader.exists(path): return
		var resource = ResourceLoader.load(path)
		if resource == null: return
		if !type_check.call(resource): return

		# full file path as key?
		var key = path
		if not full_file_path:
			key = PathUtility.get_stem(path)

		# key lowercase?
		if set_key_lower_case:
			key = key.to_lower()
		
		resources[key] = resource
	)
	return resources

