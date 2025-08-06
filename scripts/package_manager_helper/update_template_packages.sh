#!/bin/bash

set -euo pipefail

DEPENDENCIES=("pandas")
DEV_DEPENDENCIES=("bandit" "pytest" "pytest-xdist" "ruff" "pytest-cov")
TEMPLATE_DIR="../../project_template"

# Function to handle package installation and file copying
handle_package_manager() {
    # If locally developing, comment this git restore line out
    # this pulls the package manager files from the template
    git restore Pipfile pyproject.toml
    rm -f Pipfile.lock poetry.lock

    local package_manager=$1
    # Determine prefix based on copier
    dev_deps=("${DEV_DEPENDENCIES[@]}")
    deps=("${DEPENDENCIES[@]}")

    # Install development dependencies
    if [[ "${package_manager}" == "poetry" ]]; then
        poetry add "${dev_deps[@]}" --group dev
        poetry add "${deps[@]}"
    elif [[ "${package_manager}" == "pipenv" ]]; then
        pipenv install "${dev_deps[@]}" --dev
        pipenv install "${deps[@]}"
    fi

    # Copy lock files to the project_template
    if [[ "${package_manager}" == "poetry" ]]; then
        cp -p poetry.lock "${TEMPLATE_DIR}/\${{ 'poetry.lock' if values.package_manager == 'poetry' }}.njk"
        cp -p pyproject.toml "${TEMPLATE_DIR}/\${{ 'pyproject.toml' if values.package_manager == 'poetry' }}.njk"
    elif [[ "${package_manager}" == "pipenv" ]]; then
        cp -p Pipfile.lock "${TEMPLATE_DIR}/\${{ 'Pipfile.lock' if values.package_manager == 'pipenv' }}.njk"
        cp -p Pipfile "${TEMPLATE_DIR}/\${{ 'Pipfile' if values.package_manager == 'pipenv' }}.njk"
    fi

    echo "Copied lock files for ${package_manager}"
}

# Execute the function with different configurations
handle_package_manager poetry
handle_package_manager pipenv

# Undo git changes and remove the lock files
git restore Pipfile pyproject.toml
rm -f Pipfile.lock poetry.lock
