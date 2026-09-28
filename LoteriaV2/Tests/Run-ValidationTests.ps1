$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$websiteRoot = Join-Path $projectRoot 'LoteriaV2'
$compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
$testExe = Join-Path $env:TEMP ('LoteriaV2-validation-tests-' + [guid]::NewGuid().ToString('N') + '.exe')

if (-not (Test-Path -LiteralPath $compiler)) {
    throw "The .NET Framework C# compiler was not found at $compiler."
}

try {
    & $compiler /nologo /target:exe "/out:$testExe" `
        (Join-Path $PSScriptRoot 'ValidationTests.cs') `
        (Join-Path $websiteRoot 'App_Code\GameInputValidator.cs') `
        (Join-Path $websiteRoot 'App_Code\SessionAuthorization.cs')
    if ($LASTEXITCODE -ne 0) {
        throw "Validation test compilation failed with exit code $LASTEXITCODE."
    }

    & $testExe
    if ($LASTEXITCODE -ne 0) {
        throw "Validation tests failed with exit code $LASTEXITCODE."
    }
}
finally {
    if (Test-Path -LiteralPath $testExe) {
        Remove-Item -LiteralPath $testExe -Force
    }
}
