set -e
set -x

# Install aztfexport

go install github.com/Azure/aztfexport@latest

# Export resources in aztfexport_stacks.json

while read stack; do
    name=$(echo "$stack" | jq -r .name)
    stage=$(echo "$stack" | jq -r .stage)

    echo "Exporting $name to $stage."
    echo $stack | jq -c ".resource_groups"

    [ ! -e "./$stage/$name" ] || rm -rf "./$stage/$name"

    mkdir -p "./$stage/$name"

    pushd "./$stage/$name"

    while read rg; do
        echo "resource group: $rg"
        sub=$(echo $rg | cut -d "/" -f 3)
        rg=$(echo $rg | cut -d "/" -f 5)
        aztfexport resource-group --non-interactive --plain-ui -s "$sub" --append "$rg"
    done < <(echo "$stack" | jq -r '.resource_groups[]')

    echo "Exported $name to $stage."

    ls

    backend=$(cat ../../.azure/backend.template | sed "s/*/${name}/g")
    sed -i "s/backend \"local\" {}/$backend/g" ./terraform.aztfexport.tf

    sed -i "s/resourcegroups/resourceGroups/g" ./main.aztfexport.tf

    terraform fmt -write=true

    popd 

done < <(cat ".azure/aztfexport_stack.json" | jq -c '.[]')

rm .azure/aztfexport_stack.json