#!/bin/bash
# manychange : change many strings that have a keyword to them

str="
    $<TARGET_OBJECTS:driver>    
    $<TARGET_OBJECTS:inputs>    
    $<TARGET_OBJECTS:outputs>    
    $<TARGET_OBJECTS:trajectory>
    $<TARGET_OBJECTS:mollier>    
    $<TARGET_OBJECTS:erode>    
    $<TARGET_OBJECTS:atmosphere>    
    $<TARGET_OBJECTS:aeroco>    
    $<TARGET_OBJECTS:pressure>    
    $<TARGET_OBJECTS:meit>    
    $<TARGET_OBJECTS:shock>    
    $<TARGET_OBJECTS:matinput>    
    $<TARGET_OBJECTS:streamline>    
    $<TARGET_OBJECTS:geoinput>    
    $<TARGET_OBJECTS:convert_inputs>    
    $<TARGET_OBJECTS:envir>    
    $<TARGET_OBJECTS:patch_geo>    
    $<TARGET_OBJECTS:thermal>    
    $<TARGET_OBJECTS:flowenvrt>
    $<TARGET_OBJECTS:preprocess>    
    $<TARGET_OBJECTS:input_deck>    
    $<TARGET_OBJECTS:core>    
    $<TARGET_OBJECTS:geometry>"

for word in $str:
do
    lib=$(between_two_chars.sh "$word" ":" ">")
    addlib="add_library(heat-$lib $<TARGET_OBJECTS:$lib>)"
    echo $addlib
done


for word in $str:
do
    lib=$(between_two_chars.sh "$word" ":" ">")
    link_openmp="target_link_libraries(heat-$lib PRIVATE OpenMP::OpenMP_Fortran)"
    echo $link_openmp
done

for word in $str:
do
    lib=$(between_two_chars.sh "$word" ":" ">")
    export_target="add_export_target(heat-$lib heat)"
    echo $export_target
done

for word in $str:
do
    lib=$(between_two_chars.sh "$word" ":" ">")
    echo $lib
done
