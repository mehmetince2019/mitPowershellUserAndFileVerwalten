# Buchhaltung ve Verwaltung için grup adları
$groupBuchhaltung = "Buchhaltung"
$groupVerwaltung = "Verwaltung"

# C:\Datei dizini ve alt klasörlerin yolları
$dateiPath = "C:\Datei"
$buchhaltungPath = "$dateiPath\Buchhaltung"
$verwaltungPath = "$dateiPath\Verwaltung"

# C:\Datei dizinini oluştur
if (-not (Test-Path $dateiPath)) {
    New-Item -Path $dateiPath -ItemType Directory
    Write-Host "Datei klasörü oluşturuldu: $dateiPath"
} else {
    Write-Host "Datei klasörü zaten mevcut: $dateiPath"
}

# Buchhaltung klasörünü oluştur
if (-not (Test-Path $buchhaltungPath)) {
    New-Item -Path $buchhaltungPath -ItemType Directory
    Write-Host "Buchhaltung klasörü oluşturuldu: $buchhaltungPath"
} else {
    Write-Host "Buchhaltung klasörü zaten mevcut: $buchhaltungPath"
}

# Verwaltung klasörünü oluştur
if (-not (Test-Path $verwaltungPath)) {
    New-Item -Path $verwaltungPath -ItemType Directory
    Write-Host "Verwaltung klasörü oluşturuldu: $verwaltungPath"
} else {
    Write-Host "Verwaltung klasörü zaten mevcut: $verwaltungPath"
}

# Buchhaltung klasörü için yetkilendirme
Write-Host "Buchhaltung klasörü için yetkiler ayarlanıyor..." -ForegroundColor Cyan
icacls $buchhaltungPath /grant "$groupBuchhaltung:(OI)(CI)F"  # Buchhaltung grubu için tam erişim
icacls $buchhaltungPath /grant "$groupVerwaltung:(OI)(CI)R"   # Verwaltung grubu için sadece okuma erişimi

# Verwaltung klasörü için yetkilendirme
Write-Host "Verwaltung klasörü için yetkiler ayarlanıyor..." -ForegroundColor Cyan
icacls $verwaltungPath /grant "$groupVerwaltung:(OI)(CI)F"    # Verwaltung grubu için tam erişim
icacls $verwaltungPath /grant "$groupBuchhaltung:(OI)(CI)R"   # Buchhaltung grubu için sadece okuma izni

Write-Host "Klasör yetkilendirmeleri başarıyla tamamlandı!" -ForegroundColor Green
