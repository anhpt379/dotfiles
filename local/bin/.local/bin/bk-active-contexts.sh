#!/bin/bash

# Script: bk-active-contexts.sh
# Purpose: Check for active Kubernetes contexts for a given project across all
# clusters
# Usage: ./bk-active-contexts.sh <project-name>

# Exit on any error
set -e

# Validate command line arguments
if [ $# -ne 1 ]; then
  echo "Usage: $0 <sd-project-name>"
  echo "Example: $0 sd-project-name"
  exit 1
fi

# Configuration
readonly PROJECT_NAME="$1"
readonly DEFAULT_USER="bplatform-default"

# Get all available Kubernetes clusters (skip header line)
readonly ALL_CLUSTERS=$(kubectl config get-clusters | awk 'NR>1 {print $1}')

# Function: Check if a namespace in a given context has any running pods
# Parameters:
#   $1 - cluster name
# Returns: Context name if empty (no pods), nothing otherwise
check_if_namespace_empty() {
  local cluster_name=$1
  local cluster_short_name="${cluster_name#bplatform-}"  # Remove bplatform- prefix
  local context_name="${PROJECT_NAME}-${cluster_short_name}"

  local pod_count=$(kubectl --context="$context_name" get pods --no-headers 2>/dev/null | wc -l)

  if [ "$pod_count" -eq 0 ]; then
    echo "$context_name"
  fi
}

# Function: Create a Kubernetes context for the given cluster
# Parameters:
#   $1 - cluster name
create_context_for_cluster() {
  local cluster_name=$1
  local cluster_short_name="${cluster_name#bplatform-}"  # Remove bplatform- prefix
  local context_name="${PROJECT_NAME}-${cluster_short_name}"

  kubectl config set-context "$context_name" \
    --cluster="$cluster_name" \
    --namespace="$PROJECT_NAME" \
    --user="$DEFAULT_USER"
}

ensure_active_context() {
  if ! kubectl config current-context &>/dev/null; then
    # Get the last available context from the list
    local fallback_context=$(kubectl config get-contexts --no-headers | tail -1 | awk '{print $1}')

    if [ -n "$fallback_context" ]; then
      echo "No active context found. Setting context to: $fallback_context"
      kubectl config use-context "$fallback_context"
    else
      echo "Warning: No contexts available to set as active"
    fi
  fi
}

# Main execution
echo "Project: $PROJECT_NAME"
echo "User: $DEFAULT_USER"
echo ""

# Step 1: Create contexts for all clusters
echo "Creating contexts for all clusters..."
for cluster in $ALL_CLUSTERS; do
  create_context_for_cluster "$cluster"
done
echo ""

# Step 2: Export required variables and functions for parallel execution
export PROJECT_NAME
export -f check_if_namespace_empty

# Step 3: Check for empty namespaces in parallel
echo "Checking for namespaces with no running pods..."
EMPTY_CONTEXTS=$(
  echo "$ALL_CLUSTERS" | tr ' ' '\n' |
    xargs -P 32 -I {} bash -c 'check_if_namespace_empty "{}"'
)

# Step 4: Delete contexts with empty namespaces
if [ -n "$EMPTY_CONTEXTS" ]; then
  echo ""
  echo "Found empty namespaces. Removing associated contexts..."

  while IFS= read -r context; do
    if [ -n "$context" ]; then
      kubectl config delete-context "$context"
    fi
  done <<<"$EMPTY_CONTEXTS"
fi

# Step 5: Ensure we have an active context
echo ""
ensure_active_context
