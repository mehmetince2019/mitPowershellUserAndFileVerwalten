# Buchhaltung ve Verwaltung için grup adları
$groupBuchhaltung = "Buchhaltung"
$groupVerwaltung = "Verwaltung"

# Kullanıcının OneDrive yolu
$onedrivePath = "$env:USERPROFILE\OneDrive1"

# Klasörlerin yolları
$buchhaltungPath = "$onedrivePath\Buchhaltung"
$verwaltungPath = "$onedrivePath\Verwaltung"

# OneDrive klasörlerini oluştur
if (-not (Test-Path $buchhaltungPath)) {
    New-Item -Path $buchhaltungPath -ItemType Directory
    Write-Host "Buchhaltung klasörü oluşturuldu: $buchhaltungPath"
}

if (-not (Test-Path $verwaltungPath)) {
    New-Item -Path $verwaltungPath -ItemType Directory
    Write-Host "Verwaltung klasörü oluşturuldu: $verwaltungPath"
}

# Buchhaltung klasörü için yetkilendirme
Write-Host "Buchhaltung klasörü için yetkiler ayarlanıyor..." -ForegroundColor Cyan
icacls $buchhaltungPath /grant "${groupBuchhaltung}:(OI)(CI)F"    # Buchhaltung grubu için tam erişim
icacls $buchhaltungPath /grant "${groupVerwaltung}:(OI)(CI)R"      # Verwaltung grubu için sadece okuma erişimi

# Verwaltung klasörü için yetkilendirme
Write-Host "Verwaltung klasörü için yetkiler ayarlanıyor..." -ForegroundColor Cyan
icacls $verwaltungPath /grant "${groupVerwaltung}:(OI)(CI)F"       # Verwaltung grubu için tam erişim
icacls $verwaltungPath /grant "${groupBuchhaltung}:(OI)(CI)R"      # Buchhaltung grubu için sadece okuma izni

Write-Host "Klasör yetkilendirmeleri başarıyla tamamlandı!" -ForegroundColor Green
