#!/bin/bash

current_path=$(pwd)
echo "Current working path: $current_path"
ls -la
chmod 755 ${{ github.workspace }}/*.json
replacements = "${{ secrets.JSON_REPLACEMENTS }}"
# Parse the JSON file
json_data=$(jq -r . ${{ github.workspace}})
# Iterate over replacements and update JSON data
for replacement in $replacements; do
    key=$(echo "$replacement" | cut -d '=' -f 1)
    value=$(echo "$replacement" | cut -d '=' -f 2)
    json_data=$(echo "$json_data" | jq ".${key} = \"$value\"")
done

# Write updated JSON data back to file
echo "$json_data" > ${{github.workspace}}/tes.json
echo ${{ github.workspace }}/tes.json