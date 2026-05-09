static func iterate_over_all_file_paths_in_dir_and_sub_dirs(folder_path: String, callable: Callable):
	if _should_ignore_folder(folder_path): return
	for file_name in ResourceLoader.list_directory(folder_path):
		var path = folder_path.path_join(file_name)

		# is another dir
		if file_name.ends_with("/"):
			iterate_over_all_file_paths_in_dir_and_sub_dirs(path, callable)
			continue

		# is file
		callable.call(path)


static func _should_ignore_folder(folder_path: String) -> bool:
	for part in PathUtility.get_path_parts(folder_path):
		if part.begins_with("."):
			return true
	return false


## Loads the contents of file_name as json.
## Asserts it's valid.
static func load_immediate_json_contents_safely(file_name: String) -> Dictionary:
	assert(FileAccess.file_exists(file_name), "Cannot load data from %s. It doesn't exist!" % file_name)
	var contents_string = FileAccess.get_file_as_string(file_name)
	assert(contents_string != "", "Cannot load data from %s. It's empty!" % file_name)
	
	var contents = _get_json_parser(file_name).parse_string(contents_string)

	assert(contents != null, "Cannot load data from %s. Is JSON syntax correct?" % file_name)
	return contents


static func _get_json_parser(file_name: String):
	if file_name.ends_with(".json"):
		return JSON
	return JSONC
