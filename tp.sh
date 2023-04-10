#!/bin/bash

# Define an associative array of download links and descriptions
declare -A download_links=(
  ["https://example.com/file1.zip"]="File 1 (ZIP format)"
  ["https://example.com/file2.tar.gz"]="File 2 (Tar Gzip format)"
  ["https://cnam-my.sharepoint.com/personal/jessie_bertanier_lecnam_net/_layouts/15/download.aspx?SourceUrl=%2Fpersonal%2Fjessie%5Fbertanier%5Flecnam%5Fnet%2FDocuments%2FSCENAR%2Egz"]="Autopsy_dump"
)

# Prompt the user to select a download link
echo "Choose a download link:"
for i in "${!download_links[@]}"; do
  echo "${download_links[$i]} ($i)"
done
read -p "Enter the number of the download link you want to download: " link_number

# Download the selected file using wget
if [ "$link_number" -ge 0 ] && [ "$link_number" -lt "${#download_links[@]}" ]; then
  selected_link=$(echo "${!download_links[@]}" | tr ' ' '\n' | sed "${link_number}q;d")
  filename=$(basename "$selected_link")
  wget "$selected_link"
  if [[ "$filename" == *.tar.gz ]]; then
    tar -xzf "$filename"
    rm "$filename"
  fi
  if [[ "$filename" == *.gz ]]; then
    gunzip "$filename"
    rm "$filename"
  fi
else
  echo "Invalid input. Please enter a number between 0 and $((${#download_links[@]} - 1))."
fi
