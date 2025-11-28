# Windows System Utility Suite
# Author: Sammy Alawar
# Description: Interactive Windows admin toolkit 
function ShowMenu{
    Clear-Host
    WRITE-HOST "Choose From Menu: "
    WRITE-HOST "-------------------------------------------------------------"
    WRITE-HOST "1- System Information"
    WRITE-HOST "2- File operations"
    WRITE-HOST "3- Network Tools"
    WRITE-HOST "4- Process Management"
    WRITE-HOST "5- Data Analysis"
    WRITE-HOST "6- Account Management"
    WRITE-HOST "7- Exit"
}
function SysInfo{
    while($true){
        Clear-Host
        WRITE-HOST "System Information Submenu"
        WRITE-HOST "`n1. Display detailed configuration information about the computer and its operating system"
        WRITE-HOST "`n2. Get basic information about the computer caption, codeset, buildnumber"
        WRITE-HOST "`n3. Get information about the processor"
        WRITE-HOST "`n4. Get information about the installed memory"
        WRITE-HOST "`n5. Get information about disk drives"
        WRITE-HOST "`n6. Display the hostname portion of the full computer name"
        WRITE-HOST "`n7. Display TCP/IP network configuration information"
        WRITE-HOST "`n8. Display the current date"
        WRITE-HOST "`n9. Display the current time"
        WRITE-HOST "`n10. Back"
        $choice = READ-HOST "`nEnter your choice(1-10)"
        switch ($choice) {
            "1" {
                Clear-Host
                Write-Host "Configuration information of Computer and Operating System:`n" -ForegroundColor Cyan
                Get-ComputerInfo
                Write-Host "Press Enter to continue..."
                Read-Host 
            }
            "2" {
                Clear-Host
                Write-Host "Computer Caption, codeset, and buildnumber:"
                $info = Get-CimInstance Win32_OperatingSystem
                Write-Host "Caption      : $($info.Caption)"
                Write-Host "Codeset      : $($info.CodeSet)"
                Write-Host "Build Number : $($info.BuildNumber)"
                Write-Host "Press Enter to continue..."
                Read-Host
            }
            "3" {
                Clear-Host
                Write-Host "CPU Information:"
                $info = Get-CimInstance Win32_Processor
                Write-Host "Name         : $($info.Name)"
                Write-Host "Manufacturer : $($info.Manufacturer)"
                Write-Host "Clock Speed  : $($info.MaxClockSpeed)"
                Write-Host "Description  : $($info.Description)"
                Write-Host "Core Count   : $($info.NumberOfCores)"
                Write-Host "Thread Count : $($info.ThreadCount)"
                Write-Host "Press Enter to continue..."
                Read-Host
            }
            "4" {
                Clear-Host
                Write-Host "RAM Information:"
                $info = Get-CimInstance Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory
                $ramGB = [math]::Round($info / 1GB, 2)
                Write-Host "Total Physical Memory: $($ramGb) GB"
                $info = Get-CimInstance Win32_PhysicalMemoryArray
                Write-Host "Number of Modules    : $($info.MemoryDevices)"
                $capacity = Get-CimInstance Win32_PhysicalMemory | Select-Object -ExpandProperty Capacity
                $info = Get-CimInstance Win32_PhysicalMemory
                $moduleGB = [math]::Round($capacity[0] / 1GB, 2)
                Write-Host "Module 1 Capacity    : $($moduleGB) GB"
                $moduleGB = [math]::Round($capacity[1] / 1GB, 2)
                Write-Host "Module 2 Capacity    : $($moduleGB) GB"
                Write-Host "Manufacturer         : $($info[0].Manufacturer)"
                Write-Host "Speed                : $($info[0].Speed) MHz"
                Write-Host "Press Enter to continue..."
                Read-Host 
            }
            "5" {
                Clear-Host
                Write-Host "Disk Drive Information:"
                $info = Get-CimInstance CIM_DiskDrive
                $SSD = Get-CimInstance CIM_DiskDrive | Select-Object -ExpandProperty Size
                $SSDSize = [math]::Round($SSD / 1GB, 2)
                Write-Host "Description   : $($info.Description)"
                Write-Host "Model         : $($info.Model)"
                Write-Host "Caption       : $($info.Caption)"
                Write-Host "Drive Capacity: $($SSDSize) GB"
                Write-Host "Press Enter to continue..."
                Read-Host
            }
            "6" {
                Clear-Host
                Write-Host "Hostname:"
                hostname
                Write-Host "Press Enter to continue..."
                Read-Host
            }
            "7" {
                Clear-Host
                Write-Host "Network Configuration Information:"
                ipconfig /all
                Write-Host "Press Enter to continue..."
                Read-Host
            }
            "8" {
                Clear-Host 
                Write-Host "Current Date: "
                Write-Host "$(Get-date -Format 'dd/MM/yyyy')"
                Write-Host "Press Enter to continue..."
                Read-Host
            }
            "9" {
                Clear-Host 
                Write-Host "Current Time: "
                Write-Host "$(Get-Date -Format 'hh:mm tt')"
                Write-Host "Press Enter to continue..."
                Read-Host
            }
            "10" {return}
            default {
                WRITE-HOST "Invalid Choice. Please input a number between 1 and 10." -ForegroundColor Red
                Write-Host "Press Enter to continue..."
                Read-Host
            }
        }
}
}

