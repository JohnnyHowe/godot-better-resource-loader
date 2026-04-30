static var ResourceLoadingUtilities = preload("./resource_loading_utilities.gd")
const file_reference_key: String = "file_reference"


## load_file_references will make the loader find all "file_reference": string attributes and fill them out with the data from there.
static func get_json_contents(file_name: String, load_file_references = true) -> Dictionary:
	var contents = ResourceLoadingUtilities.load_immediate_json_contents_safely(file_name)

	if load_file_references:
		_load_sub_files(contents, [file_name])

	return contents


## Find all "file_reference": String attributes and load the contents.
## Recursively searches.
static func _load_sub_files(data: Dictionary, file_names_searched: Array[String] = []):
	for key in data.keys():
		var candidate_data = data[key]
		if candidate_data is not Dictionary: continue

		if _is_file_reference(candidate_data):
			if file_names_searched.has(key): return

			data[key] = get_json_contents(candidate_data[file_reference_key])

		else:
			_load_sub_files(candidate_data, file_names_searched)


static func _is_file_reference(dict: Dictionary) -> bool:
	return dict.has(file_reference_key)

