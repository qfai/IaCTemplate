set -e
set -x

while read replica; do
    from=$(echo $replica | jq -c '.from')
    replaces=()
    fromStage=$(echo $from | jq -r .stage)
    fromName=$(echo $from | jq -r .name)
    srcPath="./$fromStage/$fromName"
    while read replace; do
        replaces+=($replace)
    done < <(echo $from | jq -r .replaces[])

    stack=$(echo $replica | jq -c '.to')
    name=$(echo "$stack" | jq -r .name)
    stage=$(echo "$stack" | jq -r .stage)

    destPath="./$stage/$name"

    echo "Replicating $srcPath to $destPath."

    [ ! -e $destPath ] || rm -rf $destPath

    cp -r $srcPath $destPath

    pushd $destPath
    length=${#replaces[@]}
    for file in *; do
        for ((i = 0; i < ${length}; i++)); do
            value=$(echo "$stack" | jq -r .replaces[$i])
            sed -i "s/${replaces[$i]}/$value/g" $file
        done
    done

    popd

done < <(cat ".azure/scale_stacks.json" | jq -c '.[]')

rm .azure/scale_stacks.json