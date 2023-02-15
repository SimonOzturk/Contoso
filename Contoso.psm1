
# Command: Get-DiskInformation
function Get-DiskInformation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]$ComputerName = "localhost",
        [Parameter(Mandatory = $false)]$LogFileName = "$($Root)\Logs\$(Get-Date -Format "yyyy-MM-dd")-Disk-Information.csv"
    )
    
    begin {
        $Root = Split-Path (Get-Module -Name "Contoso").Path
        $Settings = Get-Content "$($Root)\Settings.json" | ConvertFrom-Json
    }
    
    process {
        try {
            $Disk = [Disk]::new($ComputerName)
            Write-Output $Disk
        }
        catch {
        }
        finally {
            
        }  
    }
    
    end {
        
    }
}

# Class: Workstation
class Workstation {
    Workstation($ComputerName) {
        $this.Computer = [Computer]::new($ComputerName)
        $this.OperatingSystem = [OperatingSystem]::new($ComputerName)
        $this.Disk = [Disk]::new($ComputerName)
        $this.Processor = [Processor]::new($ComputerName)
        $this.VideoController = [VideoController]::new($ComputerName)
        $this.Bios = [Bios]::new($ComputerName)
    }
    [Computer]$Computer
    [OperatingSystem]$OperatingSystem
    [Disk]$Disk
    [Processor[]]$Processor
    [VideoController[]]$VideoController
    [Bios]$Bios
}
class Computer {
    Computer($ComputerName) {
        $CIM = Get-CimInstance -ClassName CIM_ComputerSystem -ComputerName $ComputerName
        $this.Name = $CIM.Name
        $this.Domain = $CIM.Domain
        $this.Model = $CIM.Model
        $this.Manufacturer = $CIM.Manufacturer
    }
    [string]$Name
    [string]$Domain
    [string]$Model
    [string]$Manufacturer
}
class OperatingSystem {
    OperatingSystem($ComputerName) {
        $CIM = Get-CimInstance -ClassName CIM_OperatingSystem -ComputerName $ComputerName
        $this.Name = $CIM.Name
        $this.Caption = $CIM.Caption
        $this.Version = $CIM.Version
        $this.Architecture = $CIM.OSArchitecture
        $this.Language = $CIM.OperatingSystemLanguage
        $this.Build = $CIM.BuildNumber
        $this.BuildType = $CIM.BuildType
        $this.InstallDate = $CIM.InstallDate
    }
    [string]$Name
    [string]$Caption
    [string]$Version
    [string]$Architecture
    [string]$Language
    [string]$Build
    [string]$BuildType
    [string]$InstallDate
}
class Processor {
    Processor($ComputerName) {
        $CIM = Get-CimInstance -ClassName CIM_Processor -ComputerName $ComputerName
        $this.Name = $CIM.Name
        $this.DeviceID = $CIM.DeviceID
        $this.Manufacturer = $CIM.Manufacturer
        $this.MaxClockSpeed = $CIM.MaxClockSpeed
        $this.NumberOfCores = $CIM.NumberOfCores
        $this.NumberOfLogicalProcessors = $CIM.NumberOfLogicalProcessors
        $this.ProcessorType = $CIM.ProcessorType
        $this.SocketDesignation = $CIM.SocketDesignation
        $this.Status = $CIM.Status
    }
    [string]$Name
    [string]$DeviceID
    [string]$Manufacturer
    [string]$MaxClockSpeed
    [string]$NumberOfCores
    [string]$NumberOfLogicalProcessors
    [string]$ProcessorType
    [string]$SocketDesignation
    [string]$Status
}
class VideoController {
    VideoController($ComputerName) {
        $CIM = Get-CimInstance -ClassName CIM_VideoController -ComputerName $ComputerName
        $this.Name = $CIM.Name
        $this.DeviceID = $CIM.DeviceID
        $this.AdapterRAM = $CIM.AdapterRAM
        $this.AdapterCompatibility = $CIM.AdapterCompatibility
        $this.AdapterDACType = $CIM.AdapterDACType
        $this.CurrentHorizontalResolution = $CIM.CurrentHorizontalResolution
        $this.CurrentVerticalResolution = $CIM.CurrentVerticalResolution
        $this.CurrentNumberOfColors = $CIM.CurrentNumberOfColors
        $this.CurrentRefreshRate = $CIM.CurrentRefreshRate
        $this.CurrentBitsPerPixel = $CIM.CurrentBitsPerPixel
        $this.VideoArchitecture = $CIM.VideoArchitecture
        $this.VideoMemoryType = $CIM.VideoMemoryType
        $this.VideoModeDescription = $CIM.VideoModeDescription
        $this.VideoProcessor = $CIM.VideoProcessor
    }
    [string]$Name
    [string]$DeviceID
    [string]$AdapterRAM
    [string]$AdapterCompatibility
    [string]$AdapterDACType
    [string]$CurrentHorizontalResolution
    [string]$CurrentVerticalResolution
    [string]$CurrentNumberOfColors
    [string]$CurrentRefreshRate
    [string]$CurrentBitsPerPixel
    [string]$VideoArchitecture
    [string]$VideoMemoryType
    [string]$VideoModeDescription
    [string]$VideoProcessor
}
class Bios {
    Bios($ComputerName) {
        $CIM = Get-CimInstance -ClassName Win32_BIOS -ComputerName $ComputerName
        $this.Name = $CIM.Name
        $this.Caption = $CIM.Caption
        $this.Description = $CIM.Description
        $this.Manufacturer = $CIM.Manufacturer
        $this.SerialNumber = $CIM.SerialNumber
        $this.Version = $CIM.Version
        $this.ReleaseDate = $CIM.ReleaseDate
        $this.SMBIOSBIOSVersion = $CIM.SMBIOSBIOSVersion
        $this.SMBIOSMajorVersion = $CIM.SMBIOSMajorVersion
        $this.SMBIOSMinorVersion = $CIM.SMBIOSMinorVersion
        $this.SMBIOSPresent = $CIM.SMBIOSPresent
        $this.SystemBiosMajorVersion = $CIM.SystemBiosMajorVersion
        $this.SystemBiosMinorVersion = $CIM.SystemBiosMinorVersion
    }
    [string]$Name
    [string]$Caption
    [string]$Description
    [string]$Manufacturer
    [string]$SerialNumber
    [string]$Version
    [string]$ReleaseDate
    [string]$SMBIOSBIOSVersion
    [string]$SMBIOSMajorVersion
    [string]$SMBIOSMinorVersion
    [string]$SMBIOSPresent
    [string]$SystemBiosMajorVersion
    [string]$SystemBiosMinorVersion
}
class Disk {
    Disk($ComputerName) {
        $this.Drives = @()
        $this.Partitions = @()
        $this.LogicalDisks = @()

        $CIM_DiskDrives = Get-CimInstance -ClassName CIM_DiskDrive -ComputerName $ComputerName
        $CIM_DiskPartition = Get-CimInstance -ClassName CIM_DiskPartition -ComputerName $ComputerName
        $CIM_LogicalDisk = Get-CimInstance -ClassName CIM_LogicalDisk -ComputerName $ComputerName

        foreach ($Drive in $CIM_DiskDrives) {
            $this.Drives += [DiskDrive]::new($Drive)
        }
        foreach ($Partition in $CIM_DiskPartition) {
            $this.Partitions += [DiskPartition]::new($Partition)
        }
        foreach ($LogicalDisk in $CIM_LogicalDisk) {
            $this.LogicalDisks += [LogicalDisk]::new($LogicalDisk)
        }
    }
    [DiskDrive[]]$Drives
    [DiskPartition[]]$Partitions
    [LogicalDisk[]]$LogicalDisks
}
class DiskDrive {
    DiskDrive($CIM) {
        $this.DeviceID = $CIM.DeviceID
        $this.Name = $CIM.Name
        $this.Model = $CIM.Model
        $this.Manufacturer = $CIM.Manufacturer
        $this.SerialNumber = $CIM.SerialNumber
        $this.Size = $CIM.Size
        $this.MediaType = $CIM.MediaType
        $this.InterfaceType = $CIM.InterfaceType
        $this.Partitions = $CIM.Partitions
    }
    [string]$DeviceID
    [string]$Name
    [string]$Model
    [string]$Manufacturer
    [string]$SerialNumber
    [string]$Size
    [string]$MediaType
    [string]$InterfaceType
    [string]$Partitions
}
class DiskPartition {
    DiskPartition($CIM) {
        $this.DeviceID = $CIM.DeviceID
        $this.Name = $CIM.Name
        $this.DriveLetter = $CIM.DriveLetter
        $this.Size = $CIM.Size
        $this.FileSystem = $CIM.FileSystem
        $this.FreeSpace = $CIM.FreeSpace
        $this.Bootable = $CIM.Bootable
        $this.PrimaryPartition = $CIM.PrimaryPartition
        $this.DiskIndex = $CIM.DiskIndex
        $this.PartitionNumber = $CIM.PartitionNumber
    }
    [string]$DeviceID
    [string]$Name
    [string]$DriveLetter
    [long]$Size
    [string]$FileSystem
    [string]$FreeSpace
    [bool]$Bootable
    [bool]$PrimaryPartition
    [string]$DiskIndex
    [string]$PartitionNumber
}
class LogicalDisk {
    LogicalDisk($CIM) {
        $this.DeviceID = $CIM.DeviceID
        $this.Name = $CIM.Name
        $this.FileSystem = $CIM.FileSystem
        $this.Size = $CIM.Size
        $this.FreeSpace = $CIM.FreeSpace
        $this.DriveType = $CIM.DriveType
        $this.DriveFormat = $CIM.DriveFormat
        $this.VolumeName = $CIM.VolumeName
        $this.VolumeSerialNumber = $CIM.VolumeSerialNumber
        $this.Compressed = $CIM.Compressed
        $this.CompressionMethod = $CIM.CompressionMethod
    }
    [string]$DeviceID
    [string]$Name
    [string]$FileSystem
    [long]$Size
    [long]$FreeSpace
    [string]$DriveType
    [string]$DriveFormat
    [string]$VolumeName
    [string]$VolumeSerialNumber
    [bool]$Compressed
    [string]$CompressionMethod
}

$WS = [Workstation]::new("localhost");
$WS | ConvertTo-Json | Out-File -FilePath ".\Workstation.json"
