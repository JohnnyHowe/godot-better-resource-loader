class_name BetterResourceLoader


static var _get_all_resources_in_folder_recursive: Callable = preload("./get_all_resources_in_folder_recursive.gd").get_all_resources_in_folder_recursive

## Gets a dictionary of all the resources in the folder (and subfolders) specified. (filename: resource).
## Type check for AudioStream example: func(resource): return resource is AudioStream
static func get_all_resources_in_folder_recursive(folder_path: String, type_check, set_key_lower_case := false, full_file_path := false, verbose := false) -> Dictionary:
	return _get_all_resources_in_folder_recursive.call(folder_path, type_check, set_key_lower_case, full_file_path, verbose)
	

static var _get_json_lists_combined_in_folder: Callable = preload("./get_json_lists_combined_in_folder.gd").get_json_lists_combined_in_folder

## Get a big list combining all the root lists of json files in
static func get_json_lists_combined_in_folder(folder_path: String) -> Array:
	return _get_json_lists_combined_in_folder.call(folder_path)


static var _get_json_contents: Callable = preload("./get_json_contents.gd").get_json_contents

## load_file_references will make the loader find all "file_reference": string attributes and fill them out with the data from there.
static func get_json_contents(file_name: String, load_file_references = true) -> Dictionary:
	return _get_json_contents.call(file_name, load_file_references)
