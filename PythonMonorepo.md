# Python Mono Repo

## Structure

Creating and managing a Python monorepo involves consolidating various Python projects into a single repository. This approach unifies version control, dependency management, and testing frameworks across multiple projects. This guide explores how to set up and manage a Python monorepo effectively.

### Step 1: Setting up the monorepo structure

```sh
python-monorepo
├── .flake8
├── README.md
├── poetry.lock
├── pyproject.toml
├── dev-requirements.txt
├── pip-requirements.txt
├── projects
│   ├── project-a
│   │   ├── .devcontainer
│   │   │   ├── Dockerfile
│   │   │   └── devcontainer.json
│   │   ├── Dockerfile
│   │   ├── Makefile
│   │   ├── poetry.lock
│   │   ├── pyproject.toml
│   │   ├── run.py
│   │   ├── requirements.txt
│   │   ├── README.md 
│   │   ├── docs
│   │   │   ├── index.md
│   │   ├── src
│   │   │   ├── __init__.py
│   │   │   └── pipeline.py
│   │   └── tests
│   │       ├── __init__.py
│   │       └── test_pipeline.py
│   └── project-b
│       ├── requirements.txt
│       ├── README.md 
│       ├── docs
│       │   ├── index.md
│       ├── src
│       │   └── __init__.py
│       └── tests
│           └── __init__.py
└── lib
    ├── lib1
    │   ├── requirements.txt
    │   ├── README.md 
    │   ├── src
    │   │   ├── __init__.py
    │   │   └── base_pipeline.py
    │   ├── docs
    │   │   ├── index.md
    │   ├── poetry.lock
    │   └── pyproject.toml
    └── lib2
        ├── requirements.txt
        ├── README.md 
        ├── src
        │   ├── __init__.py
        │   └── calc.py
        ├── docs
        │   ├── index.md 
        ├── poetry.lock
        └── pyproject.toml
└── docs
    ├── index.md 
└── scripts
    ├── requirements.txt
    ├── README.md 
    ├── common-scripts 
    │   ├── __init__.py
    │   └── base_pipeline.py
    ├── shell-scripts 
    │   ├── doc
    │   │   ├── index.md
    │   └── base_pipeline.sh    
    ├── poetry.lock
    └── pyproject.toml 
```

### Step 2: Virtual environments

Use virtual environments to isolate project-specific dependencies.

Virtual environments in Python are isolated spaces that allow you to manage project-specific dependencies separately from the global Python environment. This isolation prevents conflicts between project requirements and allows each project to maintain its own set of dependencies and Python versions.

The `venv` module, which is part of Python's standard library, provides a straightforward way to create these isolated environments.

```sh
# Creating a virtual environment for project1
python3 -m venv .venv
source .venv/bin/activate
```

Dependency isolation with Pants or Poetry: Tools like Pants or Poetry can help manage dependencies in a monorepo setting.

**We will go with Pants.**

- Pants: Handles dependencies at a fine-grained level, allowing for precise control and minimal rebuilds.
  
```sh
# Example of a Pants BUILD file
python_library(
    name="project1_lib",
    dependencies=[
        "//shared/src",
    ],
    sources=["src/**/*.py"],
)
```

- Poetry: Manages dependencies and packaging of Python projects. You can set up a `pyproject.toml` for each project to define its dependencies.
  
```sh
# Using Poetry in project1
cd my-monorepo/project1
poetry init
poetry add requests
```

### Step 3: Centralized testing

Using pytest: Configure pytest to run tests for each project separately or across the entire monorepo. You can use pytest's configuration file to customize test behaviors.

```sh
# Running tests in project1
cd my-monorepo/project1
pytest tests/
```

Continuous integration (CI): Set up a CI pipeline using tools like Jenkins, GitHub Actions, or GitLab CI. Define pipeline steps that install dependencies, run tests, and check code quality for each project independently or for the entire monorepo based on the changes detected.

```yaml
# Example GitHub Actions workflow for a Python monorepo
name: Python Monorepo CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        project: [project1, project2]
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.8'
      - name: Install dependencies
        run: |
          cd ${{ matrix.project }}
          poetry install
      - name: Run tests
        run: |
          cd ${{ matrix.project }}
          pytest tests/
```

### Step 4: Documentation

Maintain a central documentation hub in your monorepo that provides guidelines, project descriptions, and setup instructions. Tools like MkDocs or Sphinx can be used to generate and manage project documentation.

```sh
# Setting up MkDocs
pip install mkdocs
mkdocs new my-monorepo/docs
# Add documentation files and then build the site
mkdocs build
```