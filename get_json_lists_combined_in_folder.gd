static var ResourceLoadingUtilities = preload("./resource_loading_utilities.gd")

const SUPPORTED_EXTENSIONS: Array[String] = [
	".json",
	".jsonc"
]

## Get a big list combining all the root lists of json files in
static func get_json_lists_combined_in_folder(folder_path: String) -> Array:
	var list = []
	ResourceLoadingUtilities.iterate_over_all_file_paths_in_dir_and_sub_dirs(folder_path,
	func(path: String):
		if _has_supported_extension(path):
			list.append_array(JSONC.parse_string(FileAccess.get_file_as_string(path)))
	)
	return list


static func _has_supported_extension(folder_path: String) -> bool:
	for extension in SUPPORTED_EXTENSIONS:
		if folder_path.ends_with(extension):
			return true
	return false
