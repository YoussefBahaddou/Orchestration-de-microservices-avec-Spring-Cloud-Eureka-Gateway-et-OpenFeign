$projectPath = "C:\DEV\Lechgar\DrissLechgarRepo\SeleniumScripts\downloads\TP-19 ( id 235 )\TP-19-Orchestration-de-microservices-avec-Spring-Cloud-Eureka-Gateway-et-OpenFeign-main"

# Define mappings
$mappings = @(
    @{ OldDir="TP18 Serveur"; NewDir="service-discovery"; NewPkg="com.youssef.microservice.discovery"; AppName="service-discovery"; Port="8761" },
    @{ OldDir="TP18 GateWay"; NewDir="api-gateway"; NewPkg="com.youssef.microservice.gateway"; AppName="api-gateway"; Port="8888" },
    @{ OldDir="TP18 Client"; NewDir="customer-service"; NewPkg="com.youssef.microservice.customer"; AppName="customer-service"; Port="8081" },
    @{ OldDir="TP18 Voiture"; NewDir="car-service"; NewPkg="com.youssef.microservice.car"; AppName="car-service"; Port="8082" }
)

foreach ($map in $mappings) {
    $oldDirPath = "$projectPath\$($map.OldDir)"
    $newDirPath = "$projectPath\$($map.NewDir)"

    Write-Host "Processing $($map.AppName)..."

    # 1. Rename Directory
    if (Test-Path $oldDirPath) {
        Rename-Item -Path $oldDirPath -NewName $map.NewDir -Force
    }

    # 2. Refactor Packages
    $srcJava = "$newDirPath\src\main\java"
    
    # Check for 'ma' directory
    if (Test-Path "$srcJava\ma") {
        $newPkgPath = "$srcJava\$($map.NewPkg.Replace('.', '\'))"
        New-Item -ItemType Directory -Force -Path $newPkgPath | Out-Null
        
        # Move contents: grab everything under src/main/java/ma and move it deep to new Pkg
        # We need to find the root of the source code inside 'ma'
        # Usually ma/project/tp18 or similar. We'll simply move 'ma' contents recursively to new location.
        Get-ChildItem "$srcJava\ma" -Recurse -File | ForEach-Object {
            $destFile = $_.FullName.Replace("$srcJava\ma", $newPkgPath)
            # Adjust path if 'project' or 'tp18' folder structures are in between
            # To be safe, let's just flatten the structure or preserve it?
            # Creating a simple flattening strategy for this specific TP structure usually works best if complex.
            # But let's try to preserve sub-packages if they exist.
            
            # Better strategy: Move everything from `src/main/java/ma/project` (if exists) or just `ma` to new path
            # Assuming `ma/project` is the base based on groupId.
        }
        
        # Simpler approach: Move `ma\project` contents to `newPkgPath`
        if (Test-Path "$srcJava\ma\project") {
             Get-ChildItem "$srcJava\ma\project\*" -Recurse | Move-Item -Destination $newPkgPath -Force
        } elseif (Test-Path "$srcJava\ma") {
             Get-ChildItem "$srcJava\ma\*" -Recurse | Move-Item -Destination $newPkgPath -Force
        }
        
        Remove-Item "$srcJava\ma" -Recurse -Force -ErrorAction SilentlyContinue
    }

    # 3. Content Replacement (Java & Config)
    $files = Get-ChildItem -Path $newDirPath -Recurse -Include "*.java", "*.xml", "*.yml", "*.properties"
    
    foreach ($file in $files) {
        $content = Get-Content $file.FullName -Raw
        
        # Package & Imports
        $content = $content -replace "package ma.project;", "package $($map.NewPkg);"
        $content = $content -replace "package ma.project.tp18;", "package $($map.NewPkg);"
        $content = $content -replace "import ma.project", "import $($map.NewPkg)"
        
        # POM updates
        $content = $content -replace "<groupId>ma.project</groupId>", "<groupId>com.youssef.microservice</groupId>"
        $content = $content -replace "<artifactId>TP18</artifactId>", "<artifactId>$($map.AppName)</artifactId>"
        $content = $content -replace "<name>TP18</name>", "<name>$($map.AppName)</name>"
        
        # Application Props
        $content = $content -replace "spring.application.name=.*", "spring.application.name=$($map.AppName)"
        
        # Entity Renaming (specific to Car/Customer services)
        if ($map.AppName -eq "customer-service" -or $map.AppName -eq "car-service") {
            # Entity class renaming in content
            $content = $content -replace "public class Client", "public class Customer"
            $content = $content -replace "public class Voiture", "public class Car"
            $content = $content -replace "Client ", "Customer " 
            $content = $content -replace "Voiture ", "Car "
            $content = $content -replace "ClientRepository", "CustomerRepository"
            $content = $content -replace "VoitureRepository", "CarRepository"
            
            # Variable names (simple heuristics)
            $content = $content -replace "client", "customer"
            $content = $content -replace "voiture", "car"
        }
        
        Set-Content -Path $file.FullName -Value $content
        
         # Rename Files
        if ($file.Name -eq "Client.java") { Rename-Item $file.FullName "Customer.java" }
        if ($file.Name -eq "Voiture.java") { Rename-Item $file.FullName "Car.java" }
        if ($file.Name -eq "ClientRepository.java") { Rename-Item $file.FullName "CustomerRepository.java" }
        if ($file.Name -eq "VoitureRepository.java") { Rename-Item $file.FullName "CarRepository.java" }
        if ($file.Name -eq "ClientController.java") { Rename-Item $file.FullName "CustomerController.java" }
        if ($file.Name -eq "VoitureController.java") { Rename-Item $file.FullName "CarController.java" }
    }
}

# 4. Create README
$readmeContent = "# Hotel Microservices Architecture

## Overview
A microservices-based system for hotel management using Spring Cloud ecosystem.
Refactored by **Youssef Bahaddou**.

## Services
- **Service Discovery**: Eureka Server (Port 8761)
- **API Gateway**: Spring Cloud Gateway (Port 8888)
- **Customer Service**: Manages customers (Port 8081).
- **Car Service**: Manages cars (Port 8082).

## Architecture
- **Eureka**: Service Registration.
- **OpenFeign**: Inter-service communication.
- **Gateway**: Single entry point.

## Run
Start in order:
1. `service-discovery`
2. `api-gateway`
3. `customer-service` & `car-service`

## Author
Youssef Bahaddou
"
Set-Content -Path "$projectPath\README.md" -Value $readmeContent

Write-Host "TP-19 Refactoring Complete!"
