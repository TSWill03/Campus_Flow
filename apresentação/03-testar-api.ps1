# Signature: dev.tswicolly03

param(
  [string]$ApiUrl = "http://localhost:3333",
  [string]$Email = "demo@example.com",
  [string]$Password = "SenhaDemo123!",
  [switch]$TestFiles,
  [switch]$ShowRaw
)

$ErrorActionPreference = "Stop"

$ApiUrl = $ApiUrl.TrimEnd("/")

function Step($Message) {
  Write-Host ""
  Write-Host "==> $Message" -ForegroundColor Cyan
}

function Ok($Message) {
  Write-Host "OK  $Message" -ForegroundColor Green
}

function Show-SafeJson($Label, $Value) {
  if (-not $ShowRaw) {
    return
  }

  Write-Host ""
  Write-Host $Label -ForegroundColor DarkCyan
  $Value | ConvertTo-Json -Depth 20 | Write-Host
}

function Invoke-CampusJson {
  param(
    [Parameter(Mandatory = $true)][string]$Method,
    [Parameter(Mandatory = $true)][string]$Path,
    [object]$Body = $null,
    [string]$Token = ""
  )

  $Headers = @{}
  if ($Token) {
    $Headers["Authorization"] = "Bearer $Token"
  }

  $Params = @{
    Uri = "$ApiUrl$Path"
    Method = $Method
    Headers = $Headers
  }

  if ($null -ne $Body) {
    $Params["ContentType"] = "application/json"
    $Params["Body"] = ($Body | ConvertTo-Json -Depth 20)
  }

  Invoke-RestMethod @Params
}