function FileOperations{
    while($true){
        Clear-Host
        WRITE-HOST "File Operations Submenu"
        WRITE-HOST "`n1. Display or change file attributes"
        WRITE-HOST "`n2. Display the name of or change the current directory"
        WRITE-HOST "`n3. Copy one or more files to another location"
        WRITE-HOST "`n4. Delete one or more files"
        WRITE-HOST "`n5. Display a list of files and subdirectories in a directory"
        WRITE-HOST "`n6. Create a directory"
        WRITE-HOST "`n7. Move one or more files from one directory to another directory"
        WRITE-HOST "`n8. Remove a directory"
        WRITE-HOST "`n9. Rename a file"
        WRITE-HOST "`n10. Get permission for a file"
        WRITE-HOST "`n11. Set permission for a file"
        WRITE-HOST "`n12. Save the current directory then change it"
        WRITE-HOST "`n13. Remove subdirectories"
        WRITE-HOST "`n14. Replace a file"
        WRITE-HOST "`n15. Graphically display the directory structure of a drive or path"
        WRITE-HOST "`n16. Copy files and directory trees"
        WRITE-HOST "`n17. Back"
        $choice = READ-HOST "`nEnter your choice(1-17)"
        switch($choice){
            "1" {
                Clear-Host
                Write-Host 
                Write-Host "`n1. Display Attributes"
                Write-Host "`n2. Change Attributes"
                Write-Host "`n3. Back"
                $choice1 = READ-HOST "`nEnter your choice(1-3)"

                switch($choice1){
                    "1" {
                        Clear-Host
                        Write-Host 
                        $file = READ-HOST "Enter File Path to display its attributes"
                        if (Test-Path $file -PathType Leaf){
                            Write-Host "File Exists" -ForegroundColor Green
                            Write-Host "Attributes: $($(Get-Item $file).Attributes)"
                            Write-Host "Press Enter to continue..."
                            Read-Host
                        }
                        else {
                            Write-Host "File Path doesn't exist" -ForegroundColor Red
                            Write-Host "Press Enter to continue..."
                            Read-Host
                        }
                    }
                    "2" {
                        Clear-Host 
                        Write-Host 
                        $file = READ-HOST "Enter File Path to change its attributes"
                        if (Test-Path $file){
                            Write-Host "File Exists" -ForegroundColor Green
                            Write-Host "`n1. ReadOnly"
                            Write-Host "`n2. Archive (Default)"
                            Write-Host "`n3. Hidden"
                            Write-Host "`n4. Normal (Removes All Attributes)"
                            $choice2 = Read-Host "Enter Choice(1-4)"
                            Clear-Host
                            Write-Host 
                            switch($choice2){
                                "1" {
                                    Set-ItemProperty -Path "$file" -Name Attributes -Value ReadOnly
                                    Write-Host "$file is now Read-Only." -ForegroundColor Cyan
                                    Write-Host "Press Enter to continue..."
                                    Read-Host 
                                }
                                "2" {
                                    Set-ItemProperty -Path "$file" -Name Attributes -Value Archive
                                    Write-Host "$file is now marked as Archive." -ForegroundColor Cyan
                                    Write-Host "Press Enter to continue..."
                                    Read-Host 
                                }
                                "3" {
                                    Set-ItemProperty -Path "$file" -Name Attributes -Value Hidden
                                    Write-Host "$file is now Hidden." -ForegroundColor Cyan
                                    Write-Host "Press Enter to continue..."
                                    Read-Host 
                                }
                                "4" {
                                    Set-ItemProperty -Path "$file" -Name Attributes -Value Normal
                                    Write-Host "$file attributes have been reset to Normal." -ForegroundColor Cyan
                                    Write-Host "Press Enter to continue..."
                                    Read-Host 
                                }
                                default {
                                    WRITE-HOST "Invalid Choice. Please input a number between 1 and 4." -ForegroundColor Red
                                    Write-Host "Press Enter to continue..."
                                    Read-Host 
                                }
                                
                            }
                            
                        }
                    
                        else{
                            Write-Host "File Path doesn't exist" -ForegroundColor Red
                            Write-Host "Press Enter to continue..."
                            Read-Host
                        }

                    }
                    "3" {break}
                    default {WRITE-HOST "Invalid Choice. Please input a number between 1 and 3." -ForegroundColor Red}
                }
            }
            "2" {
                Clear-Host
                Write-Host 
                Write-Host "`1. Display Working Directory"
                Write-Host "`n2. Change Directory"
                Write-Host "`n3. Back"
                $choice2 = Read-Host "Enter your choice(1-3)"
                switch($choice2){
                    "1" {
                        Clear-Host
                        Write-Host 
                        Write-Host "`nCurrent Working Directory: $(Get-Location)"
                        Write-Host "`nPress Enter to continue..."
                        Read-Host
                    }
                    "2" {
                        Clear-Host
                        Write-Host 
                        $directory = Read-Host "Enter path of directory you want to change to"
                        if (Test-Path $directory -PathType Container){
                            Write-Host "Changing to $directory..." -ForegroundColor Cyan
                            Set-Location $directory
                            Write-Host "Successfully changed directory to $directory" -ForegroundColor Green
                            Write-Host "`nPress Enter to continue..."
                            Read-Host

                        }
                        else{
                            Write-Host "Directory $directory doesn't exist." -ForegroundColor Red
                            Write-Host "`nPress Enter to continue..."
                            Read-Host
                        }


                    }
                    "3" {break}

                    default{
                        Write-Host "Invalid Choice. Please input a number between 1 and 3" -ForegroundColor Red
                        Write-Host "`nPress Enter to continue..."
                        Read-Host
                        
                    }
                }


            }
            "3" {
                Clear-Host
                
                $inputFiles = Read-Host "Enter file(s) to copy. Seperate each file by a comma"
                $files = $inputFiles -split "," | ForEach-Object { $_.Trim() } #Removes leading and trailing whitespace.
                $dest = Read-Host "Enter destination to copy to"
                if(Test-Path $dest -PathType Container){
                    foreach($file in $files){
                        if(Test-Path $file){
                            Write-Host "Processing $file..." -ForegroundColor Cyan
                            Copy-Item -Path $file -Destination $dest -Force
                            Write-Host "File $file successfully copied to $dest!" -ForegroundColor Green
                        }
                        else{
                            Write-Host "File $file doesn't exist" -ForegroundColor Red
                        }
                        Write-Host "`n=============================================================================`n"
                    }
                    Write-Host "Press Enter to continue..."
                    Read-Host
                }
                else{
                    Write-Host "Destination $dest doesn't exist."
                    Write-Host "`nPress Enter to continue..."
                    Read-Host
                }


            }
            "4" {
                Clear-Host
                
                $inputFiles = Read-Host "Enter file(s) to delete. Seperate each file by a comma"
                $files = $inputFiles -split "," | ForEach-Object { $_.Trim() } #Removes leading and trailing whitespace.
                foreach($file in $files){
                    if(Test-Path $file -PathType Leaf){
                        Write-Host "Processing $file..." -ForegroundColor Cyan
                        Remove-Item -Path $file -Force -Confirm
                        Write-Host "File $file successfully deleted." -ForegroundColor Green
                    }
                    else{
                        Write-Host "File $file doesn't exist" -ForegroundColor Red
                    }
                    Write-Host "`n=============================================================================`n"

                }
                Write-Host "Press Enter to continue..."
                Read-Host
            }

            "5" {
                Clear-Host
                
                $directory = Read-Host "Enter Directory you want to list"
                if(Test-Path $directory -PathType Container){
                    Get-ChildItem $directory
                }
                else{
                    Write-Host "Directory $directory doesn't exist" -ForegroundColor Red
                }
                Write-Host "Press Enter to continue..."
                Read-Host

            }
            "6" {
                Clear-Host
                
                $path = Read-Host "Enter the Full Path of the directory you want to create"
                $parentPath = Split-Path -Path $path -Parent
                if(Test-Path $parentPath -PathType Container){
                    Write-Host "Creating Directory $path" -ForegroundColor Cyan
                    New-Item -Path $path -ItemType Directory 
                    Write-Host "Directory $path Successfully created!" -ForegroundColor Green
                }
                else{
                    Write-Host "Parent Path $parentPath doesn't exist"
                }
                Write-Host "Press Enter to continue..."
                Read-Host

            }
            "7" {
                Clear-Host
                
                $inputFiles = Read-Host "Enter file(s) to move. Seperate each file by a comma"
                $files = $inputFiles -split "," | ForEach-Object { $_.Trim() } #Removes leading and trailing whitespace.
                $dest = Read-Host "Enter destination to move to"
                if(Test-Path $dest -PathType Container){
                    foreach($file in $files){
                        if(Test-Path $file){
                            Write-Host "Processing $file..." -ForegroundColor Cyan
                            Move-Item -Path $file -Destination $dest -Force
                            Write-Host "File $file successfully moved to $dest!" -ForegroundColor Green
                        }
                        else{
                            Write-Host "File $file doesn't exist" -ForegroundColor Red
                        }
                        Write-Host "`n=============================================================================`n"
                    }
                    Write-Host "Press Enter to continue..."
                    Read-Host
                }
                else{
                    Write-Host "Destination $dest doesn't exist."
                    Write-Host "`nPress Enter to continue..."
                    Read-Host
                }


            }
            "8" {
                Clear-Host
                
                $dir = Read-Host "Enter directory to delete"
       
                if(Test-Path $dir -PathType Container){
                    Write-Host "Processing $dir..." -ForegroundColor Cyan
                    Remove-Item -Path $dir -Force -Confirm -Recurse #Deletes non empty directories
                    Write-Host "Directory $dir successfully deleted." -ForegroundColor Green
                }
                else{
                    Write-Host "Directory $dir doesn't exist" -ForegroundColor Red
                }
                Write-Host "`n=============================================================================`n"

                
                Write-Host "Press Enter to continue..."
                Read-Host

            }
            "9" {
                Clear-Host
                

                $file = Read-Host "Enter the full path of the file you want to rename"

                if (Test-Path $file -PathType Leaf) {
                    $rename = Read-Host "Enter the new file name (without path)"
                    $parentPath = Split-Path -Path $file -Parent
                    $newPath = Join-Path $parentPath $rename

                    if (Test-Path $newPath -PathType Leaf) {
                        Write-Host "Error: A file named '$rename' already exists in the same directory." -ForegroundColor Red
                    } else {
                        Write-Host "Processing $file..." -ForegroundColor Cyan
                        Rename-Item -Path $file -NewName $newPath
                        Write-Host "File successfully renamed to: $newPath" -ForegroundColor Green
                    }
                } else {
                    Write-Host "Error: File '$file' doesn't exist." -ForegroundColor Red
                }

                Write-Host "Press Enter to continue..."
                Read-Host
            }

            "10" {
                Clear-Host
                

                # Ask user for file path
                $file = Read-Host "Enter the file you want to view permissions of"

                # Check if the file exists
                if (Test-Path $file -PathType Leaf) {
                    Write-Host "`nPermissions for: $file" -ForegroundColor Cyan

                    # Get ACL and file owner
                    $acl = Get-Acl $file
                    Write-Host "Owner: $($acl.Owner)" -ForegroundColor Yellow
                    Write-Host "------------------------------------------------"

                    # Loop through each permission entry and format it
                    $acl.Access | ForEach-Object {
                        Write-Host ("User/Group  : " + $_.IdentityReference) -ForegroundColor Green
                        Write-Host ("Permissions : " + $_.FileSystemRights) -ForegroundColor White
                        Write-Host ("Inherited   : " + $_.IsInherited)
                        Write-Host "------------------------------------------------"
                    }
                } else {
                    Write-Host "The file '$file' doesn't exist." -ForegroundColor Red
                }

                Write-Host "`nPress Enter to continue..."
                Read-Host
            }

            "11" {
                Clear-Host
                
                $computerName = $env:COMPUTERNAME
                Write-Host "Computer Name: $computerName"

                $file = Read-Host "Enter the full path of the file you want to modify permissions for"
                if (Test-Path $file -PathType Leaf) {
                    $user = Read-Host "Enter the username"
                    Write-Host "`nSelect a permission level for $user`:"
                    Write-Host "1. Full Control"
                    Write-Host "2. Read and Execute"
                    Write-Host "3. Write"
                    Write-Host "4. Modify"
                    Write-Host "5. Remove All Permissions"
                    Write-Host "6. Deny Write Access"
                    $choice = Read-Host "Enter your choice (1-6)"

                    # Get current ACL
                    $acl = Get-Acl $file
                    $rule = $null

                    # Apply the selected permission
                    switch ($choice) {
                        "1" { 
                            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, "FullControl", "Allow")
                            Write-Host "Granting Full Control to $user..." -ForegroundColor Green
                        }
                        "2" { 
                            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, "ReadAndExecute", "Allow")
                            Write-Host "Granting Read & Execute to $user..." -ForegroundColor Green
                        }
                        "3" { 
                            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, "Write", "Allow")
                            Write-Host "Granting Write access to $user..." -ForegroundColor Green
                        }
                        "4" { 
                            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, "Modify", "Allow")
                            Write-Host "Granting Modify access to $user..." -ForegroundColor Green
                        }
                        "5" { 
                            $acl.PurgeAccessRules($user)
                            Write-Host "Removing all permissions for $user..." -ForegroundColor Red
                        }
                        "6" { 
                            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, "Write", "Deny")
                            Write-Host "Denying Write access for $user..." -ForegroundColor Red
                        }
                        
                        default { 
                            Write-Host "Invalid choice. No changes made." -ForegroundColor Yellow
                            return
                        }
                    }

                    # If a rule was set, apply it
                    if ($rule) {
                        $acl.SetAccessRule($rule)
                    }

                    # Apply the updated ACL to the file
                    Set-Acl -Path $file -AclObject $acl
                    Write-Host "Permissions updated successfully!" -ForegroundColor Cyan

                } else {
                    Write-Host "Error: The file '$file' does not exist!" -ForegroundColor Red
                }

                Write-Host "`nPress Enter to continue..."
                Read-Host
            }
            "12" {
                Clear-Host
                
                # Store current directory
                $currentDir = Get-Location
                $newDir = Read-Host "Enter path of Directory"
                if (Test-Path $newDir -PathType Container) {
                    Set-Location -Path $newDir
                    Write-Host "Changed directory to: $(Get-Location)" -ForegroundColor Green
                } else {
                    Write-Host "The directory does not exist." -ForegroundColor Red
                }
                
                Write-Host "`nPress Enter to continue..."
                Read-Host
            }
            "13" {
                Clear-Host
                
                
                # Ask user for the parent directory
                $parentDir = Read-Host "Enter the path of the directory to clean up"
                
                # Verify that the directory exists
                if (Test-Path $parentDir -PathType Container) {
                    # Get all subdirectories
                    $subDirs = Get-ChildItem -Path $parentDir -Directory
                
                    # Check if there are subdirectories to delete
                    if ($subDirs.Count -gt 0) {
                        Write-Host "Found $($subDirs.Count) subdirectories in $parentDir."
                
                        # Ask user for confirmation before deleting
                        $confirm = Read-Host "Do you want to delete all subdirectories? (Y/N)"
                        
                        if ($confirm -match "^[Yy]$") {
                            foreach ($dir in $subDirs) {
                                Remove-Item -Path $dir.FullName -Recurse -Force
                                Write-Host "Deleted: $($dir.FullName)" -ForegroundColor Green
                            }
                            Write-Host "All subdirectories removed successfully!" -ForegroundColor Cyan
                        } else {
                            Write-Host "Operation canceled." -ForegroundColor Yellow
                        }
                    } else {
                        Write-Host "No subdirectories found in $parentDir." -ForegroundColor Yellow
                    }
                } else {
                    Write-Host "Error: The directory '$parentDir' does not exist!" -ForegroundColor Red
                }
                
                Write-Host "`nPress Enter to continue..."
                Read-Host
                }
            "14" {
                Clear-Host
                

                # Ask user for file names
                $file = Read-Host "Enter the name of the file being replaced"
                $replace = Read-Host "Enter the name of the file that is doing the replacing"

                # Ensure both files exist
                if (Test-Path $file -PathType Leaf) {
                    if (Test-Path $replace -PathType Leaf) {
                        Write-Host "Replacing content of '$file' with content of '$replace'..." -ForegroundColor Cyan

                        # Copy file content (overwrite without prompting)
                        Copy-Item -Path $replace -Destination $file -Force

                        Write-Host "Replacement complete!" -ForegroundColor Green
                    } else {
                        Write-Host "Error: The replacing file '$replace' does not exist." -ForegroundColor Red
                    }
                } else {
                    Write-Host "Error: The file to be replaced '$file' does not exist." -ForegroundColor Red
                }

                Write-Host "`nPress Enter to return to FileOps..."
                Read-Host
            }
            "15" {
                Clear-Host
                

                # Ask the user for the root directory
                $pathh = Read-Host "Enter Root Directory"

                # Check if the directory exists
                if (Test-Path $pathh -PathType Container) {
                    Write-Host "`nFolder Structure of: $pathh" -ForegroundColor Cyan

                    # Use a recursive function to mimic 'tree' command
                    function Show-Tree($dir, $indent = "") {
                        $items = Get-ChildItem -Path $dir
                        foreach ($item in $items) {
                            Write-Host "$indent|-- $($item.Name)"
                            if ($item.PSIsContainer) {
                                Show-Tree -dir $item.FullName -indent "$indent   "
                            }
                        }
                    }

                    Show-Tree -dir $pathh

                } else {
                    Write-Host "Error: Directory '$pathh' doesn't exist." -ForegroundColor Red
                }

                Write-Host "`nPress Enter to continue..."
                Read-Host
                # Call FileOps function (if you have one)

            }
            "16" {
                Clear-Host
                

                # Ask the user for the source and destination directories
                $directory = Read-Host "Enter Directory you want to copy"
                $destination = Read-Host "Enter Destination"

                # Check if the source directory exists
                if (Test-Path $directory -PathType Container) {
                    # Check if the destination exists
                    if (Test-Path $destination -PathType Container) {
                        Write-Host "Copying '$directory' into '$destination'..." -ForegroundColor Cyan

                        # Copy all contents recursively (equivalent to xcopy /E /H /C /I)
                        Copy-Item -Path $directory -Destination $destination -Recurse -Force

                        Write-Host "Copy complete!" -ForegroundColor Green
                    } else {
                        Write-Host "Error: The destination directory '$destination' does not exist." -ForegroundColor Red
                    }
                } else {
                    Write-Host "Error: The source directory '$directory' does not exist." -ForegroundColor Red
                }

                Write-Host "`nPress Enter to continue..."
                Read-Host
            }
            "17" {return}
            default {
                WRITE-HOST "Invalid Choice. Please input a number between 1 and 17." -ForegroundColor Red
                Write-Host "`nPress Enter to continue..."
                Read-Host
            }

        }
}
}
function NetworkTools {
    while ($true) {
        Clear-Host
        Write-Host "Network Tools Submenu"
        Write-Host "`n1. View the current password & logon restrictions for the computer"
        Write-Host "`n2. Display current server or workgroup settings"
        Write-Host "`n3. View the details of a particular user account"
        Write-Host "`n4. Stop and start a particular service"
        Write-Host "`n5. Display network statistics of the workstation"
        Write-Host "`n6. Display information about your connections"
        Write-Host "`n7. Back"
        $choice = Read-Host "Enter your choice(1-7)"

        switch ($choice) {
            "1" {
                Clear-Host
                
                Write-Host "`nCurrent Password & Logon Restrictions:" -ForegroundColor Cyan
                Write-Host "`nPassword Policy:"
                (Get-LocalUser) | Select-Object Name, PasswordRequired, PasswordLastSet, PasswordExpires | Format-Table -AutoSize
                Write-Host "`nAccount Lockout Policy:"
                net accounts | Select-String "Lockout threshold|Lockout duration"
                Write-Host "`nLogon Restrictions:"
                net accounts
                Write-Host "`nPress Enter to continue..."
                Read-Host
            }

            "2" {
                Clear-Host
                
                Write-Host "`nCurrent Server or Workgroup Settings:" -ForegroundColor Cyan
                $systemInfo = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object Name, Domain, Workgroup
                Write-Host "`nComputer Name : $($systemInfo.Name)"
                Write-Host "Domain         : $($systemInfo.Domain)"
                Write-Host "Workgroup      : $($systemInfo.Workgroup)"
                Write-Host "`nPress Enter to continue..."
                Read-Host
            }

            "3" {
                Clear-Host
                
                $username = Read-Host "Enter the username to view details"
                $userInfo = Get-LocalUser | Where-Object { $_.Name -eq $username }
                $fullName = (Get-CimInstance Win32_UserAccount | Where-Object { $_.Name -eq $username }).FullName
                if ($userInfo) {
                    Write-Host "`nDetails for User: $username" -ForegroundColor Cyan
                    Write-Host "-------------------------------------"
                    Write-Host "Full Name         : $fullName"
                    Write-Host "Enabled           : $($userInfo.Enabled)"
                    Write-Host "Password Required : $($userInfo.PasswordRequired)"
                    Write-Host "Password Expires  : $($userInfo.PasswordExpires)"
                    Write-Host "Last Logon        : $($userInfo.LastLogon)"
                    Write-Host "Account Created   : $($userInfo.AccountCreated)"
                } else {
                    Write-Host "Error: User '$username' does not exist." -ForegroundColor Red
                }
                Write-Host "`nPress Enter to continue..."
                Read-Host
            }

            "4" {
                Clear-Host
                
                $serviceName = Read-Host "Enter the name of the service"
                $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
                if ($service) {
                    Write-Host "`nThe service '$serviceName' is valid." -ForegroundColor Green
                    Write-Host "What do you want to do with the service?"
                    Write-Host "1. Stop the service"
                    Write-Host "2. Start the service"
                    $action = Read-Host "Enter your choice (1-2)"
                    switch ($action) {
                        "1" {
                            if ($service.Status -eq "Running") {
                                Write-Host "Stopping the service '$serviceName'..." -ForegroundColor Cyan
                                Stop-Service -Name $serviceName -Force
                                Write-Host "Service '$serviceName' stopped successfully." -ForegroundColor Green
                            } else {
                                Write-Host "The service '$serviceName' is already stopped." -ForegroundColor Yellow
                            }
                        }
                        "2" {
                            if ($service.Status -eq "Stopped") {
                                Write-Host "Starting the service '$serviceName'..." -ForegroundColor Cyan
                                Start-Service -Name $serviceName
                                Write-Host "Service '$serviceName' started successfully." -ForegroundColor Green
                            } else {
                                Write-Host "The service '$serviceName' is already running." -ForegroundColor Yellow
                            }
                        }
                        default {
                            Write-Host "Invalid action selected. Please choose 1 or 2." -ForegroundColor Red
                        }
                    }
                } else {
                    Write-Host "The service '$serviceName' does not exist or is invalid." -ForegroundColor Red
                }
                Write-Host "`nPress Enter to continue..."
                Read-Host
            }

            "5" {
                while ($true) {
                    Clear-Host
                    
                    Write-Host "`nChoose to display network statistics:"
                    Write-Host "1. Workstation"
                    Write-Host "2. Back"
                    $choice = Read-Host "Enter your choice (1-2)"
                    switch ($choice) {
                        "1" {
                            Write-Host "`nDisplaying network statistics for the workstation..." -ForegroundColor Cyan
                            cmd /c "net statistics workstation"
                            Write-Host "`nPress Enter to continue..."
                            Read-Host
                        }
                        "2" {
                            break  # Exits submenu properly
                        }
                        default {
                            Write-Host "Invalid choice. Please select 1 or 2." -ForegroundColor Red
                            Write-Host "`nPress Enter to continue..."
                            Read-Host
                        }
                    }
                    if ($choice -eq "2"){
                        break
                    }
                }
            }

            "6" {
                while ($true) {
                    Clear-Host
                    
                    Write-Host "`nDisplay Information About Your Connections:"
                    Write-Host "1. Display all active connections"
                    Write-Host "2. Display listening ports"
                    Write-Host "3. Display routing table"
                    Write-Host "4. Display statistics by protocol (TCP, UDP, etc...)"
                    Write-Host "5. Back"
                    $choice1 = Read-Host "Enter your choice (1-5)"
                    switch ($choice1) {
                        "1" { netstat -an }
                        "2" { netstat -an | Select-String "LISTENING"
                            
                    }
                        "3" { netstat -rn }
                        "4" { netstat -s }
                        "5" { break }  # Exits submenu properly
                        default {
                            Write-Host "Invalid choice. Please enter a number between 1 and 5." -ForegroundColor Red
                            Write-Host "`nPress Enter to continue..."
                            Read-Host
                        }
                    }
                    if($choice1 -eq "5"){
                        break
                    }
                    Write-Host "`nPress Enter to continue..."
                    Read-Host
                }
            }

            "7" { return }  # Exits main loop properly
            default {
                Write-Host "Invalid choice. Please enter a number between 1 and 7." -ForegroundColor Red
                Write-Host "`nPress Enter to continue..."
                Read-Host
            }
        }
    }
}

