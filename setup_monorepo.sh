#!/bin/bash

# Create the monorepo structure
mkdir -p python-monorepo/{.devcontainer,projects/{project-a,project-b},lib/{lib1,lib2},docs,scripts/{common-scripts,shell-scripts}}

# Create common files
touch python-monorepo/{.flake8,README.md,poetry.lock,pyproject.toml,dev-requirements.txt,pip-requirements.txt}

# Create project-a structure
mkdir -p python-monorepo/projects/project-a/{.devcontainer,docs,src,tests}
touch python-monorepo/projects/project-a/{Dockerfile,Makefile,poetry.lock,pyproject.toml,run.py,requirements.txt,README.md}
touch python-monorepo/projects/project-a/src/{__init__.py,pipeline.py}
touch python-monorepo/projects/project-a/tests/{__init__.py,test_pipeline.py}
touch python-monorepo/projects/project-a/docs/index.md
cat <<EOF > python-monorepo/projects/project-a/.devcontainer/Dockerfile
# Dockerfile content here
EOF
cat <<EOF > python-monorepo/projects/project-a/.devcontainer/devcontainer.json
{
  // devcontainer.json content here
}
EOF

# Create project-b structure
mkdir -p python-monorepo/projects/project-b/{docs,src,tests}
touch python-monorepo/projects/project-b/{requirements.txt,README.md}
touch python-monorepo/projects/project-b/src/__init__.py
touch python-monorepo/projects/project-b/tests/__init__.py
touch python-monorepo/projects/project-b/docs/index.md

# Create lib1 structure
mkdir -p python-monorepo/lib/lib1/{docs,src}
touch python-monorepo/lib/lib1/{requirements.txt,README.md,poetry.lock,pyproject.toml}
touch python-monorepo/lib/lib1/src/{__init__.py,base_pipeline.py}
touch python-monorepo/lib/lib1/docs/index.md

# Create lib2 structure
mkdir -p python-monorepo/lib/lib2/{docs,src}
touch python-monorepo/lib/lib2/{requirements.txt,README.md,poetry.lock,pyproject.toml}
touch python-monorepo/lib/lib2/src/{__init__.py,calc.py}
touch python-monorepo/lib/lib2/docs/index.md

# Create docs structure
touch python-monorepo/docs/index.md

# Create scripts structure
mkdir -p python-monorepo/scripts/{common-scripts,shell-scripts}
touch python-monorepo/scripts/{requirements.txt,README.md,poetry.lock,pyproject.toml}
touch python-monorepo/scripts/common-scripts/{__init__.py,base_pipeline.py}
mkdir -p python-monorepo/scripts/shell-scripts/doc
touch python-monorepo/scripts/shell-scripts/{base_pipeline.sh,doc/index.md}

echo "Python monorepo structure created successfully."
