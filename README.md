# Data Developer IDP GitOps Repository

This repository contains the configuration for the Data Developer Internal Development Platform (IDP), which is deployed to a Kubernetes cluster using ArgoCD and powered by Backstage.

## Structure

- `apps/`: ArgoCD Application definitions for deploying core services (like Backstage).
- `charts/`: Helm charts for deploying services.
- `environments/`: Environment-specific configuration overlays (e.g., `dev`, `prod`).
- `backstage/`: Configuration files for the Backstage instance (e.g., `app-config.yaml`).
- `data-services/`: Catalog definitions and templates for data pipelines and services.
