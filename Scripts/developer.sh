#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <csv_file>"
    exit 1
fi

csv_file="$1"

awk -v FPAT='([^,]*)|("[^"]+")' 'BEGIN { srand(); }

{
    sub(/#.*/, "")
    if (NR > 1 && NF > 0) {
        gsub(/\\"/, RS)

        for (i = 1; i <= NF; i++) {
            gsub(RS, "\\\"", $i)
            f[i] = $i
        }

        for (i = 1; i <= NF; i++) {
            gsub(/^[[:space:]]+|[[:space:]]+$/, "", f[i])
            gsub(/^"|"$/, "", f[i])

            if (i == 3) {
                game_name = f[i]
            } else if (i == 8) {
                gsub(/[\[\]\047\"]/, "", f[i])
                gsub(/,[[:space:]]*/, ",", f[i])
                split(f[i], devs, ",")
                for (j in devs) {
                    dev = devs[j]
                    if (dev != "") {
                        if (!seen_dev[dev]) {
                            seen_dev[dev] = 1
                            country_id = int(rand() * 13) + 1
                            printf "INSERT INTO lmsrcdeveloper (id, name, country_id) VALUES (%d, '\''%s'\'', %d);\n", ++id, dev, country_id
                        }
                    }
                }
            }
        }
    }
}' "$csv_file"
