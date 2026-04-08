# Container for GPU accelerated 3D Slicer and SlicerMorph
Anthony Lee 2026-01-30

This container is used to run 3D Slicer and SlicerMorph in a Apptainer through TurboVNC on UW Tillicum.
It uses VirtualGL + TurboVNC to accelerate the graphics rendering using VirtualGL's EGL backend.

The EGL backend uses DRI (Direct Rendering Infrastructure) instead of the GLX backend that uses an X server and could be challenging to setup if one does not have admin access to the system. Even though EGL backend allows simultaneous jobs on the same node, each using their own device for rendering, it can fail for some applications.

## How to build the container
```bash
apptainer build --disable-cache <container_name.sif> <recipe_name.def>
```

Or

```bash
apptainer build <container_name.sif> <recipe_name.def>
apptainer cache clean --force
```

## How to run the container
Run the following to get started: 
```bash
apptainer run <container_name.sif>
```

Or, get further help documents by running
```bash
apptainer run-help <container_name.sif>
```
