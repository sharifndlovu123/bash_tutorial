#!/bin/bash
countries=('USA' 'UK' 'INDIA')
directories=()
mkdir countries
for country in "${countries[@]}"; do
	echo $country
        mkdir -v "countries/$country"
        directories+=("countries/$country")
done

for directory in "${directories[@]}"; do
	echo $directory
        touch "$directory/capital.txt"
        if [[ "$directory" == *"USA" ]]; then
                echo "Found USA in substring. Setting capital city to Washignton, D.C."
                echo "Washington , D.C" > $directory/capital.txt
        elif [[ "$directory" == *"UK" ]]; then  
                echo "Found UK in substring. Setting capital city to London."
                echo "London" > $directory/capital.txt
        elif [[ "$directory" == *"INDIA" ]]; then
                echo "Found INDIA in substring. Setting capital city to New Delhi."
                echo "New Delhi" > $directory/capital.txt
        else
                echo "Error no match substring"
        fi

        echo "Uptime: $(uptime)"
done
