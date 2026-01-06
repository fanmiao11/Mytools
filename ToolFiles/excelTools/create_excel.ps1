# Create Excel file
try {
    # Create Excel application object
    $excel = New-Object -ComObject Excel.Application
    $excel.Visible = $false
    
    # Create workbook
    $workbook = $excel.Workbooks.Add()
    $worksheet = $workbook.ActiveSheet
    
    # Set worksheet name
    $worksheet.Name = "Sheet1"
    
    # Add data
    $worksheet.Cells.Item(1,1) = "Name"
    $worksheet.Cells.Item(1,2) = "Age"
    $worksheet.Cells.Item(1,3) = "Department"
    
    $worksheet.Cells.Item(2,1) = "Zhang San"
    $worksheet.Cells.Item(2,2) = 25
    $worksheet.Cells.Item(2,3) = "IT"
    
    $worksheet.Cells.Item(3,1) = "Li Si"
    $worksheet.Cells.Item(3,2) = 30
    $worksheet.Cells.Item(3,3) = "Marketing"

    $worksheet.Cells.Item(3,1) = "Li Si"
    $worksheet.Cells.Item(3,2) = 32
    $worksheet.Cells.Item(3,3) = "Marketing"
    
    $worksheet.Cells.Item(4,1) = "Wang Wu"
    $worksheet.Cells.Item(4,2) = 28
    $worksheet.Cells.Item(4,3) = "HR"

    $worksheet.Cells.Item(4,1) = "Wang Wu"
    $worksheet.Cells.Item(4,2) = 30
    $worksheet.Cells.Item(4,3) = "HR"

    $worksheet.Cells.Item(4,1) = "Wang Wu"
    $worksheet.Cells.Item(4,2) = 35
    $worksheet.Cells.Item(4,3) = "HR"

    $worksheet.Cells.Item(4,1) = "Wang Wu"
    $worksheet.Cells.Item(4,2) = 36
    $worksheet.Cells.Item(4,3) = "HR"
    
    # Save file in current directory
    $currentDir = Get-Location
    $filepath = Join-Path $currentDir "NewExcelFile.xlsx"
    $workbook.SaveAs($filepath)
    
    # Close Excel
    $workbook.Close()
    $excel.Quit()
    
    Write-Host "Excel file '$filepath' created successfully!" -ForegroundColor Green
    
} catch {
    Write-Host "Error creating Excel file: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "This might be because Excel is not installed or COM object cannot be accessed"
} finally {
    # Release COM object
    if ($excel) {
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
    }
}