function ProcessManagement{
    while ($true) {
        Clear-Host
        Write-Host "Process Management Submenu"
        Write-Host "`n1. View the List of Running Processes"
        Write-Host "`n2. Kill a Particular Process"
        Write-Host "`n3. Start a New Process"
        Write-Host "`n4. View processes consuming the most CPU"
        Write-Host "`n5. View processes consuming the most memory"
        Write-Host "`n6. Back"
        $choice = Read-Host "`nEnter your choice(1-6)"

        switch($choice){
            "1" {
                Clear-Host
                Write-Host "List of running processes:"
                $process = $(Get-Process)
                Write-Output $process
                Write-Host "`nPress Enter to continue..."
                Read-Host
            }
            "2" {
                Clear-Host
                
                $processName = Read-Host "Enter the name of the process to terminate"
                $process = Get-Process -Name $processName -ErrorAction SilentlyContinue

                if ($process) {
                    Write-Host "`nFound process: $processName (ID: $($process.Id))"
                    
                    # Confirm termination
                    $confirm = Read-Host "Are you sure you want to terminate $processName? (Y/N)"
                    
                    if ($confirm -match "^[Yy]$") {
                        Stop-Process -Name $processName -Force
                        Write-Host "`nProcess '$processName' terminated successfully." -ForegroundColor Green
                    } else {
                        Write-Host "`nProcess termination canceled." -ForegroundColor Yellow
                    }
                } else {
                    Write-Host "`nError: The process '$processName' does not exist or is invalid." -ForegroundColor Red
                }

                Write-Host "`nPress Enter to continue..."
                Read-Host
            }
            "3" {
                Clear-Host
                

                # Ask user for the process/application name
                $processName = Read-Host "Enter the name of the application/process you want to start"

                # Ensure the name ends with .exe if missing
                if (-not $processName.ToLower().EndsWith(".exe")) {
                    $processName += ".exe"
                }

                # First, check if the application exists in system PATH directories
                $foundPath = $null
                $env:Path -split ";" | ForEach-Object {
                    $filePath = "$_\$processName"
                    if (Test-Path $filePath) {
                        $foundPath = $filePath
                    }
                }

                # If not found in system PATH, search recursively in C:\
                if (-not $foundPath) {
                    Write-Host "`nSearching for '$processName' in C:\ (this may take some time)..." -ForegroundColor Yellow
                    $foundPath = Get-ChildItem -Path C:\ -Recurse -Filter $processName -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName
                }

                # If found, start the application
                if ($foundPath) {
                    Write-Host "`nStarting '$processName' from '$foundPath'..." -ForegroundColor Cyan
                    Start-Process -FilePath $foundPath
                    Write-Host "`n'$processName' started successfully!" -ForegroundColor Green
                } else {
                    Write-Host "`nThe application '$processName' does not exist in system PATH or in C:\" -ForegroundColor Red
                    Write-Host "Please enter a valid executable name."
                }

                Write-Host "`nPress Enter to continue..."
                Read-Host

            }
            "4" {
                Clear-Host
                Write-Host "List of processes consuming the most CPU:"
                Get-Process | Sort-Object CPU -Descending | Select-Object -First 10
                Write-Host "`nPress Enter to continue..."
                Read-Host
            }
            "5" {
                Clear-Host
                Write-Host 
                Write-Host "List of processes consuming the most RAM:"
                Get-Process | Sort-Object WS -Descending | Select-Object -First 10 ProcessName, Id, @{Name="Memory (MB)";Expression={[math]::Round($_.WS / 1MB, 2)}} | Format-Table -AutoSize
                Write-Host "`nPress Enter to continue..."
                Read-Host
            }
            "6" {break}
            default {
                Write-Host "Invalid choice. Please enter a number between 1 and 6." -ForegroundColor Red
                Write-Host "`nPress Enter to continue..."
                Read-Host
            }
        }
        if($choice -eq "6"){return}
    }
}

