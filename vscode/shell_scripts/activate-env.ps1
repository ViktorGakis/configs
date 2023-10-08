# activate-env.ps1
$condaPath = $env:CONDA_PATH
$envPath = $env:CONDA_ENV_PATH
& "$condaPath\shell\condabin\conda-hook.ps1"
conda activate $envPath

Write-Host "Conda Path: $condaPath"
Write-Host "Env Path: $envpath"
