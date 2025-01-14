#!/bin/bash

# Function to create the monorepo structure
create_monorepo() {
    local monorepo_name=$1
    mkdir -p $monorepo_name/{.devcontainer,projects,lib,docs,scripts/{common-scripts,shell-scripts}}
    touch $monorepo_name/{.flake8,README.md,poetry.lock,pyproject.toml,dev-requirements.txt,pip-requirements.txt}
    echo "Monorepo structure $monorepo_name created."
}

# Function to create a project structure
create_project() {
    local monorepo_name=$1
    local project_name=$2
    mkdir -p $monorepo_name/projects/$project_name/{.devcontainer,docs,src,tests}
    touch $monorepo_name/projects/$project_name/{Dockerfile,Makefile,poetry.lock,pyproject.toml,run.py,requirements.txt,README.md}
    touch $monorepo_name/projects/$project_name/src/{__init__.py,pipeline.py}
    touch $monorepo_name/projects/$project_name/tests/{__init__.py,test_pipeline.py}
    touch $monorepo_name/projects/$project_name/docs/index.md
    cat <<EOF > $monorepo_name/projects/$project_name/.devcontainer/Dockerfile
# Dockerfile content here
EOF
    cat <<EOF > $monorepo_name/projects/$project_name/.devcontainer/devcontainer.json
{
  // devcontainer.json content here
}
EOF
    echo "Project $project_name structure created in $monorepo_name."
}

# Function to create a library structure
create_lib() {
    local monorepo_name=$1
    local lib_name=$2
    mkdir -p $monorepo_name/lib/$lib_name/{docs,src}
    touch $monorepo_name/lib/$lib_name/{requirements.txt,README.md,poetry.lock,pyproject.toml}
    touch $monorepo_name/lib/$lib_name/src/{__init__.py,base_pipeline.py}
    touch $monorepo_name/lib/$lib_name/docs/index.md
    echo "Library $lib_name structure created in $monorepo_name."
}

# Function to create the docs structure
create_docs() {
    local monorepo_name=$1
    local target=$2
    touch $monorepo_name/$target/docs/index.md
    echo "Docs structure created for $target in $monorepo_name."
}

# Function to parse arguments and call the appropriate functions
main() {
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --create-monorepo) shift; create_monorepo "$1" ;;
            --create-project) shift; create_project "$1" "$2"; shift ;;
            --create-lib) shift; create_lib "$1" "$2"; shift ;;
            --create-docs) shift; create_docs "$1" "$2"; shift ;;
            *) echo "Unknown parameter passed: $1"; exit 1 ;;
        esac
        shift
    done
}

# Call the main function with all the script arguments
main "$@"