function DataAnalysis{
    while($true){
        Clear-Host
        Write-Host "Date Analysis Submenu"
        Write-Host "1. Search for a string within a file"
        Write-Host "2. Search for a string within a directory"
        Write-Host "3. Sort the contents of a text file."
        Write-Host "4. Search for a specific string in a text file"
        Write-Host "5. Compare two files and display the differences"
        Write-Host "6. Display the contents of a text file"
        Write-Host "7. Display message "'Hello, World!'""
        Write-Host "8. Back"
        $choice = Read-Host "Enter your choice(1-8)"
        switch($choice){
            "1" {
                Clear-Host
                
                $file = (Read-Host "Enter file you want to search in").Trim('"')

                if(Test-Path $file -PathType Leaf){
                    $string = Read-Host "Enter string you want to search for in $file"
                    $found = Select-String -Path $file -Pattern $string 
                    if ($found){
                        Write-Host "String Found!" -ForegroundColor Green
                        foreach ($match in $found) {
                            Write-Host "Line $($match.LineNumber): $($match.Line)" -ForegroundColor Cyan
                        }
                    }
                    else{
                        Write-Host "String $string not found in $file." -ForegroundColor Red 
                    }
                }
                else{
                    Write-Host "File $file doesn't exist" -ForegroundColor Red
                }
                Write-Host "Press Enter to continue..."
                Read-Host
            }
            "2" {
                Clear-Host
                

                # Ask for directory input
                $dir = Read-Host "Enter directory you want to search in"

                # Check if directory exists
                if (Test-Path $dir -PathType Container) {
                    $string = Read-Host "Enter filename/subdirectory name you want to search for in $dir"

                    # Search for files & directories (Partial Match)
                    $foundFile = Get-ChildItem -Path $dir -File | Where-Object { $_.Name -match $string }
                    $foundDir = Get-ChildItem -Path $dir -Directory | Where-Object { $_.Name -match $string }

                    # Check for matching files
                    if ($foundFile) {
                        Write-Host "`nFiles Found:" -ForegroundColor Green
                        foreach ($match in $foundFile) {
                            Write-Host " - $($match.FullName)" -ForegroundColor Cyan
                        }
                    } else {
                        Write-Host "`nNo files matching '$string' found in '$dir'." -ForegroundColor Red
                    }

                    # Check for matching directories
                    if ($foundDir) {
                        Write-Host "`nDirectories Found:" -ForegroundColor Green
                        foreach ($match in $foundDir) {
                            Write-Host " - $($match.FullName)" -ForegroundColor Cyan
                        }
                    } else {
                        Write-Host "`nNo subdirectories matching '$string' found in '$dir'." -ForegroundColor Red
                    }
                } else {
                    Write-Host "Directory '$dir' doesn't exist." -ForegroundColor Red
                }

                Write-Host "`nPress Enter to continue..."
                Read-Host
            }

            "3" {
                Clear-Host
                
                $file = (Read-Host "Enter file you want to sort").Trim('"')

                    if(Test-Path $file -PathType Leaf){
                        Get-Content $file | Sort-Object
                    }
                    else{
                        Write-Host "File $file doesn't exist." -ForegroundColor Red
                    }
                Write-Host "Press Enter to continue..."
                Read-Host  
            }
            "4" {
                Clear-Host
                

                # Get file input from user
                $file = (Read-Host "Enter file you want to search in").Trim('"')
                # Ensure it's a .txt file and exists
                if ((Test-Path $file -PathType Leaf) -and ($file.ToLower().EndsWith(".txt"))) {
                    $string = Read-Host "Enter the exact phrase to search for in $file"

                    # Use Select-String with -SimpleMatch for exact phrase matching
                    $found = Select-String -Path $file -Pattern "^$string$" 

                    # Check if match found
                    if ($found) {
                        Write-Host "`nString Found!" -ForegroundColor Green
                        foreach ($match in $found) {
                            Write-Host "Line $($match.LineNumber): $($match.Line)" -ForegroundColor Cyan
                        }
                    } else {
                        Write-Host "`nString '$string' not found in '$file'." -ForegroundColor Red
                    }
                } else {
                    Write-Host "Error: Either '$file' doesn't exist or it's not a .txt file." -ForegroundColor Red
                }

                Write-Host "`nPress Enter to continue..."
                Read-Host
            }

            "5" {
                Clear-Host
                

                $file1 = (Read-Host "Enter the name of the first file").Trim('"')
              
                if (Test-Path $file1 -PathType Leaf) {
                    Write-Host "The file '$file1' exists." -ForegroundColor Green

                    $file2 = (Read-Host "Enter the name of the second file to compare").Trim('"')
                    $file = $rawPath.Trim('"')

                    if (Test-Path $file2 -PathType Leaf) {
                        Write-Host "The file '$file2' exists." -ForegroundColor Green
                        Write-Host "Comparing '$file1' with '$file2'..."
                        Compare-Object -ReferenceObject (Get-Content $file1) -DifferenceObject (Get-Content $file2) | Format-Table -AutoSize

                    } else {
                        Write-Host "The file '$file2' doesn't exist." -ForegroundColor Red
                    }
                } else {
                    Write-Host "The file '$file1' doesn't exist." -ForegroundColor Red
                }

                Write-Host "`nPress Enter to continue..."
                Read-Host
            }

            "6" {
                Clear-Host
                
                $file = (Read-Host "Enter the name of file you want to display").Trim('"')
                if (Test-Path $file -PathType Leaf) {
                    Write-Host "The file '$file' exists." -ForegroundColor Green
                    Write-Host "Content:" -ForegroundColor Cyan
                    Get-Content $file
                }
                else{
                    Write-Host "The file $file doesn't exist" -ForegroundColor Red
                }
                Write-Host "Press Enter to continue..."
                Read-Host
            }
            "7" {
                Clear-Host
                
                Write-Host "Hello, World!" -ForegroundColor Green
                Write-Host "Press Enter to continue..."
                Read-Host
            }
            "8" {break}

            default {
                Write-Host "Invalid choice. Please enter a number between 1 and 7." -ForegroundColor Red
                Write-Host "`nPress Enter to continue..."
                Read-Host
            }
        }

        if($choice -eq "8"){return}

    }

}

