# H1

## H2

### H3

Lorem, ipsum dolor sit amet consectetur adipisicing elit. Iste vel neque accusantium dignissimos reprehenderit at dolor error, assumenda, quaerat quo in, molestiae perferendis voluptate laborum sapiente harum explicabo aspernatur ab.

```powershell
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
```


1. List Item 1
2. List Item 2
3. List Item 3
4. List Item 4
5. List Item 5

Lorem, ipsum dolor sit amet consectetur adipisicing elit. Iste vel neque accusantium dignissimos reprehenderit at dolor error, assumenda, quaerat quo in, molestiae perferendis voluptate laborum sapiente harum explicabo aspernatur ab.

```powershell
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
```

- List Item 1
- List Item 2
- List Item 3
- List Item 4
- List Item 5