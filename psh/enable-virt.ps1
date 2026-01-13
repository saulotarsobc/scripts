# Habilitar recursos do Windows para Docker Desktop com WSL2
# Execute no PowerShell "Como Administrador"

# --- Funções utilitárias ---
function Enable-FeatureSafe {
    param([Parameter(Mandatory)][string]$Name)
    try {
        $res = Enable-WindowsOptionalFeature -Online -FeatureName $Name -All -NoRestart -ErrorAction Stop
        Write-Host "✓ $Name -> $(if ($res.RestartNeeded) { 'requer reinício' } else { 'ok' })" -ForegroundColor Green
    }
    catch {
        Write-Warning "Falhou ao habilitar ${Name}: $($_.Exception.Message)"
    }
}

# --- Checagens rápidas ---
$edition = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').EditionID
Write-Host "Edição do Windows: $edition" -ForegroundColor Cyan

# Virtualização no host (melhor já estar ligada na BIOS/UEFI)
$virt = (Get-CimInstance Win32_ComputerSystem).HypervisorPresent
Write-Host ("Hypervisor presente: " + $(if ($virt) { "Sim" } else { "Não (ok se só WSL2)" })) -ForegroundColor Cyan

# --- WSL2 e plataforma de VM (sempre) ---
Enable-FeatureSafe -Name "Microsoft-Windows-Subsystem-Linux"
Enable-FeatureSafe -Name "VirtualMachinePlatform"

# Recomendada para compatibilidade (WHP)
Enable-FeatureSafe -Name "HypervisorPlatform"

# Suporte a Containers (útil em alguns cenários do Docker)
Enable-FeatureSafe -Name "Containers"

# --- Hyper-V (opcional; não ativa no Home) ---
if ($edition -notmatch 'Core|Home') {
    Enable-FeatureSafe -Name "Microsoft-Hyper-V-All"
}
else {
    Write-Host "PULANDO Hyper-V (edição Home). Docker com WSL2 funciona normal." -ForegroundColor Yellow
}

# --- WSL2 como padrão ---
try {
    wsl --set-default-version 2
    Write-Host "WSL default = 2" -ForegroundColor Green
}
catch {
    Write-Warning "Não consegui definir WSL2. Após reiniciar, rode:  wsl --set-default-version 2"
}

# (Opcional) instalar uma distro específica (descomente se quiser)
# wsl --install -d Ubuntu

Write-Host "`n→ Agora REINICIE o computador (shutdown /r /t 0). Após o reboot, instale o Docker Desktop (winget abaixo opcional)." -ForegroundColor Cyan
Write-Host "Comando opcional pós-reboot:  winget install -e --id Docker.DockerDesktop" -ForegroundColor DarkCyan