function AccountManagement{
    while ($true) {
        Clear-Host
        Write-Host "Account Management Submenu"
        Write-Host "`n1. View a list of all user accounts on the machine"
        Write-Host "`n2. View account details for a specific user"
        Write-Host "`n3. View account expiration dates"
        Write-Host "`n4. Create a local user account"
        Write-Host "`n5. Create a local administrator account"
        Write-Host "`n6. Change a user's password"
        Write-Host "`n7. Lock or unlock a user account"
        Write-Host "`n8. Set or modify account expiration dates"
        Write-Host "`n9. Delete a local user account"
        Write-Host "`n10. Delete an account and remove user data"
        Write-Host "`n11. Add a user to a local administrator group"
        Write-Host "`n12. Back"
        $choice = Read-Host "Enter your choice(1-12)"
        switch ($choice) {
            "1" { # List all users
                Clear-Host
                Write-Host "List of All User Accounts:" -ForegroundColor Cyan
                Get-LocalUser | Select-Object Name, Enabled, LastLogon, Description | Format-Table -AutoSize
            }

            "2" { # View details of a specific user
                Clear-Host
                $user = Read-Host "Enter the username"
                $userInfo = Get-LocalUser -Name $user -ErrorAction SilentlyContinue
                if ($userInfo) {
                    Write-Host "`nDetails for User: $user" -ForegroundColor Cyan
                    $userInfo | Format-List
                } else {
                    Write-Host "Error: User '$user' does not exist." -ForegroundColor Red
                }
            }

            "3" { # View account expiration dates
                Clear-Host
                Write-Host "Account Expiration Dates:" -ForegroundColor Cyan
                Get-LocalUser | Select-Object Name, AccountExpires | Format-Table -AutoSize
            }

            "4" { # Create a local user
                Clear-Host
                $username = Read-Host "Enter new username"
                $password = Read-Host "Enter password" -AsSecureString
                New-LocalUser -Name $username -Password $password -FullName $username -Description "Standard user"
                Write-Host "User '$username' created successfully!" -ForegroundColor Green
            }

            "5" { # Create a local admin
                Clear-Host
                $username = Read-Host "Enter new admin username"
                $password = Read-Host "Enter password" -AsSecureString
                New-LocalUser -Name $username -Password $password -FullName $username -Description "Administrator"
                Add-LocalGroupMember -Group "Administrators" -Member $username
                Write-Host "Admin account '$username' created successfully!" -ForegroundColor Green
            }

            "6" { # Change password
                Clear-Host
                $username = Read-Host "Enter the username"
                $password = Read-Host "Enter new password" -AsSecureString
                Set-LocalUser -Name $username -Password $password
                Write-Host "Password changed successfully for '$username'!" -ForegroundColor Green
            }

            "7" { # Lock or unlock a user
                Clear-Host
                $username = Read-Host "Enter the username"
                $action = Read-Host "Enter 'lock' to disable or 'unlock' to enable account"
                if ($action -eq "lock") {
                    Disable-LocalUser -Name $username
                    Write-Host "User '$username' has been locked!" -ForegroundColor Red
                } elseif ($action -eq "unlock") {
                    Enable-LocalUser -Name $username
                    Write-Host "User '$username' has been unlocked!" -ForegroundColor Green
                } else {
                    Write-Host "Invalid action. Use 'lock' or 'unlock'." -ForegroundColor Yellow
                }
            }

            "8" { # Set account expiration date
                Clear-Host
                $username = Read-Host "Enter the username"
                $expiration = Read-Host "Enter expiration date (YYYY-MM-DD)"
                Set-LocalUser -Name $username -AccountExpires $expiration
                Write-Host "Account expiration date updated for '$username'!" -ForegroundColor Green
            }

            "9" { # Delete a user
                Clear-Host
                $username = Read-Host "Enter the username to delete"
                Remove-LocalUser -Name $username
                Write-Host "User '$username' deleted successfully!" -ForegroundColor Green
            }

            "10" { # Delete user and remove data
                Clear-Host
                $username = Read-Host "Enter the username to delete and remove data"
                $profilePath = "C:\Users\$username"
                Remove-LocalUser -Name $username
                if (Test-Path $profilePath) {
                    Remove-Item -Path $profilePath -Recurse -Force
                    Write-Host "User '$username' and all data removed!" -ForegroundColor Green
                } else {
                    Write-Host "User data for '$username' not found." -ForegroundColor Yellow
                }
            }

            "11" { # Add user to admin group
                Clear-Host
                $username = Read-Host "Enter the username to add to administrators"
                Add-LocalGroupMember -Group "Administrators" -Member $username
                Write-Host "User '$username' is now an Administrator!" -ForegroundColor Green
            }

            "12" { return } # Exit back

            default {
                Write-Host "Invalid choice. Please enter a number between 1 and 12." -ForegroundColor Red
            }
        }

        Write-Host "`nPress Enter to continue..."
        Read-Host
    }
    
}
while ($true){
    ShowMenu
    $choice = READ-HOST "Enter your choice(1-7)"
    switch($choice) {
        "1" { SysInfo }
        "2" { FileOperations }
        "3" { NetworkTools }
        "4" { ProcessManagement }
        "5" { DataAnalysis }
        "6" { AccountManagement }
        "7" { WRITE-HOST "Exiting..."; exit }
        default {
            WRITE-HOST "Invalid Choice. Please input a number between 1 and 7." -ForegroundColor Red
            Write-Host "`nPress Enter to continue..."
            Read-Host
        }
    }
}