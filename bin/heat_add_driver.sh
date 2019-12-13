#!/bin/bash
# heat_add_driver.sh : driver to add object libs to all heat CMakeLists

for file in $(fd CMakeLists.txt $HEATPATH/src/)
do
    echo $file
    tempFile=temp.txt
    cat $file > $tempFile
    libLine=$(grep -i "add_library" $tempFile)
    lib=$(between_two_chars.sh "$libLine" '(' ' ')
    echo "Found lib $lib"
    objectLib=$lib"-obj"
    
    #remove extraneous lines
    # remove_between_two_words.sh "set(" "^\s*)" $tempFile
    remove_line.sh "add_subdirectory" $tempFile
    remove_line.sh "add_export_target" $tempFile

    #add OBJECT specifier and switch target link to add dependencies
    replace.sh "add_library($lib" "add_library($objectLib OBJECT" $tempFile
    replace.sh "^target_link_libraries($lib" "add_dependencies($objectLib" $tempFile
    replace.sh "PRIVATE" "" $tempFile

    printf "#generated object lib setup\n" >> $file
    cat $tempFile >> $file
done

