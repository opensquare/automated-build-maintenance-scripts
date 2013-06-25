#!/bin/bash

latest_packages_to_keep=2
archive_dir='.old'

# Stop on error
set -e

cd "`dirname \"$0\"`"

function archive {
        mkdir -p $archive_dir
        for p in `ls *.rpm | sed 's/[0-9]*\.[0-9]*\-[0-9]*\.noarch\.rpm//' | sort | uniq`
        do
                echo $p
                old_files="`ls ${p}* | head -n-$latest_packages_to_keep`"
                if [[ `echo $old_files | wc -w` > 0 ]]
                then
                        mv $old_files $archive_dir
                fi
        done
}

archive