function Invoke-CampusFileUpload {
  param(
    [Parameter(Mandatory = $true)][string]$Token,
    [Parameter(Mandatory = $true)][string]$EntityId
  )

  Add-Type -AssemblyName System.Net.Http

  $TempFile = Join-Path ([System.IO.Path]::GetTempPath()) "campusflow-api-demo.txt"
  Set-Content -LiteralPath $TempFile -Value "CampusFlow API demo $(Get-Date -Format o)" -Encoding UTF8

  $Client = [System.Net.Http.HttpClient]::new()
  $Form = $null
  $Stream = $null
  $FileContent = $null

  try {
    $Client.DefaultRequestHeaders.Authorization =
      [System.Net.Http.Headers.AuthenticationHeaderValue]::new("Bearer", $Token)

    $Form = [System.Net.Http.MultipartFormDataContent]::new()
    $Stream = [System.IO.File]::OpenRead($TempFile)
    $FileContent = [System.Net.Http.StreamContent]::new($Stream)
    $FileContent.Headers.ContentType =
      [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse("text/plain")

    $Form.Add($FileContent, "file", "campusflow-api-demo.txt")
    $Form.Add([System.Net.Http.StringContent]::new("presentation_check"), "entityType")
    $Form.Add([System.Net.Http.StringContent]::new($EntityId), "entityId")
    $Form.Add([System.Net.Http.StringContent]::new("demo"), "category")

    $Response = $Client.PostAsync("$ApiUrl/files/upload", $Form).GetAwaiter().GetResult()
    $Text = $Response.Content.ReadAsStringAsync().GetAwaiter().GetResult()

    if (-not $Response.IsSuccessStatusCode) {
      throw "Upload failed with HTTP $([int]$Response.StatusCode): $Text"
    }

    $Text | ConvertFrom-Json
  } finally {
    if ($FileContent) { $FileContent.Dispose() }
    if ($Stream) { $Stream.Dispose() }
    if ($Form) { $Form.Dispose() }
    if ($Client) { $Client.Dispose() }
    Remove-Item -LiteralPath $TempFile -ErrorAction SilentlyContinue
  }
}

try {
  Step "Health"
  $Health = Invoke-RestMethod "$ApiUrl/health"
  Ok "/health respondeu"
  Show-SafeJson "health" $Health

  Step "Readiness"
  $Ready = Invoke-RestMethod "$ApiUrl/ready"
  Ok "/ready respondeu"
  Show-SafeJson "ready" $Ready

  Step "Login demo"
  $Login = Invoke-CampusJson -Method "Post" -Path "/auth/login" -Body @{
    email = $Email
    password = $Password
  }

  $AccessToken = $Login.tokens.accessToken
  $RefreshToken = $Login.tokens.refreshToken
  Ok "login como $($Login.user.email)"
  Show-SafeJson "login sem tokens" ([ordered]@{
    user = $Login.user
    tokens = @{
      accessToken = "(oculto)"
      refreshToken = "(oculto)"
      expiresIn = $Login.tokens.expiresIn
    }
  })

  Step "Usuario autenticado"
  $Me = Invoke-CampusJson -Method "Get" -Path "/auth/me" -Token $AccessToken
  Ok "/auth/me retornou $($Me.user.email)"
  Show-SafeJson "me" $Me

  Step "Sync push"
  $LocalId = "api-demo-$((Get-Date).ToString("yyyyMMddHHmmss"))"
  $Push = Invoke-CampusJson -Method "Post" -Path "/sync/push" -Token $AccessToken -Body @{
    clientId = "apresentacao-terminal"
    deviceName = "Terminal da apresentacao"
    changes = @(
      @{
        entityType = "presentation_check"
        localId = $LocalId
        isDeleted = $false
        updatedAt = (Get-Date).ToString("o")
        payload = @{
          title = "Teste de API"
          source = "apresentacao"
          createdAt = (Get-Date).ToString("o")
        }
      }
    )
  }
  Ok "/sync/push aceitou $($Push.results.Count) mudanca(s)"
  Show-SafeJson "sync push" $Push

  Step "Sync pull"
  $Pull = Invoke-CampusJson -Method "Get" -Path "/sync/pull?limit=10" -Token $AccessToken
  Ok "/sync/pull retornou $($Pull.changes.Count) mudanca(s)"
  Show-SafeJson "sync pull" $Pull

  if ($TestFiles) {
    Step "Files upload"
    $Upload = Invoke-CampusFileUpload -Token $AccessToken -EntityId $LocalId
    $FileId = $Upload.file.id
    Ok "/files/upload criou arquivo $FileId"
    Show-SafeJson "file upload" $Upload

    Step "Files list"
    $EncodedEntityId = [uri]::EscapeDataString($LocalId)
    $Files = Invoke-CampusJson -Method "Get" -Path "/files?entityType=presentation_check&entityId=$EncodedEntityId" -Token $AccessToken
    Ok "/files listou $($Files.files.Count) arquivo(s)"
    Show-SafeJson "files" $Files

    Step "Files delete"
    $Delete = Invoke-CampusJson -Method "Delete" -Path "/files/$FileId" -Token $AccessToken
    Ok "/files/$FileId marcou exclusao logica"
    Show-SafeJson "file delete" $Delete
  }

  Step "Refresh token"
  $Refresh = Invoke-CampusJson -Method "Post" -Path "/auth/refresh" -Body @{
    refreshToken = $RefreshToken
  }
  $RefreshToken = $Refresh.tokens.refreshToken
  Ok "/auth/refresh emitiu novo access token"
  Show-SafeJson "refresh sem tokens" ([ordered]@{
    user = $Refresh.user
    tokens = @{
      accessToken = "(oculto)"
      refreshToken = "(oculto)"
      expiresIn = $Refresh.tokens.expiresIn
    }
  })

  Step "Logout"
  $Logout = Invoke-CampusJson -Method "Post" -Path "/auth/logout" -Body @{
    refreshToken = $RefreshToken
  }
  Ok "/auth/logout revogou refresh token"
  Show-SafeJson "logout" $Logout

  Write-Host ""
  Write-Host "API demo completed successfully." -ForegroundColor Green
} catch {
  Write-Host ""
  Write-Host "API demo failed at $ApiUrl." -ForegroundColor Red
  Write-Host "Se estiver usando API local, rode: .\apresentação\01-subir-backend.ps1 -SeedDemo" -ForegroundColor Yellow
  throw
}

